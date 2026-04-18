# Project Constraints
Generated: 2026-04-18
Confirmed by developer: yes

## Project

Myan Myan Tap ("မြန်မြန်တို့") — a Flutter Android game where a chinlone ball drops from
a random horizontal position and the player must tap before it hits the ground.
One miss ends the game. Ball accelerates with each successful tap. Score is based
on reaction time in milliseconds. MVP scope only; learning and experimentation project.

## Stack & Versions

| Package / Framework     | Version   | Notes                                              |
|-------------------------|-----------|----------------------------------------------------|
| Flutter                 | 3.38.x    | Stable, released Nov 12 2025. Dart 3.10 bundled.  |
| Dart                    | 3.10.x    | Bundled with Flutter 3.38 — do not pin separately |
| shared_preferences      | ^2.3.x    | Best score persistence only. Use SharedPreferencesWithCache API (not legacy getInstance). |
| Android target SDK      | 35        | Required for Google Play (Android 15 compliance)  |
| Android min SDK         | 24        | Reasonable baseline for Myanmar market            |
| NDK                     | r28       | Flutter 3.38 default — required for 16KB page support |
| Java                    | 17        | Flutter 3.38 minimum requirement                  |

## Language Standards

- **Dart**: strict mode enabled via `analysis_options.yaml`
  - `strict_casts: true`
  - `strict_inference: true`
  - `strict_raw_types: true`
  - No implicit `dynamic`. Explicit types on all public members.
  - Null safety enforced — no `!` without a clear justification comment.

## Coding Conventions

- State management: raw `StatefulWidget` only — no BLoC, Riverpod, Provider, or similar
- Widget trees: flat and readable — extract to a named widget only when reused or when a method exceeds ~40 lines
- Game loop: use `AnimationController` + `Ticker` from Flutter's built-in animation system — no custom render loop
- Gesture detection: `GestureDetector` wrapping the full screen — no third-party input libraries
- Persistence: `SharedPreferencesWithCache` API only — do not use the legacy `SharedPreferences.getInstance()`
- File structure: follow Flutter defaults (`lib/screens/`, `lib/widgets/`, `lib/services/`) — no feature-folder structure for MVP
- Naming: follow Dart/Flutter conventions — `UpperCamelCase` for types, `lowerCamelCase` for variables and methods, `snake_case` for files
- No abstractions introduced speculatively — only when there is concrete reuse or the logic exceeds clear readability

## Visual / Design Constraints

- Color palette derived from app icon: off-white background (`#F5F0EB` approx), burnt orange ball (`#D94F2B` approx), black ground line
- Ball: flat `CustomPaint` circle with simple geometric woven pattern — no images, no textures, no assets beyond the app icon
- Motion blur: painted above the ball using `CustomPaint` — a simple gradient opacity smear, not a physics simulation
- Typography: system font only — no custom fonts for MVP
- No animations on screens other than the game screen ball drop

## Build & CI Constraints

- Output: Android APK only — no iOS, no web, no desktop
- CI: Codemagic free tier — 500 min/month macOS M2 runner
- Keep build steps minimal — `flutter build apk --release` only, no flavors, no obfuscation config for MVP
- No Firebase, no crash reporting, no analytics for MVP

## Explicit Exclusions

- No sound or music
- No difficulty levels or difficulty selection
- No leaderboard (local or remote)
- No user accounts or authentication
- No ads or monetization
- No iOS build target
- No external packages beyond `shared_preferences`
- No state management library
- No custom fonts
- No photorealistic or texture-based assets

## Handoff Instruction for Implementation Agent

Before implementing any task, read this file first.
Apply every constraint in this file to every file you create or modify.
If a task requires deviating from any constraint, stop and ask before proceeding.
Do not assume any version, pattern, or convention not listed here.
