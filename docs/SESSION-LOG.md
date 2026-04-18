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

## 2026-04-18 — Phase 1: Project scaffold

- Installed Flutter 3.38.0 stable (Dart 3.10.0) into /opt/flutter.
- Ran `flutter create --platforms=android --org com.mrlinnth --project-name myan_myan_tap .` in project root.
- `pubspec.yaml`: Dart SDK `>=3.10.0-0 <4.0.0`, added `shared_preferences: ^2.3.0`, removed `cupertino_icons`.
- `analysis_options.yaml`: strict-casts, strict-inference, strict-raw-types all enabled.
- `android/app/build.gradle.kts`: compileSdk/targetSdk 35, minSdk 24, ndkVersion `28.0.12433566` (r28), Java 17.
- `android/app/src/main/AndroidManifest.xml`: label set to "Myan Myan Tap".
- App icon resized from `docs/myanmyantap-icon.jpg` into all five mipmap density folders using Pillow.
- `lib/main.dart`: clean `MyanMyanTapApp` entry point routing to `StartScreen`.
- Stub screens created: `start_screen.dart`, `game_screen.dart`, `game_over_screen.dart`.
- Stub `ScoreService` created (no SharedPreferences calls yet — Phase 5).
- `flutter analyze`: no issues.
- Committed and pushed to branch `claude/prepare-phase-1-7RYOf`.
- Next: Phase 2 — navigation shell (implement the three screens with placeholder UI and wire navigation).
