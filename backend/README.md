# CloudOptimizer

This workspace contains the Terraform infrastructure for CloudOptimizer and a new frontend and backend application layer that uses mock data for now.

## Structure

- frontend/: React + TypeScript + Vite UI for the cloud operations dashboard
- backend/: FastAPI API with mock endpoints for dashboard, resources, recommendations, reports, settings, and health
- terraform/: Existing AWS infrastructure; unchanged

## Run locally

### Backend

```bash
cd backend
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
uvicorn app.main:app --reload --port 8000
```

### Frontend

```bash
cd frontend
npm install
npm run dev
```
