const express = require('express');
const cors = require('cors');
const dns = require('dns');
if (dns.setDefaultResultOrder) {
  dns.setDefaultResultOrder('ipv4first');
}
require('dotenv').config();

const app = express();
const PORT = process.env.PORT || 3000;

// Configured CORS for Flutter Android app, Render deployment, and local development
app.use(cors({
  origin: '*',
  methods: ['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS'],
  allowedHeaders: ['Content-Type', 'Authorization', 'X-Requested-With', 'Accept']
}));
app.use(express.json());

// Log every incoming HTTP request method and URL for debugging
app.use((req, res, next) => {
  console.log(`[RIYAH BACKEND] Incoming ${req.method} request to ${req.originalUrl} from ${req.ip || req.socket.remoteAddress}`);
  next();
});

const { GoogleGenAI } = require('@google/genai');

function getGeminiClient() {
  const apiKey = process.env.GEMINI_API_KEY;
  if (!apiKey || apiKey.trim() === '' || apiKey === 'your_key_here') {
    return null;
  }
  return new GoogleGenAI({ apiKey });
}

// Log API Key presence safely without exposing key
const apiKeyPresent = !!(process.env.GEMINI_API_KEY && process.env.GEMINI_API_KEY.trim() !== '' && process.env.GEMINI_API_KEY !== 'your_key_here');
console.log(`GEMINI_API_KEY loaded: ${apiKeyPresent}`);

// User System Instruction for Riyah OS AI Tutor
const SYSTEM_INSTRUCTION = `You are Riyah, an AI Operating Systems tutor inside an educational learning platform.

Your purpose is to teach students rather than simply give answers.

Use beginner-friendly language and explain concepts clearly.

For conceptual questions:
- explain the concept simply
- use examples when useful
- explain important terminology

For numerical/problem-solving questions:
- identify the given values
- explain the relevant OS concept
- solve step-by-step
- show the final answer clearly

For Solve With Me mode:
- guide the student step-by-step
- give hints
- do not immediately reveal the complete answer unless requested

For Code Tutor:
- explain C, C++, Java or related code
- explain important lines and logic
- help the student understand rather than blindly copy code

For Generate Practice:
- generate questions related to the requested OS topic
- vary difficulty
- provide answers/explanations when requested

For Quiz Me:
- ask one question at a time
- wait for the student's answer
- evaluate it
- explain mistakes

Stay focused on Operating Systems and related programming concepts.`;

const PRIMARY_MODEL = 'gemini-3.6-flash';
const FALLBACK_MODELS = [
  'gemini-2.5-flash',
  'gemini-3.5-flash',
  'gemini-3.1-flash-lite'
];

const delay = (ms) => new Promise((resolve) => setTimeout(resolve, ms));

function isPermanentError(err) {
  if (!err) return false;
  const status = err.status || err.statusCode || err.error?.code;
  const msg = (err.message || JSON.stringify(err)).toLowerCase();

  if (status === 400 || status === 401 || status === 403 || status === 404) {
    return true;
  }

  if (
    msg.includes('400') || msg.includes('401') || msg.includes('403') || msg.includes('404') ||
    msg.includes('invalid argument') || msg.includes('unauthorized') ||
    msg.includes('permission denied') || msg.includes('not found') ||
    msg.includes('api key')
  ) {
    return true;
  }

  return false;
}

function is503Error(err) {
  if (!err) return false;
  const status = err.status || err.statusCode || err.error?.code;
  const msg = (err.message || JSON.stringify(err)).toLowerCase();

  return (
    status === 503 ||
    msg.includes('503') ||
    msg.includes('unavailable') ||
    msg.includes('high demand') ||
    msg.includes('overloaded') ||
    msg.includes('resource_exhausted') ||
    msg.includes('service unavailable')
  );
}

