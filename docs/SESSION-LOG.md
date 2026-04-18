# Session Log

A running log of what happened in each Claude Code session and in between them. The goal is to keep Claude Code (and future-you) oriented without forcing a full re-read of the repo every time.

## How to Use This File

**At the start of every Claude Code session**, include this in the handoff prompt:

> Before starting, read `docs/SESSION-LOG.md` (especially the most recent entries) so you know what has changed since your last session. Pull the latest from `main` before making changes.

**At the end of every Claude Code session**, have Claude Code append a new entry summarizing:
- What slice or task was worked on
- What was actually implemented (not just intended)
- Anything unexpected that came up
- What's left undone or unclear

**Between sessions** (for manual ops — npm installs, git operations, EAS builds, device testing, tuning changes), add your own short entry. Even one line is fine. The point is that Claude Code can read it and know what happened.

## Format

Each entry is a short markdown block with a date heading. Keep entries brief — bullet points or 2-3 sentences. Chronological order, newest at the bottom (so reading top-to-bottom tells the story of the project).

```
## YYYY-MM-DD — short title

- Bullet 1
- Bullet 2
- Notes or gotchas
```

Do not delete old entries. This file is append-only.

---

## Entries

## 2026-04-18 — Project planning

- Ran project-kickoff and produced `CONSTRAINTS.md`.
- Ran scope and produced `MVP-SCOPE.md`.
- Ran implementation planning and produced `IMPLEMENTATION-PLAN.md`.
