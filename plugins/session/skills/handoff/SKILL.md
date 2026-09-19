---
name: handoff
description: Write down the state of this session so the next session can carry on, on any machine and any surface. Drafts a dated entry for HANDOFF.md, logs decisions to DECISIONS.md if that file exists, shows both for approval, then offers a git commit and a push. Works wherever the session has a folder, in Claude Code and in Cowork, local or cloud. Use when the user says hand off, handoff, wrap up, close the session, save where we are, I am switching machines, or I am stopping for the day.
---

# Session handoff

Write down the state of this session so the next one can carry on. The next session starts cold. It knows only what is in the folder. It may run on another machine, or on another surface.

## Two hard rules

1. **Nothing is written before the entries are approved.** Phases 0 to 3 are read-only.
2. **Additive only.** Never delete. Never overwrite. A new entry goes above the old ones. Nothing already in a file changes.

## Phase 0: inspect

Write nothing. Gather:

- **Workspace root:** the folder that holds `CLAUDE.md`. Failing that, the git top level. Failing that, the session's working folder. State which was used.
  - No folder in this session: say "There is no working folder in this session, so there is nowhere to write a handoff" and stop.
  - Several connected folders, and no way to tell which one the work was in: ask which one.
- **Place:** run `scutil --get ComputerName`.
  - It works: this is a Mac. Use that name.
  - It fails: this is a sandbox or a cloud session, and its hostname means nothing. Use the surface instead: `Cowork` or `Claude Code cloud`. If the user has said which Mac the session runs on, add it: `Cowork on Mac Studio`.
- **Time:** `date "+%Y-%m-%d %H:%M %z"`.
- **Git,** if `.git` exists: branch, `git status --short`, `git remote`, the last commit as short hash and subject, and unpushed commits with `git log @{u}.. --oneline` if an upstream is set.
  - Git is missing, or refuses to run in this folder: say so in one line and skip the git checks. Do not change git configuration. The route is still Git, and the commit and the push must be done from a terminal on the Mac.
- **Existing notes:** the top entry of `HANDOFF.md`, and whether `DECISIONS.md` exists. Read no older entries.
- **Sync route,** from this table:

| Finding | Route |
| :--- | :--- |
| A git remote exists | Git. The note travels when it is pushed. |
| On a Mac, the path is under `~/Library/Mobile Documents/` | iCloud |
| On a Mac, the path is under `~/Library/CloudStorage/` or `~/Dropbox` | That service |
| On a Mac, none of these | Nowhere. The note stays on this machine. |
| In a sandbox or a cloud session, no git remote | Not visible from here. The path is a mount point and proves nothing. Use the route that the top entry of `HANDOFF.md` records. No entry: ask once how this folder reaches the other machine. |

If no shell is available, skip the place and git checks, say so in one line, and carry on.

If nothing has changed since the top entry of `HANDOFF.md`, say "Nothing to hand off" and stop.

## Phase 1: what travels

Only when git runs here and the working tree has changes. Otherwise skip this phase.

List the uncommitted and untracked files. Say plainly that they stay where they are unless they are committed and pushed. Ask one question and wait:

> What happens to these: commit them with the handoff, park them on a `wip/` branch, or leave them here?

The answer goes into the **Git** line of the entry, so the entry states truthfully what the next session will and will not receive.

## Phase 2: draft the handoff entry

Read `reference/entry-template.md`. Fill it from this session.

- Write for a reader who has seen none of this conversation.
- **Next step is one concrete action,** with the file and the command. "Continue the refactor" is not a next step. "Write the date branch of `parseRow()` in `src/import.ts`, then run `npm test`" is.
- Half-done work is the most valuable line in the entry. Say exactly how far it got.
- List anything that exists only in this place: running servers, environment variables, local data, files outside the workspace. In a sandbox or a cloud session, that includes anything installed or created outside the folder. It is gone when the session ends.
- One line for each approach tried and dropped, so the next session does not try it again.
- Name files and lines. Do not paste code, logs or output.
- Never write a secret into the entry: no keys, tokens, passwords or `.env` values. The file is committed and may be pushed to a public repository.
- **Budget: 25 lines.** If it does not fit, it is recording history and not state. Cut it.
- Never leave a `<placeholder>` in the entry. Delete a block that has nothing in it.

## Phase 3: draft the decisions entry

Only if `DECISIONS.md` exists. The test is the same as the checkpoint command: a decision is something that closed off an option. A choice made, a constraint accepted, an approach abandoned, a correction to an earlier entry. Ignore work done. Ignore progress.

- Decisions found: draft one entry for `DECISIONS.md` under today's date, in the format that file already uses. In the handoff entry, point to it. Do not copy the decisions across.
- None found: say "No decisions to log" and point to nothing.
- No `DECISIONS.md`: list the decisions in the **Decisions** block of the handoff entry. Do not create `DECISIONS.md`. That is the setup skill's job.

## Phase 4: show and wait

Show each draft under the name of the file it will go into. Show the sync route in one line. Stop. Wait for approval.

The user may approve one draft and not the other, or edit either. Write only what was approved.

## Phase 5: write

- `HANDOFF.md` absent: create it with the file header from the template, then the entry.
- `HANDOFF.md` present: insert the entry directly below the header rule, above the previous newest entry. Change nothing else.
- `DECISIONS.md`: add the approved entry at the top of the entry list. Change nothing already there.

## Phase 6: send it

By sync route:

- **Git, and git runs here.** Show what will be committed: the note files, plus whatever the user chose in phase 1. Offer the commit with the message `handoff: <task in five words or fewer>`. Wait for a yes. Then offer `git push`. Wait for a separate yes.
  - The user declines the push: say in one line that the note has not left this place.
  - The push fails for lack of credentials: say so. Say that the push must be done from a terminal on the Mac. Do not try to repair credentials.
  - A cloud session pushes to its own branch. Name the branch. Say that pickup on another branch will find the note there and report it.
- **Git, and git does not run here.** The files are written. Give the two commands to run from a terminal on the Mac: the commit and the push.
- **iCloud or another service.** Say which service carries the file, and that it needs a minute to upload before the lid closes.
- **Nowhere.** Say the note will not reach another machine. Name the fix in one line: a git remote for code, an iCloud folder for documents. Do neither.

## Phase 7: close

- One line: what was written and where
- One line: start the next session with `/session:pickup`
- Say nothing else

## Never

- Write before approval
- Overwrite, delete, or edit an earlier entry
- Commit a file the user did not approve
- Push without a yes, or force-push at all
- Change git configuration or credentials
- Create `DECISIONS.md`
- Add `HANDOFF.md` to `CLAUDE.md`, or reference it there. It must stay out of every session's context until pickup asks for it.
- Put code, logs or secrets in an entry
- Exceed 25 lines in an entry