async function generateRiyahResponseWithRetry(ai, userPrompt, mode, context) {
  let fullPrompt = `[CURRENT MODE]: ${mode || 'ask_tutor'}\n`;

  if (context) {
    fullPrompt += `[ACTIVE STUDY CONTEXT]:\n`;
    if (context.categoryName) fullPrompt += `- Category: ${context.categoryName}\n`;
    if (context.topicTitle) fullPrompt += `- Topic: ${context.topicTitle}\n`;
    if (context.subtopicTitle) fullPrompt += `- Subtopic: ${context.subtopicTitle}\n`;
    if (context.questionText) fullPrompt += `- Exam/Practice Question: ${context.questionText}\n`;
    if (context.selectedAnswer) fullPrompt += `- Student's Selected Answer: ${context.selectedAnswer}\n`;
    if (context.correctAnswer) fullPrompt += `- Official Correct Answer: ${context.correctAnswer}\n`;
    if (context.difficulty) fullPrompt += `- Difficulty: ${context.difficulty}\n`;
    fullPrompt += `\n`;
  }

  fullPrompt += `[STUDENT QUESTION/PROMPT]: ${userPrompt}\n`;

  let lastError = null;

  // --- Requirement 1 & 2: Primary model gemini-3.6-flash with 1 retry (2 attempts total) on 503 ---
  console.log(`[RIYAH] Attempting primary model: ${PRIMARY_MODEL} (Attempt 1/2)`);
  for (let attempt = 1; attempt <= 2; attempt++) {
    const startTime = Date.now();
    try {
      if (attempt > 1) {
        const backoffMs = 1000;
        console.log(`[RIYAH] 503/Transient error on ${PRIMARY_MODEL} (Attempt 1/2). Retrying in ${backoffMs}ms...`);
        await delay(backoffMs);
      }

      console.log(`[RIYAH] Gemini request started for model: ${PRIMARY_MODEL}`);
      const response = await ai.models.generateContent({
        model: PRIMARY_MODEL,
        contents: fullPrompt,
        config: {
          systemInstruction: SYSTEM_INSTRUCTION,
          temperature: 0.7,
        }
      });

      const duration = Date.now() - startTime;
      const text = response.text;
      if (text && text.trim().length > 0) {
        console.log(`[RIYAH] Gemini response received in ${duration}ms using model: ${PRIMARY_MODEL} | Fallback triggered: false`);
        return { text: text.trim(), modelUsed: PRIMARY_MODEL, fallbackTriggered: false };
      }
    } catch (err) {
      lastError = err;
      const duration = Date.now() - startTime;
      const errMsg = err.message || JSON.stringify(err);
      const errStatus = err.status || err.statusCode || err.error?.code;

      console.log(`[RIYAH] Request failed for primary model ${PRIMARY_MODEL} (Attempt ${attempt}/2) after ${duration}ms`);
      console.log(`[RIYAH] Error status: ${errStatus || 'N/A'} | Error message: ${errMsg.slice(0, 200)}`);

      // Permanent errors (400, 401, 403, 404): DO NOT retry
      if (isPermanentError(err)) {
        console.log(`[RIYAH] Permanent error encountered on ${PRIMARY_MODEL} (${errStatus || 'PERMANENT'}). Aborting retries and fallback.`);
        throw err;
      }
    }
  }

  // --- Fallback Strategy ---
  console.log(`[RIYAH] Fallback triggered! Primary model ${PRIMARY_MODEL} failed after 2 attempts. Error: ${lastError?.message || '503 UNAVAILABLE'}`);

  for (const fallbackModel of FALLBACK_MODELS) {
    console.log(`[RIYAH] Attempting fallback model: ${fallbackModel}`);
    const startTime = Date.now();
    try {
      const response = await ai.models.generateContent({
        model: fallbackModel,
        contents: fullPrompt,
        config: {
          systemInstruction: SYSTEM_INSTRUCTION,
          temperature: 0.7,
        }
      });

      const duration = Date.now() - startTime;
      const text = response.text;
      if (text && text.trim().length > 0) {
        console.log(`[RIYAH] SUCCESS! Gemini response received in ${duration}ms using fallback model: ${fallbackModel} | Fallback triggered: true`);
        return { text: text.trim(), modelUsed: fallbackModel, fallbackTriggered: true };
      }
    } catch (fallbackErr) {
      lastError = fallbackErr;
      const duration = Date.now() - startTime;
      const errMsg = fallbackErr.message || JSON.stringify(fallbackErr);
      const errStatus = fallbackErr.status || fallbackErr.statusCode || fallbackErr.error?.code;

      console.log(`[RIYAH] Fallback model ${fallbackModel} failed after ${duration}ms`);
      console.log(`[RIYAH] Error status: ${errStatus || 'N/A'} | Message: ${errMsg.slice(0, 200)}`);

      if (isPermanentError(fallbackErr) && errStatus !== 404 && !errMsg.includes('404') && !errMsg.includes('not available')) {
        throw fallbackErr;
      }
    }
  }

  // High demand error if all models fail
  console.log(`[RIYAH] All primary and fallback Gemini models failed.`);
  const demandError = new Error("Riyah AI is temporarily experiencing high demand. Please try again shortly.");
  demandError.status = 503;
  demandError.code = "SERVICE_UNAVAILABLE";
  throw demandError;
}

