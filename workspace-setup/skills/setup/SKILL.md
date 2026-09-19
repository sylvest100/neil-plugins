---
name: setup
description: Turn a folder into a prepared Claude Code workspace. Inspects what is already there, sizes the scaffold to the job with a two-question gate, interviews the user one question at a time, then writes CLAUDE.md and supporting files only after the plan is approved. Use when the user asks to set up this folder, prepare a workspace, initialise or start a project here, get a folder ready for Claude Code, or when re-running in a folder that already has a CLAUDE.md to promote it to a larger tier.
---

# Workspace setup

Prepare a folder for Claude Code work. The scaffold is sized to the job. Nothing is issued by default.

## Two hard rules

1. **Nothing is written before the plan is approved.** Phases 0 to 3 are read-only.
2. **Additive only.** Never delete. Never overwrite. If a file already exists, show the proposed change as a diff and leave the file untouched until the user approves it.

## Phase 0: inspect

Write nothing. Gather:

- Tree to depth 3, ignoring `node_modules`, `.git`, `dist`, `build`, `.venv`, `__pycache__`
- File count and rough total size
- Whether `.git` exists, and `git status --short` if it does
- Existing `CLAUDE.md`, `.claude/`, `README*`, `DECISIONS.md`, `docs/`
- Manifests and lockfiles: `package.json`, `pyproject.toml`, `requirements.txt`, `Cargo.toml`, `go.mod`, `*.xcodeproj`, `index.html`
- Document and data files: `.md`, `.docx`, `.pdf`, `.xlsx`, `.csv`

Read at most five files, and only enough of each to work out what the folder is for. Do not read the whole codebase.

If a `CLAUDE.md` already exists, this is a **re-run**. Read it and any `DECISIONS.md`, then go to "Re-runs and promotion" at the end of this file.

## Phase 1: classify

| Class | Signals |
| :--- | :--- |
| Empty | No files, or only `.DS_Store` and similar |
| Code | A manifest, a lockfile, or source files in a known language |
| Documents | Mostly `.md`, `.docx`, `.pdf`, no manifest |
| Data | Mostly `.csv`, `.xlsx`, `.json` data files |
| Mixed | No clear majority, or contents that do not cohere |

State the class and the confidence in one line. If confidence is low, say so. Do not guess.

## Phase 2: sizing gate

Report the inventory in no more than six lines. Propose a tier from what the inspection shows, then ask the two gate questions **one at a time**, waiting for each answer:

1. How long does this folder need to last: one sitting, a few sessions, or ongoing?
2. What comes out of it: a file or two, a working thing you run, or a system with parts?

Map the answers:

| Lifespan | Output | Tier |
| :--- | :--- | :--- |
| One sitting | File or two | 0 - Task |
| A few sessions | File or two, or small script | 1 - Small recurring |
| Ongoing | Working thing you run | 2 - Project |
| Ongoing | System with parts | 3 - System |

**Where the answers straddle two tiers, take the lower one.** Under-scaffolding costs one command later. Over-scaffolding costs context in every session for the life of the folder.

## Phase 3: interview

Read `reference/interview.md` and run the question set for the chosen tier.

Rules that apply to every tier:

- **One question at a time.** Wait for the answer before asking the next.
- Where the inspection already answers a question, do not ask it. State the finding and ask the user to confirm or correct it. Corrections are the most valuable content in the finished `CLAUDE.md`.
- Do not ask about anything the tier does not need.

## Phase 4: plan

Read `reference/profiles.md` for the file set that matches the tier and class. Then show:

- Every file to be created, with its purpose and rough line count
- Any existing file that would be changed, as a diff
- Whether `git init` is being offered, and why

Stop. Wait for approval. Do not write anything yet.

## Phase 5: write

Write the approved files, using the templates in `reference/templates/`. Fill every placeholder from the interview answers. Never leave a `<placeholder>` in a written file.

`CLAUDE.md` line budgets are hard limits, because that file is loaded into context in every session in this folder:

| Tier | Budget |
| :--- | :--- |
| 0 | 10 lines |
| 1 | 30 lines |
| 2 | 60 lines |
| 3 | 60 lines, plus per-area files in `docs/` |

If the content does not fit, move detail into `docs/CONTEXT.md` and point at it from `CLAUDE.md`. Do not raise the budget.

Every `CLAUDE.md` carries the house rules block from the template, unchanged.

## Phase 6: verify and hand over

- List what was written
- Confirm the `CLAUDE.md` line count is within budget
- Suggest the first sensible command in this folder
- Say nothing else

## Git

If `.git` is absent, offer it once, in one line: git keeps a history of every change so a bad edit can be undone, and nothing leaves the machine unless it is pushed. Run `git init` only if the user says yes. Never run it unasked. Do not offer it at all for tier 0.

## Re-runs and promotion

When `CLAUDE.md` already exists:

1. Read `CLAUDE.md` and `DECISIONS.md` and report the current tier
2. Ask one question: has the work outgrown that tier?
3. If yes, ask only the questions the new tier adds that the existing files do not already answer
4. Plan the additions, get approval, and write them

Never re-run the full interview on a folder that has already been set up. Never rewrite an existing `CLAUDE.md` wholesale. Add sections to it and show the diff first.

## Never

- Write before approval
- Overwrite or delete anything
- Create an empty directory that nothing has asked for
- Scaffold `src/` and `tests/` in a folder that is not a code project
- Run `git init` without a yes
- Exceed the `CLAUDE.md` line budget
