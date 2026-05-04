PYTHON ?= uv run

.PHONY: bootstrap dev lint test check ai-node ai-python

bootstrap:
	uv sync --all-groups
	npm install

dev:
	uv run uvicorn analytics.main:app --reload --host 0.0.0.0 --port 8000

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
