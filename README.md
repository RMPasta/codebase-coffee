# codebase-coffee ☕

**An open-source developer tool by [EraCode](https://www.eracode.ai/).**

We're all building with AI tooling now, and it's easy to let ownership of your own code slip. codebase-coffee wakes you up with an extremely short refresher each day about one concept, pattern, or convention in your repo, so you hold on to your understanding of the thing you're building.

**Current release: v0.1.4.** Works in any tool that supports the Agent Skills format. In Claude Code it can also greet you with your refresher each morning; everywhere else you start it yourself.

## How it works

Run `/codebase-coffee` at the start of your day. You get a brief of under 100 words: what the pattern is, why it exists, where it lives, and one gotcha that isn't obvious. Say yes to "Go deeper?" for a short walkthrough, or just get on with your day.

The first run scans your repo (about a minute) and builds a personal curriculum of 20 to 30 concepts in `.codebase-coffee.md`; say yes when it offers to gitignore that file. After that, each coffee takes seconds. When the list runs dry or goes stale, it rebuilds. If a teammate landed something notable since yesterday, that goes first.

## Example

A codebase-coffee brief looks like this:

> Centralized error normalization keeps API failures consistent for the frontend. It lives in `src/server/errors.ts:18` and `src/api/client.ts:42`, where domain errors become stable response codes. The gotcha: unknown errors are intentionally collapsed to `INTERNAL_ERROR`, so debugging details belong in server logs, not the response.
>
> Go deeper?

## Setup

### Claude Code

Install as a plugin and coffee comes to you: the first time you talk to Claude Code in a repo each day, it offers your refresher before you ask. Run these two commands in order, inside any chat or with `claude` in a terminal:

    /plugin marketplace add RMPasta/codebase-coffee
    /plugin install codebase-coffee@codebase-coffee

Takes effect in your next session. On native Windows the morning greeting needs Git Bash installed.

### Cursor

    npx skills add RMPasta/codebase-coffee --agent cursor -y -g

### Codex

    npx skills add RMPasta/codebase-coffee --agent codex -y -g

### Other agents

Swap in your agent's name, or run it bare (`npx skills add RMPasta/codebase-coffee`) to pick from a list. Drop `-g` to install for the current project only.

Outside Claude Code, no tool can start it for you yet, so running it each morning is on you.

## Manual install

Prefer to place the files yourself? Copy `skills/codebase-coffee/` into your tool's skills directory, or into a repo's local skills directory to install for that project only:

    git clone https://github.com/RMPasta/codebase-coffee
    cp -r codebase-coffee/skills/codebase-coffee ~/.claude/skills/