// User-specified Health Check Endpoint (GET /api/health)
app.get('/api/health', (req, res) => {
  res.setHeader('Content-Type', 'application/json; charset=utf-8');
  res.json({
    success: true,
    message: "Backend is running",
    timestamp: new Date().toISOString()
  });
});

// Alias Health Check Endpoint (GET /api/riyah/health)
app.get('/api/riyah/health', (req, res) => {
  res.setHeader('Content-Type', 'application/json; charset=utf-8');
  const ai = getGeminiClient();
  res.json({
    success: true,
    message: "Backend is running",
    service: 'Riyah Gemini AI Tutor Backend',
    apiKeyConfigured: !!ai,
    primaryModel: PRIMARY_MODEL,
    fallbackModels: FALLBACK_MODELS,
    timestamp: new Date().toISOString()
  });
});

// Explicit POST handler for Riyah Chat (supports both /api/riyah/chat and /api/riyah/chat/)
const handleRiyahChatPost = async (req, res) => {
  const reqStartTime = Date.now();
  console.log(`[RIYAH] Request received from ${req.ip || req.socket.remoteAddress}`);
  
  // Set explicit JSON Content-Type header
  res.setHeader('Content-Type', 'application/json; charset=utf-8');

  try {
    const ai = getGeminiClient();
    if (!ai) {
      console.log(`[RIYAH] Gemini request failed: MISSING_API_KEY`);
      const errorPayload = {
        success: false,
        error: "GEMINI_API_KEY is missing or invalid on backend server.",
        code: "MISSING_API_KEY"
      };
      console.log(`[RIYAH] Sending error JSON response to Flutter (Status 401):\n`, JSON.stringify(errorPayload, null, 2));
      return res.status(401).json(errorPayload);
    }

    const { message, mode, topic, subtopic, question, userAnswer, categoryName, correctAnswer, difficulty } = req.body || {};

    const userPrompt = message || topic || question || "Hello Riyah";
    const selectedMode = mode || "ask_tutor";

    const contextData = {
      categoryName,
      topicTitle: topic,
      subtopicTitle: subtopic,
      questionText: question,
      selectedAnswer: userAnswer,
      correctAnswer,
      difficulty
    };

    // 40-second backend timeout so backend responds with JSON before frontend 60s timeout
    const timeoutPromise = new Promise((_, reject) =>
      setTimeout(() => reject(new Error("GATEWAY_TIMEOUT")), 40000)
    );

    const { text: replyText, modelUsed, fallbackTriggered } = await Promise.race([
      generateRiyahResponseWithRetry(ai, userPrompt, selectedMode, contextData),
      timeoutPromise
    ]);

    const totalDuration = Date.now() - reqStartTime;
    console.log(`[RIYAH] Request succeeded in ${totalDuration}ms | Model used: ${modelUsed} | Fallback triggered: ${fallbackTriggered}`);

    const successPayload = {
      success: true,
      response: replyText,
      message: replyText,
      reply: replyText,
      mode: selectedMode,
      modelUsed: modelUsed,
      fallbackTriggered: fallbackTriggered,
      timestamp: new Date().toISOString()
    };

    console.log(`[RIYAH] Sending JSON response to Flutter (Status 200):\n`, JSON.stringify(successPayload, null, 2));
    return res.status(200).json(successPayload);

  } catch (error) {
    const totalDuration = Date.now() - reqStartTime;
    console.log(`[RIYAH] Gemini request failed after ${totalDuration}ms: ${error.message || 'Unexpected error'}`);

    let status = error.status || error.statusCode || 500;
    let errorMessage = error.message || "An unexpected error occurred while communicating with Gemini API.";
    let errorCode = error.code || "GEMINI_SERVER_ERROR";

    if (error.message === "GATEWAY_TIMEOUT") {
      status = 504;
      errorMessage = "Riyah request timed out while waiting for AI response. Please try again.";
      errorCode = "TIMEOUT";
    } else if (status === 400 || errorMessage.includes('400') || errorMessage.toLowerCase().includes('invalid request')) {
      status = 400;
      errorMessage = `Bad Request (400): ${errorMessage}`;
      errorCode = "INVALID_REQUEST";
    } else if (status === 401 || errorMessage.includes('401') || errorMessage.toLowerCase().includes('api key') || errorMessage.toLowerCase().includes('unauthorized')) {
      status = 401;
      errorMessage = "Unauthorized (401): Invalid or missing GEMINI_API_KEY.";
      errorCode = "INVALID_API_KEY";
    } else if (status === 403 || errorMessage.includes('403') || errorMessage.toLowerCase().includes('permission')) {
      status = 403;
      errorMessage = "Forbidden (403): Gemini API permission denied.";
      errorCode = "PERMISSION_DENIED";
    } else if (status === 404 || errorMessage.includes('404') || errorMessage.toLowerCase().includes('not found')) {
      status = 404;
      errorMessage = "Not Found (404): Gemini model not found.";
      errorCode = "MODEL_NOT_FOUND";
    } else if (status === 429 || errorMessage.includes('429') || errorMessage.toLowerCase().includes('quota') || errorMessage.toLowerCase().includes('rate limit')) {
      status = 429;
      errorMessage = "Rate Limit (429): Gemini API rate limit or quota exceeded. Please wait a moment.";
      errorCode = "RATE_LIMIT";
    } else if (status === 503 || is503Error(error)) {
      status = 503;
      errorMessage = "Riyah AI is temporarily experiencing high demand. Please try again shortly.";
      errorCode = "SERVICE_UNAVAILABLE";
    }

    const errorPayload = {
      success: false,
      error: errorMessage,
      code: errorCode
    };

    console.log(`[RIYAH] Sending error JSON response to Flutter (Status ${status}):\n`, JSON.stringify(errorPayload, null, 2));
    return res.status(status).json(errorPayload);
  }
};

