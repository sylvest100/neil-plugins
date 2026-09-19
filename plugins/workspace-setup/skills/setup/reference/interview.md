# Interview

One question at a time. Wait for each answer.

Where the inspection already answers a question, do not ask it blank. Put the finding to the user as a statement to confirm or correct:

> "This looks like a TypeScript project using Vite and pnpm, with tests under `tests/`. Correct?"

not

> "What stack are you using?"

Skip any question whose answer is already in an existing `CLAUDE.md` or `DECISIONS.md`.

---

## Tier 0 - Task

No interview beyond the sizing gate.

Ask one question only if the folder holds something that could be damaged, for example a source workbook, a dataset, or a folder of originals:

1. Is there anything here that must not be changed or overwritten?

Then go straight to the plan. If the answer is no, the plan is a ten-line `CLAUDE.md` and nothing else.

---

## Tier 1 - Small recurring

Four questions.

1. What is this, in one sentence?
2. What does finished look like here?
3. Is there anything that must never happen in this folder?
4. Where does the truth live: an existing file, another folder, a website, a person?

---

## Tier 2 - Project

Ten questions, in four blocks. Keep the block headings out of the conversation. Just ask.

### Purpose

1. What is this, in one sentence?
2. Who or what consumes the output: you, a team, a server, a customer?

### Constraints

3. Stack and versions: fixed or open? (Put the inspection's finding to them instead, where there is one.)
4. What must never happen here? Writes to production, network calls, changes to a named file, new dependencies.

### Working agreement

5. Should Claude propose changes before making them, or make them and report?
6. Any branch or commit convention to follow?
7. What has to pass before a change counts as done: tests, a build, a lint, a manual check?

### Context and continuity

8. Where does truth live: other repos, existing docs, an API, credentials?
9. How is work tracked between sessions: a decision log here, GitHub issues, nothing?
10. What about this project would not be obvious from reading the files?

Question 10 usually produces the single most useful paragraph in the finished setup. Ask it last and do not rush the answer.

---

## Tier 3 - System

The ten tier 2 questions, plus a component map.

After question 10, ask:

11. What are the parts, and what does each one do?
12. Which parts have different rules from the rest?

Each part named in 11 gets a section in `docs/CONTEXT.md`. Only a part with genuinely different rules, from 12, gets its own `CLAUDE.md` in its subfolder. Do not create per-folder `CLAUDE.md` files just because subfolders exist.

---

## Answer handling

- A short or vague answer is fine. Record it as given. Do not press for detail the user has not offered.
- "I do not know yet" is a valid answer. Write `Not decided yet` in the file rather than inventing something.
- If an answer contradicts what the inspection found, the answer wins. Note the correction in `DECISIONS.md`.
