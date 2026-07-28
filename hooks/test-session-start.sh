#!/usr/bin/env bash
# Tests: first run today prints a nudge, second run prints nothing,
# different repo gets its own nudge, silent runs still exit 0, and the
# no-hash-tools fallback branch works.
set -u
fails=0
check() { # $1 desc, $2 expected(empty|nonempty), $3 actual
  case "$2" in
    nonempty) [ -n "$3" ] || { echo "FAIL: $1"; fails=$((fails+1)); return; } ;;
    empty)    [ -z "$3" ] || { echo "FAIL: $1"; fails=$((fails+1)); return; } ;;
  esac
  echo "PASS: $1"
}
check_rc() { # $1 desc, $2 rc
  [ "$2" -eq 0 ] || { echo "FAIL: $1 (exit $2)"; fails=$((fails+1)); return; }
  echo "PASS: $1"
}
export XDG_CACHE_HOME="$(mktemp -d)"
script="$(dirname "$0")/session-start.sh"

export CLAUDE_PROJECT_DIR="/tmp/repo-a"
out="$(bash "$script")"; rc=$?
check "first run of the day nudges" nonempty "$out"
check_rc "first run exits 0" "$rc"
out="$(bash "$script")"; rc=$?
check "second run same day is silent" empty "$out"
check_rc "silent run exits 0" "$rc"
export CLAUDE_PROJECT_DIR="/tmp/repo-b"
out="$(bash "$script")"; rc=$?
check "different repo nudges again" nonempty "$out"
check_rc "different repo exits 0" "$rc"
export CLAUDE_PROJECT_DIR="/tmp/repo-a"
out="$(bash "$script")"; rc=$?
check "repo-a still silent" empty "$out"
check_rc "repo-a silent run exits 0" "$rc"

# Force the last-resort key branch: a PATH with no md5sum, md5, or shasum.
fakebin="$(mktemp -d)"
for t in bash date mkdir cat tr cut ls grep; do
  p="$(command -v "$t" 2>/dev/null || true)"
  [ -n "$p" ] && ln -s "$p" "$fakebin/$t"
done
export CLAUDE_PROJECT_DIR="/tmp/repo-c"
out="$(PATH="$fakebin" "$fakebin/bash" "$script")"; rc=$?
check "fallback branch nudges without hash tools" nonempty "$out"
check_rc "fallback branch exits 0" "$rc"
check "fallback key file is sanitized path" nonempty "$( [ -f "$XDG_CACHE_HOME/codebase-coffee/_tmp_repo_c" ] && echo ok )"
rm -rf "$fakebin"

rm -rf "$XDG_CACHE_HOME"
[ "$fails" -eq 0 ] && echo "ALL PASS" || { echo "$fails FAILED"; exit 1; }
