# codebase-coffee — Design

**Date:** 2026-07-28
**Status:** Approved (pending spec review)

## Problem

Agent-driven development means builders can go days without reading their own code. Codebase ownership — knowing the patterns, conventions, and seams of your own project — quietly slips away. codebase-coffee is a daily ritual that counteracts this: one very short refresher on one valuable concept in the current codebase, served at the start of the day.

## What it is

A portable agent skill (a folder with a `SKILL.md`) installable in Claude Code, Cursor, Codex, and any tool that supports the open Agent Skills format. Invoked as `/codebase-coffee` (v1, manual), later auto-offered on the first session of the day (phase 2, per-tool glue).

## Repo structure

```
codebase-coffee/
├── SKILL.md              # the core skill — fully portable, tool-agnostic
├── README.md             # what it is + install instructions per tool
├── hooks/
│   └── claude-code/      # optional SessionStart hook for auto-trigger (phase 2)
└── .claude-plugin/
    └── marketplace.json  # Claude Code in-app install support
```

Rule: `SKILL.md` never references tool-specific features. All glue lives in clearly optional folders.

## The morning flow (v1, manual invocation)

1. Skill opens with one line: **"Today's pick, or something specific (e.g. error handling)?"** My-pick is the default; silence or "your pick" proceeds immediately.
2. Read the memory file (`.codebase-coffee.md` at repo root).
   - Backlog has unserved items → pop the top one, do a **targeted read of only the 2–4 files it points to**, deliver the brief. This path must be fast.
   - No memory file, backlog exhausted, or last scan older than 30 days → announce **"First time here / been a while — doing a scan, about a minute"** and run the curriculum scan.
3. Before picking, check `git log` since the last run. If something significant landed that the user did not author (new pattern, notable refactor), it **jumps the queue**: "New since yesterday: …".
4. After delivering, update the memory file (mark served, stamp date).

## The brief — hard output contract

Non-negotiable rules written into `SKILL.md`:

- **≤100 words.**
- **No headers, no bullet lists, no preamble, no praise, no filler.**
- **No AI-writing tells**: no em dashes, no "it's not just X, it's Y" pivots, no staccato fragment emphasis ("No fluff. No filler."), no rule-of-three lists, no "delve"/"leverage" vocabulary. Reads like a sharp colleague's Slack message.
- Content, in order: the pattern's name → why it exists → where it lives (1–2 `file:line` references) → one gotcha or non-obvious detail.
- Ends with exactly: **"Go deeper?"**
- If the user says yes → a tight walkthrough, **~300 words max**, code excerpts allowed. Concept is then marked `deep ✓` in memory.

The brief must fit on a phone screen. If it doesn't, it's wrong.

## Memory file

`.codebase-coffee.md` at the repo root. Human-readable markdown:

- Header: last scan timestamp, last served date.
- Curriculum: a checklist of concepts, each with a one-line description, file pointers, priority rank, and status (`upcoming` / `served` / `deep`).

On first run the skill offers to add `.codebase-coffee.md` to `.gitignore` — the file is personal per-user and never pushed. Because it is human-readable, it doubles as a map of the codebase the user can browse directly.

## Curriculum scan (first run + refresh)

One thorough pass over the repo producing ~20–30 ranked concepts. Categories to look for:

- **Conventions** — error handling, auth patterns, naming schemes.
- **Architectural seams** — how data flows between layers/services.
- **Clever or dangerous spots** — custom decorators, signal handlers, caching, anything with non-obvious behavior.
- **Tribal-knowledge candidates** — things a new hire would have to ask about.

Ranking heuristic: "how much would it hurt not to know this." Recently-changed areas and code not authored by the user rank higher.

Refresh triggers: backlog exhausted, or last scan >30 days old. The skill announces the refresh honestly ("been a while — doing a refresh scan, ~a minute"). An occasional 1–2 minute wait is acceptable; a daily one is not.

## Phase 2 — auto-trigger (Claude Code first)

A SessionStart hook script in `hooks/claude-code/`:

- Keeps a per-repo last-run date stamp.
- On the first session of a new calendar day, injects a one-line nudge into context telling the agent to *offer* coffee ("Morning — coffee? ☕") unless the user's first message is clearly mid-task or urgent.
- Never hijacks the session; one line, easy to wave off. Declining costs the user nothing.

Cursor/Codex equivalents documented in the README as those tools allow; manual invocation always works everywhere.

## Distribution

- Public GitHub repo `codebase-coffee`.
- README with per-tool install: copy/clone into `~/.claude/skills/`, `.cursor/skills/`, etc.
- `.claude-plugin/marketplace.json` so Claude Code users can `/plugin marketplace add`.
- Open skill registries (e.g. `npx skills add`) once the repo is public.

## Testing

Guinea-pig repo: a real production monorepo on the author's machine.

- **First-run scan quality** — are the ~20–30 concepts genuinely the ones that matter?
- **Brief brevity** — police the ≤100-word contract; this is the make-or-break behavior.
- **Repeat avoidance** — simulate several "days"; no concept served twice.
- **Refresh path** — exhaust/expire the backlog and confirm the announced rescan.
- **Queue-jumping** — land a commit not authored by the user and confirm it surfaces.

## Out of scope (v1)

- Auto-trigger hooks for Cursor/Codex.
- Team/shared curriculum (memory file is deliberately personal).
- Quiz / active-recall mode (possible later as an opt-in `quiz me` flavor).
