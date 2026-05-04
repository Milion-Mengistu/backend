# AI Development

This repo supports AI development from either Python or Node.

## When To Use Python

Use Python when:

- the feature lives inside the FastAPI request path
- the AI step needs direct database or backend module access
- the team wants one runtime in production for the whole request flow

Python dependencies for AI live in the `ai` dependency group in `pyproject.toml`.

## When To Use Node

Use Node when:

- an SDK or example lands earlier in JS than Python
- you are building internal tools, scripts, or rapid experiments
- you want TypeScript types around structured AI input and output

Node helpers live in `tools/ai/`.

## Shared Rules

- Read secrets from `.env`
- Keep prompts and schemas close to the feature using them
- Validate model output before it reaches API responses or database writes
- Promote successful experiments into tested backend code quickly
