#!/usr/bin/env bash
# Tests: first run today prints a nudge, second run prints nothing,
# different repo gets its own nudge.
set -u
fails=0
check() { # $1 desc, $2 expected(empty|nonempty), $3 actual
  case "$2" in
    nonempty) [ -n "$3" ] || { echo "FAIL: $1"; fails=$((fails+1)); return; } ;;
    empty)    [ -z "$3" ] || { echo "FAIL: $1"; fails=$((fails+1)); return; } ;;
  esac
  echo "PASS: $1"
}
export XDG_CACHE_HOME="$(mktemp -d)"
script="$(dirname "$0")/session-start.sh"

export CLAUDE_PROJECT_DIR="/tmp/repo-a"
check "first run of the day nudges"    nonempty "$(bash "$script")"
check "second run same day is silent"  empty    "$(bash "$script")"
export CLAUDE_PROJECT_DIR="/tmp/repo-b"
check "different repo nudges again"    nonempty "$(bash "$script")"
export CLAUDE_PROJECT_DIR="/tmp/repo-a"
check "repo-a still silent"            empty    "$(bash "$script")"

rm -rf "$XDG_CACHE_HOME"
[ "$fails" -eq 0 ] && echo "ALL PASS" || { echo "$fails FAILED"; exit 1; }
