# codebase-coffee ☕

We're all building with AI tooling now, and it's easy to let ownership of your own code slip. codebase-coffee wakes you up with an extremely short refresher each day about one concept, pattern, or convention in your repo, so you hold on to your understanding of the thing you're building.

**Status: v0.1.** Works today in Claude Code (with an optional auto-offer each morning); installable anywhere that speaks the Agent Skills format.

## How it works

Run `/codebase-coffee` at the start of your day. You get a brief of under 100 words: what the pattern is, why it exists, where it lives in the code, and one gotcha that isn't obvious. It ends by asking if you want to go deeper. Say yes and you get a short walkthrough, or just get on with your day.

The first run scans your repo and builds a personal curriculum of 20 to 30 concepts, saved to `.codebase-coffee.md` (it's personal to you, so say yes when it offers to gitignore it). After that, mornings are instant because nothing needs rescanning. When the list runs dry or goes stale, it rebuilds itself. And if a teammate landed something notable since yesterday, that jumps to the front of the queue.

## Setup

### Claude Code (the full experience, with the morning auto-offer)

Inside any chat, run these two commands in this order (the install looks plugins up by marketplace name, so the add has to come first):

    /plugin marketplace add RMPasta/codebase-coffee
    /plugin install codebase-coffee@codebase-coffee

From a terminal instead: `claude plugin marketplace add RMPasta/codebase-coffee`, then `claude plugin install codebase-coffee@codebase-coffee`. The plugin is active for sessions started after the install. Your first new session of each day in a repo will open by offering you coffee; you can also run `/codebase-coffee` yourself anytime. On native Windows the auto-offer needs Git Bash installed; the skill itself runs anywhere.

### Claude Code (skill only, no auto-offer)

    git clone https://github.com/RMPasta/codebase-coffee
    cp -r codebase-coffee/skills/codebase-coffee ~/.claude/skills/

Use a repo's `.claude/skills/` directory instead to install it for that project only.

### Cursor

    git clone https://github.com/RMPasta/codebase-coffee
    cp -r codebase-coffee/skills/codebase-coffee ~/.cursor/skills/

Or drop the folder into a repo's `.cursor/skills/` for that project only. Start your day by asking the agent for `/codebase-coffee` or "my codebase coffee".

### Codex

    git clone https://github.com/RMPasta/codebase-coffee
    cp -r codebase-coffee/skills/codebase-coffee ~/.codex/skills/

Then ask for codebase-coffee at the start of your day.

### Anything else that speaks Agent Skills

Copy `skills/codebase-coffee/` into your tool's skills directory. The skill is self-contained; the auto-offer is Claude Code only for now, so everywhere else running it yourself is the ritual.

### First run

In each repo, the first run scans the codebase (about a minute) and builds `.codebase-coffee.md`, your personal curriculum. It offers to gitignore that file; say yes, it's personal. Every morning after that is instant.
