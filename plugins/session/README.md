# session

Carry work from one session to the next: any machine, any surface, wherever the session has a folder.

A local session does not travel. Its transcript stays on the machine that ran it. A cloud session travels, but the next session still starts cold. This plugin makes the folder carry the state instead.

| Part | When | What it does |
| :--- | :--- | :--- |
| `/session:handoff` | Before you stop | Drafts a dated entry for `HANDOFF.md`, logs decisions to `DECISIONS.md` if that file exists, shows both for approval, then offers a commit and a push. |
| `/session:pickup` | When you start | Brings the folder up to date, finds the newest entry, checks it against the folder, reports in eight lines, and waits. |
| SessionStart hook | Every new session | If the workspace holds a `HANDOFF.md`, tells Claude so, with the heading of the newest entry. Claude then says so in its first reply and asks whether to pick up. No note, no output, no context cost. |

Handoff stays a command you type. Closing a window gives Claude no turn to speak, so nothing dependable can run it for you.

## Rules both skills follow

- Nothing is written before approval.
- Additive only. No entry is ever edited or deleted.
- No push, no pull and no branch switch without a yes.
- Git configuration and credentials are never touched.
- The folder outranks the note. A stale note is reported, not obeyed.

## Files

| File | Written by | Holds |
| :--- | :--- | :--- |
| `HANDOFF.md` | handoff | State: done, half done, next step. Newest first. |
| `DECISIONS.md` | workspace-setup creates it. handoff and `/checkpoint` add to it. | Decisions only. |

`HANDOFF.md` is never referenced from `CLAUDE.md`. The hook reads one heading from it. Nothing else loads until pickup asks.

## Surfaces

| Surface | What differs | How the skills cope |
| :--- | :--- | :--- |
| Claude Code on a Mac, terminal or desktop app | Nothing | Full git and sync checks |
| Cowork, local | Runs in a sandbox. No Mac name. The folder path is a mount point. Git may have no credentials. | The entry records `Cowork` as the place. The sync route comes from the last entry, or one question. If git will not run, the skill gives the commands to run on the Mac. |
| Claude Code cloud session | Pushes to its own branch | Handoff names the branch. Pickup on another branch finds the newer note there and offers to read it in place. |
| Any session with no folder | Nowhere to write | The skill says so and stops |

The hook is documented for the terminal, the desktop app, IDE extensions and cloud sessions. Cowork is not stated, so test it there.

## With workspace-setup

The two plugins are independent. In a folder prepared by `workspace-setup`, handoff also does the job of `/checkpoint` in the same pass. In a folder with no `DECISIONS.md`, decisions go into the handoff entry.

## Install

One route reaches every surface: enable `session` on your Claude account, in the same place as `workspace-setup`. Account plugins load in Cowork and in cloud sessions when the session starts, and in terminal sessions from Claude Code v2.1.273.

To install on one machine only, inside Claude Code:

```
/plugin marketplace update neil-plugins
/plugin install session@neil-plugins
```

Use one route per machine, not both.

If a cloud Code session does not load the plugin, declare it in that repository's `.claude/settings.json` under `enabledPlugins`.
