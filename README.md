# Claude Plugins

A Claude Code plugin marketplace, published as `neil-plugins`. Currently holds one plugin.

## workspace-setup

Turns a folder into a prepared Claude Code workspace. It inspects what is already there, works out how big the job is before asking anything long, interviews you one question at a time, and writes only what you approved.

The scaffold is sized to the work:

| Tier | Job | What gets written |
| :--- | :--- | :--- |
| 0 | One sitting, an artefact comes out | A ten-line `CLAUDE.md` |
| 1 | A few sessions, one small thing | `CLAUDE.md`, `DECISIONS.md` |
| 2 | A sustained project | Both, plus `docs/CONTEXT.md`, `.claude/settings.json`, a `/checkpoint` command |
| 3 | A system with parts | Tier 2, plus per-part notes |

Where the tier is ambiguous it takes the lower one, and it can be re-run later to promote a folder without repeating the interview.

Run it in any folder with `/workspace-setup:setup`, or just say "set this folder up for Claude Code".

## Layout

```
.claude-plugin/marketplace.json    the catalogue
workspace-setup/                   one plugin
  .claude-plugin/plugin.json       its manifest
  skills/setup/
    SKILL.md                       the routine, loaded every session
    reference/
      interview.md                 question sets, read on demand
      profiles.md                  what gets written, by tier and class
      templates/                   the files it writes
```

A second plugin becomes a sibling of `workspace-setup/` and gets a second entry in `marketplace.json`.

Only `SKILL.md` costs context in a normal session. Everything under `reference/` is read when it is needed.

## Install

```
/plugin marketplace add sylvest100/neil-plugins
/plugin install workspace-setup@neil-plugins
```

## Before pushing a change

```
claude plugin validate .
```
