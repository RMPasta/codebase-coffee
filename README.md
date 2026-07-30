# codebase-coffee ☕

**An open-source developer tool by [EraCode](https://www.eracode.ai/).**

We're all building with AI tooling now, and it's easy to let ownership of your own code slip. codebase-coffee wakes you up with an extremely short refresher each day about one concept, pattern, or convention in your repo, so you hold on to your understanding of the thing you're building.

**Current release: v0.1.2.** Works in any tool that supports the Agent Skills format. In Claude Code it can also greet you with your refresher each morning; everywhere else you start it yourself.

## How it works

Run `/codebase-coffee` at the start of your day. You get a brief of under 100 words: what the pattern is, why it exists, where it lives, and one gotcha that isn't obvious. Say yes to "Go deeper?" for a short walkthrough, or just get on with your day.

The first run scans your repo and builds a personal curriculum of 20 to 30 concepts in `.codebase-coffee.md`. Every run after that takes seconds. When the list runs dry or goes stale, it rebuilds. If a teammate landed something notable since yesterday, that goes first.

## Example

A codebase-coffee brief looks like this:

> Centralized error normalization keeps API failures consistent for the frontend. It lives in `src/server/errors.ts:18` and `src/api/client.ts:42`, where domain errors become stable response codes. The gotcha: unknown errors are intentionally collapsed to `INTERNAL_ERROR`, so debugging details belong in server logs, not the response.
>
> Go deeper?

## Setup

### Claude Code

Install as a plugin and coffee comes to you: the first time you talk to Claude Code in a repo each day, whether that's a fresh session or yesterday's chat still open, it offers your refresher before you ask. Run these two commands inside any chat, in this order:

    /plugin marketplace add RMPasta/codebase-coffee
    /plugin install codebase-coffee@codebase-coffee

(Or from a terminal: `claude plugin marketplace add RMPasta/codebase-coffee`, then `claude plugin install codebase-coffee@codebase-coffee`.) Takes effect in your next session. On native Windows the morning greeting needs Git Bash installed; the skill itself runs anywhere.

Prefer no greeting? Skip the plugin and copy the skill instead:

    git clone https://github.com/RMPasta/codebase-coffee
    cp -r codebase-coffee/skills/codebase-coffee ~/.claude/skills/

### Cursor, Codex, and most other agents

One command, no clone:

    npx skills add RMPasta/codebase-coffee

It asks which agents you use and puts the skill where each one looks. Then start your day by asking for `/codebase-coffee`. These tools can't start it for you yet; only Claude Code can.

Prefer manual? Copy `skills/codebase-coffee/` into your tool's skills directory (like `.cursor/skills/`), or into a repo's local skills directory to install for that project only.

### First run

The first run in a repo scans it (about a minute) and builds `.codebase-coffee.md`, your personal curriculum. Say yes when it offers to gitignore that file; it's personal. After that, each coffee takes a few seconds. Just remember: outside the Claude Code plugin, running it each morning is on you.
