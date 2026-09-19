# Profiles

What gets written, by tier and class. Anything not listed here is not written.

## By tier

| File | Tier 0 | Tier 1 | Tier 2 | Tier 3 |
| :--- | :--- | :--- | :--- | :--- |
| `CLAUDE.md` | Yes, 10 lines | Yes, 25 lines | Yes, 60 lines | Yes, 60 lines |
| `DECISIONS.md` | No | Yes | Yes | Yes |
| `docs/CONTEXT.md` | No | No | Yes | Yes, with a section per part |
| `.claude/settings.json` | No | No | Yes | Yes |
| `.claude/commands/checkpoint.md` | No | No | Yes | Yes |
| `README.md` | No | Only if asked | If absent and the project warrants one | If absent |
| `.gitignore` | No | If git exists and it is absent | Same | Same |
| Source and test directories | No | No | Empty folders only, and only if confirmed | Same |

Tier 0 writes one file and stops. That is the point of tier 0.

## By class

### Empty

Nothing to infer, so the interview carries the whole weight. Create source and test directories only after the user has confirmed the stack, and only the ones that stack actually uses.

### Code

Put in `CLAUDE.md`: the run, test and build commands, taken from the manifest scripts rather than guessed. Name the package manager from the lockfile: `package-lock.json` means npm, `pnpm-lock.yaml` means pnpm, `yarn.lock` means yarn, `uv.lock` means uv, `poetry.lock` means poetry.

Permission allowlist for `.claude/settings.json`: the project's own read-only and test commands only. Never allowlist anything that writes, publishes, deploys or touches a remote.

### Documents

No `src/`, no `tests/`, no build commands. `CLAUDE.md` records where the source documents are, which ones are originals that must not be edited, and the output format wanted.

Add the ASD-STE100 line to the house rules block for this class.

### Data

Record which file is the source of truth, whether it is read-only, and where derived output should go. Never allowlist a command that writes to the source data.

### Mixed

Do not force a structure onto it. Tier 1 at most until the user says what the folder is becoming. Say so plainly rather than scaffolding around the confusion.

## Permission allowlist

Keep `.claude/settings.json` small. A command belongs in `allow` only if it is read-only or local and reversible, and if it comes up often enough to be worth not approving each time.

Never allowlist: anything that pushes, publishes, deploys, sends, or deletes; anything touching production; `rm`; `git push`; package publish commands.

Leave `deny` and `ask` empty unless the interview produced a specific "must never happen" that maps onto a command. If it did, put it in `deny` and say so in the plan.
