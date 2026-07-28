# codebase-coffee ☕

We're all building with AI tooling now, and ownership of your own code is easy to let slip. codebase-coffee wakes you up with an extremely short refresher each day — one concept, pattern, or convention from your repo — so you hold on to your understanding of the thing you're building.

**Status: in development.** The design is done ([spec](docs/superpowers/specs/2026-07-28-codebase-coffee-design.md)); the skill itself lands next.

## How it works

Run `/codebase-coffee` at the start of your day. You get a brief — under 100 words, always. What the pattern is, why it exists, where it lives, one gotcha. Then a single question: "Go deeper?" Say yes for a tight walkthrough, or get on with your day.

First run scans your repo and builds a personal curriculum (~20–30 concepts worth knowing) in `.codebase-coffee.md`, gitignored and yours alone. After that, mornings are instant — no re-scanning. When the curriculum runs dry or goes stale, it rebuilds. If a teammate landed something notable since yesterday, that jumps the queue.

## Install

Coming with v1 — one skill folder, installable in Claude Code, Cursor, Codex, and anything else that speaks the Agent Skills format.
