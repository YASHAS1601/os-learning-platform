# Riyah AI Tutor Backend Service

Node.js Express backend service powering Riyah AI Tutor in the OS Learning Platform.

---

## Features
- **Primary Model**: `gemini-3.6-flash`
- **Automatic 503 Retry**: Retries primary model ONCE on transient HTTP 503 errors.
- **Model Fallback**: Automatically falls back to stable Flash models (`gemini-2.5-flash`, `gemini-3.5-flash`, `gemini-3.1-flash-lite`) if primary model is unavailable.
- **Permanent Error Shield**: Immediately throws permanent errors (400, 401, 403, 404) without retrying.
- **Render Ready**: Configured to run out-of-the-box on Render with `npm start` listening on `0.0.0.0:${PORT}`.

---

## Quick Start

### 1. Install Dependencies
```bash
npm install
```

### 2. Configure Environment Variables
Create `.env`:
```env
PORT=3000
GEMINI_API_KEY=your_gemini_api_key_here
```

### 3. Run Backend Locally
```bash
npm start
```

---

## Render Deployment Settings
- **Root Directory**: `backend`
- **Build Command**: `npm install`
- **Start Command**: `npm start`
- **Environment Variables**: `GEMINI_API_KEY`, `PORT`
