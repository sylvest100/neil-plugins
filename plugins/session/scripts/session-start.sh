#!/bin/sh
# session plugin: SessionStart hook.
#
# If this workspace holds a HANDOFF.md, print one plain-text notice.
# Claude Code adds plain-text stdout from a SessionStart hook to Claude's context.
# Prints nothing, and costs no context, when there is no note.
# Reads only the newest entry heading. Writes nothing.

root="${CLAUDE_PROJECT_DIR:-$PWD}"
note="$root/HANDOFF.md"

# Not at the session root: try the git top level.
if [ ! -f "$note" ] && command -v git >/dev/null 2>&1; then
  top=$(git -C "$root" rev-parse --show-toplevel 2>/dev/null) && note="$top/HANDOFF.md"
fi

[ -f "$note" ] || exit 0

# Newest entry heading: the first "## " line. One line, no control characters, 120 characters at most.
heading=$(grep -m 1 '^## ' "$note" 2>/dev/null | sed 's/^## *//' | tr -d '\000-\037' | cut -c 1-120)
[ -n "$heading" ] || heading="no dated entry found"

printf 'This workspace has a handoff note from an earlier session: %s. Newest entry: %s. The note has not been read into this session. The user resumes work with /session:pickup, which reads the newest entry and checks it against the folder. The user expects to be told in one line that the note exists before other work starts.\n' "$note" "$heading"
exit 0
