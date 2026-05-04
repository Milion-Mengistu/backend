HOST ?= 0.0.0.0
PORT ?= 8000
UV_RUN ?= uv run

.PHONY: bootstrap dev render-build render-start lint test check ai-node ai-python

bootstrap:
	uv sync --all-groups
	npm ci

dev:
	$(UV_RUN) uvicorn analytics.main:app --reload --host $(HOST) --port $(PORT)

render-build:
	uv sync --all-groups --frozen
	npm ci

render-start:
	$(UV_RUN) uvicorn analytics.main:app --host $(HOST) --port $(PORT)

lint:
	uv run ruff check .
	npm run lint

test:
	uv run pytest

check: lint test

ai-node:
	npm run ai:check

ai-python:
	uv run python -c "from analytics.config import settings; print(f'AI runtime: {settings.ai_runtime}, model: {settings.openai_model}')"
