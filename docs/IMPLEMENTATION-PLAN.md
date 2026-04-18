# Implementation Plan — Myan Myan Tap

Read `docs/CONSTRAINTS.md` before starting any task.
Apply all constraints without exception.

---

## Overview

7 implementation phases. Each phase produces a working, runnable state.
Phases are ordered so that the game loop is playable as early as possible,
with polish and persistence added after.

---

## Phase 1 — Project Scaffold

**Goal**: runnable Flutter project with correct configuration, no placeholder code.

Tasks:
1. Create a new Flutter project targeting Android only
2. Configure `pubspec.yaml`:
   - Flutter SDK constraint: `>=3.38.0 <4.0.0`
   - Add `shared_preferences: ^2.3.0`
   - Remove web and desktop platform entries
3. Configure `analysis_options.yaml` with strict mode (`strict_casts`, `strict_inference`, `strict_raw_types`)
4. Configure `android/app/build.gradle`:
   - `minSdkVersion 24`
   - `targetSdkVersion 35`
   - `compileSdkVersion 35`
   - Java 17 source/target compatibility
5. Add app icon (the provided icon image) using Flutter's launcher icon approach — manually place in `mipmap` folders or use a one-time script; no `flutter_launcher_icons` package
6. Set app name to "Myan Myan Tap" in `AndroidManifest.xml`
7. Delete all default `main.dart` boilerplate — replace with a clean entry point that routes to `StartScreen`
8. Confirm: `flutter run` launches on a device or emulator without errors

**File structure at end of phase:**
```
lib/
  main.dart
  screens/
    start_screen.dart    (stub)
    game_screen.dart     (stub)
    game_over_screen.dart (stub)
  services/
    score_service.dart   (stub)
docs/
  CONSTRAINTS.md
  MVP-SCOPE.md
  IMPLEMENTATION-PLAN.md
```

---

## Phase 2 — Navigation Shell

**Goal**: all three screens exist and navigate between each other with placeholder UI.

Tasks:
1. Implement `StartScreen` — static layout only, hardcoded best score of 0, Start button navigates to `GameScreen`
2. Implement `GameScreen` — blank screen with a "Miss (simulate)" button that navigates to `GameOverScreen`
3. Implement `GameOverScreen` — shows hardcoded scores, Play Again navigates back to `GameScreen`, back button goes to `StartScreen`
4. Wire navigation in `main.dart` using `Navigator` — no named routes, no router package
5. Confirm: full navigation flow works end-to-end

---

## Phase 3 — Ball Drop Mechanic

**Goal**: the ball visually drops and the game loop is functional, no scoring yet.

Tasks:
1. Create `BallPainter extends CustomPainter`:
   - Draws flat circle in burnt orange (`#D94F2B`)
   - Draws simple woven pattern — 3 or 4 arcs crossing the circle using `canvas.drawArc`
   - Draws motion blur — a vertically-smeared radial gradient above the ball, painted before the ball circle
2. In `GameScreen`, add `AnimationController` with initial duration of 2000ms driving a `Tween<double>` from 0.0 to 1.0
3. Map animation value to ball Y position: `groundY * animationValue`
4. Randomize ball X position each round using `dart:math` — regenerate on each new drop
5. Render ground line using `CustomPaint` or a `Container` with a top border
6. Detect miss: when animation completes (status == `AnimationStatus.completed`), transition to `GameOverScreen`
7. `GestureDetector` wrapping full screen — `onTapDown` records the tap (no scoring logic yet, just stops the animation and starts next drop)
8. Confirm: ball drops, randomizes X, and reaching the ground navigates to game over

---

## Phase 4 — Scoring & Game Loop

**Goal**: scoring works correctly, speed increases, session state is maintained.

Tasks:
1. Track tap count as session score in `GameScreen` state
2. On successful tap:
   - Calculate reaction time: `elapsedMs = animationController.lastElapsedDuration!.inMilliseconds`
   - Increment tap count
   - Show reaction time as an overlay text (e.g., "324ms") that fades out over 600ms using `AnimatedOpacity` or `FadeTransition`
   - Compute new drop duration: `max(400, currentDuration * 0.92)` — enforce the 400ms floor
   - Reset and restart `animationController` with new duration after a 300ms pause
3. On miss: pass tap count and reaction time (of the final miss) to `GameOverScreen`
4. `GameOverScreen` displays tap count as the session score
5. Play Again resets tap count and speed to initial values
6. Confirm: full game loop works — speed increases, score increments, game over shows correct score

---

## Phase 5 — Persistence

**Goal**: best score survives app restarts.

Tasks:
1. Implement `ScoreService`:
   - Uses `SharedPreferencesWithCache`
   - Two methods: `Future<int> getBestScore()` and `Future<void> saveBestScore(int score)`
   - Key: `'best_score'`
2. Load best score on `StartScreen` `initState` — show loading state (simple empty string) while loading
3. On `GameOverScreen`: if session score > best score, call `saveBestScore`
4. Pass updated best score back to `StartScreen` on Play Again (or reload from prefs on re-entry)
5. Confirm: best score persists after killing and reopening the app

---

## Phase 6 — Visual Polish

**Goal**: the game looks like the icon — clean, minimal, intentional.

Tasks:
1. Apply color palette consistently across all screens:
   - Background: `Color(0xFFF5F0EB)` on all screens
   - Primary text: dark charcoal, not pure black
   - Button: burnt orange fill, white label
2. `StartScreen`: center-align game name (large), best score (medium), Start button (bottom third)
3. `GameScreen`: no visible UI chrome during play — score and reaction time are the only text elements
4. `GameOverScreen`: clean card layout — session score, best score, Play Again button
5. Review motion blur painting — ensure it moves with the ball smoothly, scales with ball velocity (shorter blur at low speed, longer at high speed)
6. Confirm: visual review on a real device — check that the off-white background renders correctly (not pure white)

---

## Phase 7 — CI Setup & Release Build

**Goal**: Codemagic builds a release APK automatically.

Tasks:
1. Create `codemagic.yaml` at project root:
   - Flutter version: `3.38.6` (or latest 3.38.x patch at time of setup)
   - Workflow: `flutter build apk --release`
   - No signing config for MVP (unsigned APK is fine for internal testing)
   - Instance type: `mac_mini_m2` (free tier)
   - Trigger: push to `main`
2. Confirm: Codemagic build completes within budget (release APK build should be well under 10 minutes)
3. Test the APK on a real Android device — confirm cold start, game loop, and persistence all work

---

## Implementation Notes for the Agent

- Never deviate from `CONSTRAINTS.md` without asking first
- If a package other than `shared_preferences` seems useful, stop and ask — the constraint is no additional packages
- `AnimationController` requires a `TickerProvider` — use `SingleTickerProviderStateMixin` on `GameScreen`'s state class
- The `miss detection` must use `AnimationStatus.completed` listener, not a timer — timers drift
- Do not use `setState` inside animation listeners without checking `mounted` first
- The woven ball pattern must be painted via `CustomPainter` — do not use an image asset for it
- All strings (game name, button labels) may be hardcoded in English for MVP — no localization infrastructure needed