app.post('/api/riyah/chat', handleRiyahChatPost);
app.post('/api/riyah/chat/', handleRiyahChatPost);

// GET /api/riyah/chat handler (Inform user that POST is required with valid JSON error)
const handleRiyahChatGetError = (req, res) => {
  res.setHeader('Content-Type', 'application/json; charset=utf-8');
  const errorPayload = {
    success: false,
    error: "HTTP GET is not supported for /api/riyah/chat. Please send an HTTP POST request with a JSON body.",
    code: "METHOD_NOT_ALLOWED"
  };
  console.log(`[RIYAH] Sending 405 error JSON response to Flutter:\n`, JSON.stringify(errorPayload, null, 2));
  return res.status(405).json(errorPayload);
};

app.get('/api/riyah/chat', handleRiyahChatGetError);
app.get('/api/riyah/chat/', handleRiyahChatGetError);

// Global Error Handler Middleware (Guarantees JSON output, prevents HTML error responses)
app.use((err, req, res, next) => {
  console.error(`[RIYAH BACKEND] Unhandled Express Error:`, err.message || err);
  res.setHeader('Content-Type', 'application/json; charset=utf-8');
  const status = err.status || err.statusCode || 500;
  const errorPayload = {
    success: false,
    error: err.message || "An internal backend error occurred.",
    code: err.code || "INTERNAL_SERVER_ERROR"
  };
  console.log(`[RIYAH] Sending error JSON response to Flutter (Status ${status}):\n`, JSON.stringify(errorPayload, null, 2));
  return res.status(status).json(errorPayload);
});

// Fallback 404 Handler for Unmatched Routes (Guarantees JSON output, prevents HTML 404 responses)
app.use((req, res) => {
  res.setHeader('Content-Type', 'application/json; charset=utf-8');
  const errorPayload = {
    success: false,
    error: `Endpoint not found: ${req.method} ${req.originalUrl}`,
    code: "NOT_FOUND"
  };
  console.log(`[RIYAH] Sending 404 JSON response to Flutter:\n`, JSON.stringify(errorPayload, null, 2));
  return res.status(404).json(errorPayload);
});

app.listen(PORT, '0.0.0.0', () => {
  console.log(`=================================================`);
  console.log(`  Riyah AI Tutor Backend Server running on port ${PORT}`);
  console.log(`  Health Endpoint: http://localhost:${PORT}/api/health`);
  console.log(`  Local Endpoint:  http://localhost:${PORT}/api/riyah/chat`);
  console.log(`  LAN Endpoint:    http://10.63.46.252:${PORT}/api/riyah/chat`);
  console.log(`  GEMINI_API_KEY loaded: ${apiKeyPresent}`);
  console.log(`=================================================`);
});
