# Development Guide

## Prerequisites

- Python `3.11+`
- `uv`
- Node.js `20`
- npm

## Bootstrap

```bash
cp .env.example .env
uv sync --all-groups
npm install
```

## Daily Workflow

Start the backend:

```bash
make dev
```

Run checks before pushing:

```bash
make check
```

## Environment Variables

- `APP_ENV`: `development`, `staging`, or `production`
- `SUPABASE_DB_URL`: direct Postgres connection string
- `TELEMETRY_TABLE`: table used by telemetry queries
- `OPENAI_API_KEY`: shared AI provider key for both runtimes
- `OPENAI_MODEL`: default model name
- `AI_RUNTIME`: team hint for where a feature should run first

## Development Conventions

- Put HTTP and database code in `analytics/`
- Put Node-only AI helpers in `tools/ai/`
- Keep business logic portable where possible so Node or Python AI experiments can be promoted into the main backend cleanly
- Do not return provider or database exception text directly to API clients
