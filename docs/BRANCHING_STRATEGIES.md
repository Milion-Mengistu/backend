# Backend Branching Strategies

## Purpose

This guide defines the Git workflow for the backend repository so changes stay small, reviewable, and safe to merge.

It builds on the project-wide workflow in `reference/docs/WORKFLOW.md` and the task slicing guidance in `reference/docs/TASK_SLICING.md`, but narrows the rules for backend delivery.

## Core Rules

- branch from `main`
- keep branches short-lived
- ship one logical change per branch
- open a PR early and keep it small
- do not push directly to `main`
- update docs in the same PR when API, schema, env vars, or workflow change

## Branching Method

Use a short-lived branch per task or per reviewable slice.

Preferred branch names:

```text
feat/<area>-<short-name>
fix/<area>-<short-name>
docs/<topic>
chore/<topic>
refactor/<topic>
test/<topic>
```

Backend examples:

- `feat/auth-login-endpoint`
- `feat/telemetry-ingestion-validator`
- `fix/db-connection-timeout`
- `docs/auth-flow`
- `refactor/telemetry-service-split`
- `test/health-endpoint`

### Branching Strategy

Use `main` as the stable integration branch.

Recommended flow:

1. update local `main`
2. create a focused branch
3. commit in small logical steps
4. open a PR before the branch grows too large
5. merge after review and passing checks
6. delete the branch after merge

### When to Split Work

Create a new branch instead of extending the current one when:

- the next change affects a different concern
- the PR is likely to go above 300 changed lines
- the PR is likely to touch more than 10 files
- the work depends on another change and should be stacked

Good split:

- PR 1: add request schema
- PR 2: add endpoint using the schema
- PR 3: add docs and follow-up validation cases

Bad split:

- one branch changes auth, telemetry, Docker, tests, and docs together

## Commit Method

Use conventional commits.

Format:

```text
type: short imperative summary
```

Allowed types:

- `feat`
- `fix`
- `docs`
- `chore`
- `refactor`
- `test`

Good examples:

```text
feat: add telemetry ingestion endpoint
fix: handle missing supabase connection string
docs: define backend branching rules
refactor: split auth service from route handler
test: add request validation coverage
chore: add backend ci step for pytest
```

Commit rules:

- one logical change per commit
- keep commit messages specific
- write why through the summary, not vague words
- avoid `update`, `changes`, `misc`, `work`, `final`
- squash or clean up noisy commits before merge if the history is hard to review

### Commit Size Guidance

Prefer:

- one commit for one testable change
- separate docs commits only when they would distract from the code review

Avoid:

- mixing refactor and feature logic in the same commit
- mixing formatting-only changes with behavior changes

## Pull Request Method

Every PR should represent one reviewable backend slice.

Required PR sections:

- Summary
- Why
- Scope
- Test steps
- Risks
- Follow-up work

If API behavior changes, also include:

- request example
- response example
- migration or compatibility note if relevant

If configuration changes, also include:

- new or changed environment variables
- deploy impact

## PR Size Rule

Target:

- under 300 changed lines
- 10 changed files or fewer

These are review targets, not absolute blockers. If a PR exceeds them, split it unless there is a clear reason not to.

Large PRs are acceptable only when:

- generated files are excluded from meaningful review
- a contract change and its direct implementation must land together
- the team agrees the split would create more risk than value

## Review and Merge Rules

Before requesting review:

- run the relevant checks locally
- remove dead code and debug output
- update docs if behavior or workflow changed
- make sure the branch is rebased or merged cleanly with current `main`

Before merge:

- CI passes
- at least one approval is present
- critical review comments are resolved
- the PR description explains validation clearly

## Stacked PR Guidance

Use stacked PRs when backend work has clear dependencies.

Example:

1. `feat/telemetry-schema`
2. `feat/telemetry-ingestion-endpoint`
3. `feat/telemetry-alert-rule`

Rules for stacked PRs:

- each PR must be understandable on its own
- each PR must state its parent PR
- each PR must still stay small
- do not hide unrelated work in later stack layers

## Daily Backend Workflow

Typical command flow:

```bash
git checkout main
git pull origin main
git checkout -b feat/<topic>
git status
make check
git add <files>
git commit -m "feat: <summary>"
git push -u origin feat/<topic>
```

Before opening the PR, verify:

```bash
make lint
make test
make check
```

## Anti-Patterns

Avoid:

- long-running branches that drift far from `main`
- one PR that mixes feature work, refactor, docs cleanup, and tooling cleanup
- force-pushing over teammates without coordination
- merging broken tests because "the next PR will fix it"
- changing contracts without updating docs

## Definition of Done

A backend branch is ready to merge when:

- the branch contains one logical change
- commits are understandable
- the PR is within reviewable size or intentionally justified
- tests and checks relevant to the change pass
- docs are updated where needed
- reviewers can validate the change quickly
