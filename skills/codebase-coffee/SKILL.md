---
name: codebase-coffee
description: Use when the user runs /codebase-coffee, asks for their daily codebase refresher or coffee, or accepts a morning offer of one. Serves one very short brief on a concept, pattern, or convention in the current repo, tracked in a personal curriculum file (.codebase-coffee.md).
---

# codebase-coffee

Serve one very short refresher about this codebase, then stop. The whole product is brevity. A verbose brief is a failed brief.

## Flow

1. Ask exactly one opening question: "Today's pick, or something specific (e.g. error handling)?" Skip it if the user already named a topic. "Your pick", "go", or similar means you choose.
2. Read `.codebase-coffee.md` at the repo root.
   - If it is missing, every concept is marked served, or `last_scan` is more than 30 days old: say "First time here (or it's been a while), doing a scan, about a minute" and run the Curriculum scan section below.
   - Otherwise pick the highest unserved concept in the list, or the best match for the user's requested topic. If the topic isn't in the curriculum, find it in the repo and add a line for it.
3. Queue jump check: run `git log --no-merges --format='%an|%s' --since="<last_served date>"` (use `-20` if there is no date). If commits by someone other than the user introduce a notable new pattern or a meaningful refactor, brief that instead and open with "New since last time:".
4. Read only the 2 to 4 files the chosen concept points to. On this fast path, do not explore anything else.
5. Deliver the brief. The contract below is absolute.
6. Update `.codebase-coffee.md`: check the concept off with today's date and update `last_served`.
7. If the user says yes to going deeper, give the walkthrough, then append `| deep` to the concept's line.

## The brief (hard contract)

- 100 words maximum. Count them before sending.
- No headers, no bullet lists, no preamble, no praise, no filler.
- Order: name the pattern, why it exists, where it lives (1 or 2 `file:line` references), then one gotcha or non-obvious detail.
- End with exactly: "Go deeper?"
- Voice: a sharp colleague's Slack message. Banned: em dashes, "it's not just X, it's Y", staccato fragment emphasis, rule-of-three lists, the words "delve" and "leverage".
- These voice rules bind every line you send the user while running this skill: the opening question, the scan announcement, the gitignore offer, and the walkthrough, not just the brief.
- It must fit on a phone screen. If it doesn't, cut before sending.

## The walkthrough (only if they say yes)

300 words maximum, same voice rules. Short code excerpts are allowed. Walk the real flow through the files, and end by pointing at one spot where they can verify the behavior themselves.

## Memory file: .codebase-coffee.md

Lives at the target repo's root. Offer to add it to .gitignore only in the run where no .codebase-coffee.md existed when you started: it is personal to this user and should not be pushed. A rescan rewrite is not a first creation. If the user declines or never answers, leave it alone. Format:

    # codebase-coffee
    last_scan: 2026-07-28
    last_served: 2026-07-28

    ## Curriculum
    - [x] Meter reading dedupe: idempotent ingestion via unique constraint | backend/meters/services.py, backend/meters/models.py | served 2026-07-28 | deep
    - [ ] Permission matrices: per-app access gating | backend/core/permissions.py |

One line per concept: checkbox (`x` means served), short name, colon, one-line description, pipe, comma-separated file pointers, pipe, `served <date>` once served, `| deep` after a walkthrough. List order is priority order. Keep it human-readable; the user may browse it as a map of their own codebase.

## Curriculum scan (first run and refresh)

Announce the scan first, then do one thorough pass: repo structure, key modules, recent git history. Produce 20 to 30 concepts ranked by how much it would hurt not to know them. Hunt in four places:

- Conventions: error handling, auth, validation, naming schemes.
- Architectural seams: how data moves between layers, apps, or services.
- Clever or dangerous spots: custom decorators, signals, caching, concurrency, anything whose behavior is not obvious from its call site.
- Tribal knowledge: whatever a new hire would have to ask a human about.

Rank recently changed areas and code the user did not author higher. Write the file, then continue at Flow step 3 and serve today's brief from the fresh list. Never make the user ask twice.

## What not to do

- Never serve two concepts in one day unless the user asks.
- Never rescan while unserved concepts remain and the last scan is under 30 days old.
- Never pad the brief to seem thorough. Under-explaining is the feature.
- Never nag about gitignore. One offer, ever.
