---
name: pickup
description: Start a session from the last handoff, on any machine and any surface. Brings the folder up to date, finds the newest entry in HANDOFF.md, checks it against what is really in the folder, reports in a few lines, and waits before starting work. Works wherever the session has a folder, in Claude Code and in Cowork, local or cloud. Use when the user says pick up, pickup, carry on, resume, where were we, continue from last time, I have switched machines, or agrees to resume after being told that a handoff note exists.
---

# Session pickup

Start where the last session stopped. Read the note, check it against the folder, report, and wait.

## Two hard rules

1. **Pickup changes no files.** The one command that changes anything is `git pull`, and it needs a yes.
2. **The folder outranks the note.** Where `HANDOFF.md` and the folder disagree, the folder is the truth and the note is stale. Report the difference. Do not act on the note.

## Phase 0: locate

- **Workspace root:** the folder that holds `CLAUDE.md`. Failing that, the git top level. Failing that, the session's working folder.
  - No folder in this session: say so and stop.
  - Several connected folders: look for `HANDOFF.md` in each. One has it: use that one. More than one: ask which.
- **Place:** run `scutil --get ComputerName`. It works: this is a Mac, use that name. It fails: this is a sandbox or a cloud session. Use the surface: `Cowork` or `Claude Code cloud`.

If no shell is available, skip every git and place check, say so in one line, and go to phase 2.

## Phase 1: bring the folder up to date

**Git with a remote**

Run `git fetch`. If it fails, say so in one line, carry on with local state, and mark the report "not checked against the remote".

If git is missing, or refuses to run in this folder, say so in one line, skip this phase, and mark the report "not checked against git". Do not change git configuration.

Compare with the upstream using `git rev-list --left-right --count HEAD...@{u}`:

| State | Action |
| :--- | :--- |
| No upstream set for this branch | Say so. Skip the comparison. Carry on. |
| Up to date | Carry on |
| Behind, clean tree | Offer `git pull --ff-only`. Wait for a yes. |
| Behind, changed tree | Stop. List the local changes. Ask what to do. |
| Ahead only | Say that this place has unpushed commits. Carry on. |
| Ahead and behind | Stop. Report both sides. Ask what to do. |

Never stash, reset, merge, rebase or discard to get past a stop.

**A newer note on another branch**

A cloud session pushes to its own branch, so its handoff sits there until the branch is merged. After the fetch:

1. List the ten most recently updated remote branches: `git for-each-ref --sort=-committerdate --count=10 --format='%(refname:short)' refs/remotes`
2. For each, get the date of its newest commit to the note: `git log -1 --format=%cI <ref> -- HANDOFF.md`
3. Compare with the same command on this branch.

If another branch holds a newer note, report the branch and the date. Offer to read that entry in place with `git show <ref>:HANDOFF.md`, which changes nothing. Do not switch branch. Do not merge. Ask.

**iCloud or another sync service**

- `HANDOFF.md` missing but `.HANDOFF.md.icloud` present: the note has not downloaded yet. Say so and stop.
- A file named `HANDOFF 2.md`, or any `<name> 2.<ext>` beside a file the note names: the service made a conflict copy. Report it. Do not merge it.

## Phase 2: read

- `HANDOFF.md`: the top entry only
- `DECISIONS.md`: only the entry the handoff points to
- `CLAUDE.md` is already in context. Do not read it again.

Do not open the files the entry names. Check only that they exist. Do not read older entries or the codebase to "get context".

## Phase 3: check the note against the folder

| Check | How | If it fails, report |
| :--- | :--- | :--- |
| The work arrived | `git cat-file -e <hash>` on the last commit the entry names | The work is not here. It was never pushed, or the pull has not happened. |
| The note is current | Commits newer than the entry, leaving out the handoff commit itself | The note is stale. List the newer commits, five at most. |
| Files exist | Test each path under Files touched | The missing paths |
| The tree is clean | `git status --short` | The changes. Someone worked here after the handoff, or the handoff left them. |
| Same place | Compare this place with the entry heading | Nothing fails. If the place differs, or either one is a sandbox or a cloud session, list the entry's "Only in this place" items as missing here. |
| Age | Entry time against now | Over seven days: state the age |

Skip the git rows when git does not run here.

## Phase 4: report and wait

Eight lines or fewer:

1. Written when, and where
2. Task
3. Done and half done
4. Next step
5. Mismatches from phases 1 and 3, or "The note matches the folder."
6. What is missing in this place, if anything
7. Open questions, if any

Then ask one question and wait:

- The entry has open questions: ask the first one. Work cannot start without it.
- Otherwise: "Start on the next step?"

Do not start work until the user says go.

## The start-of-session notice

In Claude Code, this plugin's SessionStart hook tells Claude when the workspace holds a `HANDOFF.md`, and gives the heading of its newest entry. That notice is not the note, and it is not a request. Tell the user in one line that the note exists, and ask whether to pick up. If the first message is a different task, say the one line and then do the task. Never run pickup unasked.

## No HANDOFF.md

Say so. Then fall back, read-only:

- `git log -5 --oneline`
- The top entry of `DECISIONS.md`
- "Done looks like" from `CLAUDE.md`

Summarise in five lines. Suggest `/session:handoff` at the end of this session. Stop.

## Never

- Change a file
- Pull without a yes
- Switch branch, stash, reset, merge, rebase or discard anything
- Change git configuration or credentials
- Read older entries, or the codebase, to "get context"
- Trust the note over the folder
- Start work before the user says go
