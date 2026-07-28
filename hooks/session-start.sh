#!/usr/bin/env bash
# codebase-coffee SessionStart hook: on the first session of the day in a
# given repo, add a one-line nudge to context so the agent offers coffee.
set -eu
project="${CLAUDE_PROJECT_DIR:-$PWD}"
key=$(printf '%s' "$project" | md5sum | cut -d' ' -f1)
stamp_dir="${XDG_CACHE_HOME:-$HOME/.cache}/codebase-coffee"
mkdir -p "$stamp_dir"
stamp="$stamp_dir/$key"
today=$(date +%F)
if [ ! -f "$stamp" ] || [ "$(cat "$stamp")" != "$today" ]; then
  printf '%s' "$today" > "$stamp"
  echo "codebase-coffee: this is the user's first session today in this repo. Unless their first message is clearly mid-task or urgent, open by offering the daily refresher in one short line, like: Morning, coffee? If they accept, invoke the codebase-coffee skill. If they decline or ignore it, drop the subject for the day."
fi
