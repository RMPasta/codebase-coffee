# codebase-coffee ☕

We're all building with AI tooling now, and it's easy to let ownership of your own code slip. codebase-coffee wakes you up with an extremely short refresher each day about one concept, pattern, or convention in your repo, so you hold on to your understanding of the thing you're building.

**Status: v0.1.** Works in any tool that speaks the Agent Skills format. In Claude Code it can also greet you with your refresher each morning; everywhere else you start it yourself.

## How it works

Run `/codebase-coffee` at the start of your day. You get a brief of under 100 words: what the pattern is, why it exists, where it lives, and one gotcha that isn't obvious. Say yes to "Go deeper?" for a short walkthrough, or just get on with your day.

The first run scans your repo and builds a personal curriculum of 20 to 30 concepts in `.codebase-coffee.md`. Every run after that takes seconds. When the list runs dry or goes stale, it rebuilds. If a teammate landed something notable since yesterday, that goes first.

## Setup

### Claude Code

Install as a plugin and coffee comes to you: the first time you talk to Claude Code in a repo each day, whether that's a fresh session or yesterday's chat still open, it offers your refresher before you ask. Run these two commands inside any chat, in this order:

    /plugin marketplace add RMPasta/codebase-coffee
    /plugin install codebase-coffee@codebase-coffee

(Or from a terminal: `claude plugin marketplace add RMPasta/codebase-coffee`, then `claude plugin install codebase-coffee@codebase-coffee`.) Takes effect in your next session. On native Windows the morning greeting needs Git Bash installed; the skill itself runs anywhere.

Prefer no greeting? Skip the plugin and copy the skill instead:

    git clone https://github.com/RMPasta/codebase-coffee
    cp -r codebase-coffee/skills/codebase-coffee ~/.claude/skills/

### Cursor

    git clone https://github.com/RMPasta/codebase-coffee
    cp -r codebase-coffee/skills/codebase-coffee ~/.cursor/skills/

Start your day by asking for `/codebase-coffee`. Cursor can't start it for you yet; only Claude Code can.

### Codex

    git clone https://github.com/RMPasta/codebase-coffee
    cp -r codebase-coffee/skills/codebase-coffee ~/.codex/skills/

Same deal: ask for codebase-coffee each morning yourself.

### Anything else that speaks Agent Skills

Copy `skills/codebase-coffee/` into your tool's skills directory.

For any tool, you can use a repo's local skills directory (like `.claude/skills/` or `.cursor/skills/`) to install for that project only.

### First run

The first run in a repo scans it (about a minute) and builds `.codebase-coffee.md`, your personal curriculum. Say yes when it offers to gitignore that file; it's personal. After that, each coffee takes a few seconds. Just remember: outside the Claude Code plugin, running it each morning is on you.
