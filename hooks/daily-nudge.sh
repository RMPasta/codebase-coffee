#!/usr/bin/env bash
# codebase-coffee daily nudge, run on SessionStart and UserPromptSubmit:
# the first time it fires in a repo each day, it adds a one-line nudge to
# context so the agent offers coffee. Silent the rest of the day.
set -eu
project="${CLAUDE_PROJECT_DIR:-$PWD}"
if command -v md5sum >/dev/null 2>&1; then
  key=$(printf '%s' "$project" | md5sum | cut -d' ' -f1)
elif command -v md5 >/dev/null 2>&1; then
  key=$(printf '%s' "$project" | md5 -q)
elif command -v shasum >/dev/null 2>&1; then
  key=$(printf '%s' "$project" | shasum | cut -d' ' -f1)
else
  key=$(printf '%s' "$project" | tr -c 'A-Za-z0-9' '_' | cut -c1-120)
fi
stamp_dir="${XDG_CACHE_HOME:-${HOME:-/tmp}/.cache}/codebase-coffee"
mkdir -p "$stamp_dir"
stamp="$stamp_dir/$key"
today=$(date +%F)
if [ ! -f "$stamp" ] || [ "$(cat "$stamp")" != "$today" ]; then
  printf '%s' "$today" > "$stamp"
  echo "codebase-coffee: this is the user's first session today in this repo. Unless their first message is clearly mid-task or urgent, open by offering the daily refresher in one short line, like: Morning, coffee? If they accept, invoke the codebase-coffee skill. If they decline or ignore it, drop the subject for the day."
fi
