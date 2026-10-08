# OS Learning Platform

An interactive, modern educational platform designed for Operating Systems (OS) students and faculty. The platform combines visual algorithm visualizers, topic modules, practice questions, exam vaults, bookmarking, and **Riyah** — an AI-powered OS tutor backed by Google Gemini.

---

## 🛠️ Main Technologies

- **Flutter / Dart**: Cross-platform mobile & desktop frontend UI.
- **Node.js & Express**: Lightweight backend API server for Riyah AI.
- **Google Gemini API (`@google/genai`)**: AI reasoning engine powering Riyah tutor modes.
- **Supabase**: Authentication, user profile storage, learning progress, and bookmarking.

---

## 📁 Basic Project Structure

```text
os_learning_platform/
│
├── lib/                        # Flutter Mobile Application
│   ├── main.dart               # Entry point
│   ├── app/                    # Global app configuration and routes
│   ├── core/                   # Shared theme, widgets, and services (Supabase)
│   └── features/               # Modular features (AI Tutor, Learn, Practice, Profile, Auth)
│       └── ai_tutor/           # Riyah UI & central AITutorService
│
├── backend/                    # Express Node.js Backend (Render Ready)
│   ├── server.js               # Main Express server (Gemini API integration)
│   ├── package.json            # Node.js dependencies
│   ├── package-lock.json       # Dependency lock file
│   ├── render.yaml             # Render infrastructure configuration
│   └── .env.example            # Environment variable placeholders
│
├── supabase/                   # Database schema & RLS policies
│   └── schema.sql              # Supabase SQL setup script
│
├── pubspec.yaml                # Flutter project manifest
├── pubspec.lock                # Flutter dependency lock file
├── .env.example                # Root environment template
├── .gitignore                  # Git tracking rules
└── README.md                   # Project documentation
```

---

## 🚀 How to Run the Backend

1. Navigate to the `backend/` directory:
   ```bash
   cd backend
   ```
2. Install Node.js dependencies:
   ```bash
   npm install
   ```
3. Create a `.env` file inside `backend/` (refer to `backend/.env.example`):
   ```env
   GEMINI_API_KEY=your_gemini_api_key_here
   PORT=3000
   ```
4. Start the server:
   ```bash
   npm start
   ```
   * Server runs locally on `http://localhost:3000`.

---

## 📱 How to Run the Flutter Frontend

1. Fetch dependencies:
   ```bash
   flutter pub get
   ```
2. Run the application:
   ```bash
   flutter run
   ```
3. To specify a custom production backend URL:
   ```bash
   flutter run --dart-define=BACKEND_URL=https://your-backend-app.onrender.com
   ```

---

## 🔑 Required Environment Variables

| Variable | Required In | Description |
|---|---|---|
| `GEMINI_API_KEY` | Backend | Google Gemini API key for Riyah AI Tutor |
| `PORT` | Backend | HTTP Port (defaults to `3000` locally, `10000` on Render) |
| `SUPABASE_URL` | Flutter / Backend | Supabase project URL |
| `SUPABASE_PUBLISHABLE_KEY` | Flutter | Supabase anonymous publishable key |

---

## 📡 How Flutter Communicates with the Backend

Flutter communicates with the Express backend via `AITutorService` (`lib/features/ai_tutor/services/ai_tutor_service.dart`):

1. Sends `POST /api/riyah/chat` containing user message, mode (`ask_tutor`, `explain_simply`, `solve_with_me`, etc.), and active study context.
2. The backend attempts completion using primary model `gemini-3.6-flash`.
3. If temporary high demand (503) occurs, the backend automatically retries with backoff and falls back to secondary models (`gemini-2.5-flash`, `gemini-3.5-flash`, `gemini-3.1-flash-lite`).
4. The backend returns a structured JSON payload (`{ "success": true, "response": "..." }`).

---

## ☁️ Render Backend Deployment

1. Connect the GitHub repository to **Render**.
2. Create a new **Web Service**.
3. Set **Root Directory** to `backend`.
4. Set **Build Command** to `npm install`.
5. Set **Start Command** to `npm start`.
6. Environment variable `GEMINI_API_KEY` must be added in the Render Dashboard under **Environment**.

---

## 🐙 Git & GitHub Commands

```bash
# Initialize git repository at root
git init

# Stage all files (.env and node_modules are automatically ignored)
git add .

# Commit changes
git commit -m "Cleaned and simplified OS Learning Platform codebase"

# Push to GitHub
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/os-learning-platform.git
git push -u origin main
```
