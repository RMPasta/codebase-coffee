# codebase-coffee ☕

We're all building with AI tooling now, and it's easy to let ownership of your own code slip. codebase-coffee wakes you up with an extremely short refresher each day about one concept, pattern, or convention in your repo, so you hold on to your understanding of the thing you're building.

**Status: in development.** The design is done ([spec](docs/superpowers/specs/2026-07-28-codebase-coffee-design.md)) and the skill itself lands next.

## How it works

Run `/codebase-coffee` at the start of your day. You get a brief of under 100 words: what the pattern is, why it exists, where it lives in the code, and one gotcha that isn't obvious. It ends by asking if you want to go deeper. Say yes and you get a short walkthrough, or just get on with your day.

The first run scans your repo and builds a personal curriculum of 20 to 30 concepts, saved to `.codebase-coffee.md` (gitignored, since it's personal to you). After that, mornings are instant because nothing needs rescanning. When the list runs dry or goes stale, it rebuilds itself. And if a teammate landed something notable since yesterday, that jumps to the front of the queue.

## Install

Coming with v1. It will be one skill folder you can install in Claude Code, Cursor, Codex, and anything else that speaks the Agent Skills format.
