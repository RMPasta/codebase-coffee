# codebase-coffee ☕

We're all building with AI tooling now, and it's easy to let ownership of your own code slip. codebase-coffee wakes you up with an extremely short refresher each day about one concept, pattern, or convention in your repo, so you hold on to your understanding of the thing you're building.

**Status: v0.1.** Works today in Claude Code (with an optional auto-offer each morning); installable anywhere that speaks the Agent Skills format.

## How it works

Run `/codebase-coffee` at the start of your day. You get a brief of under 100 words: what the pattern is, why it exists, where it lives in the code, and one gotcha that isn't obvious. It ends by asking if you want to go deeper. Say yes and you get a short walkthrough, or just get on with your day.

The first run scans your repo and builds a personal curriculum of 20 to 30 concepts, saved to `.codebase-coffee.md` (it's personal to you, so say yes when it offers to gitignore it). After that, mornings are instant because nothing needs rescanning. When the list runs dry or goes stale, it rebuilds itself. And if a teammate landed something notable since yesterday, that jumps to the front of the queue.

## Install

**Claude Code (plugin, includes the morning auto-offer):**

    /plugin marketplace add RMPasta/codebase-coffee
    /plugin install codebase-coffee@codebase-coffee

**Claude Code (skill only):** copy `skills/codebase-coffee/` into `~/.claude/skills/`.

**Cursor / Codex / other Agent Skills tools:** copy `skills/codebase-coffee/` into your tool's skills directory (for example `.cursor/skills/`). Then run it by asking for `/codebase-coffee` or "my codebase coffee". The morning auto-offer is Claude Code only for now; everywhere else you run it yourself.

On first run it scans your repo (about a minute) and builds `.codebase-coffee.md`, your personal curriculum. It will offer to gitignore that file; say yes, it's personal.
