# Entry template

Two parts. The file header is written once, when `HANDOFF.md` is created. The entry is written at every handoff.

Fill every placeholder. Delete a block that has nothing in it. Never leave a `<placeholder>` in the written file.

## File header

```markdown
# Handoff

Newest first. One entry per handoff. State, not history: what the next session needs to carry on. Decisions live in `DECISIONS.md`.

`/session:pickup` reads the top entry only.

---
```

## Entry

```markdown
## <YYYY-MM-DD HH:MM +ZZZZ> - <place>

**Task:** <one sentence: what this session was for>

**State**

- Done: <what is finished and checked>
- Half done: <what is part-finished, and exactly how far it got>
- Not started: <what was planned and not touched>

**Next step:** <one concrete action, with the file and the command>

**Files touched:** <paths, comma separated>

**Sync route:** <Git, iCloud, the name of another service, or Nowhere>

**Git:** <branch>, last commit before this handoff `<short hash>` "<subject>". <What travels with this handoff, and what stays behind.>

**Only in this place:** <running servers, environment variables, local data, files outside the workspace. Write "Nothing" if there is nothing.>

**Tried and dropped:** <one line each>

**Open questions:** <what needs an answer from the user before work can continue>

**Decisions:** see `DECISIONS.md`, entry dated <YYYY-MM-DD>. <If there is no DECISIONS.md, list the decisions here.>

---
```

## Notes on the fields

- **Heading.** Local time with the UTC offset, because two places may be in different time zones. A sandbox or a cloud session reports `+0000`.
- **Place.** The Mac's name when the session runs on a Mac. Otherwise the surface: `Cowork` or `Claude Code cloud`, with the Mac added if the user has said which one. Never a sandbox hostname. Pickup uses it to tell whether it is in the same place.
- **Sync route.** Always filled. A later handoff from a sandbox reads this line, because a sandbox cannot see how the folder syncs.
- **Git.** Delete the block when the folder has no git.
- **Last commit before this handoff.** Pickup checks that this hash exists where it runs. If it does not, the work never arrived.
- **Optional blocks.** Git, Tried and dropped, Open questions and Decisions are deleted when empty. All other blocks stay.
