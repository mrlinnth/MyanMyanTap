# MVP Scope — Myan Myan Tap

## What the MVP Is

A single-player, offline Android reaction game. A chinlone ball drops from the top
of the screen at a randomized horizontal position. The player taps anywhere on the
screen before the ball hits the ground line. One miss ends the game. The ball
drops faster with each successful tap. Score is the reaction time in milliseconds —
lower is better. The all-time best score is saved locally.

---

## Screens

### 1. Start Screen
- Displays the game name: Myan Myan Tap / မြန်မြန်တို့
- Displays the all-time best score (or a placeholder if none recorded yet)
- Single "Start" button
- No settings, no credits, no menu

### 2. Game Screen
- Full-screen tap surface
- Ball drops from a randomized X position at the top
- Ball accelerates with each successful tap (speed increases by a fixed multiplier per round)
- After a successful tap: reaction time shown briefly on screen, then next ball drops
- Ground line rendered at the bottom of the play area
- No score ticker during play — only reaction time shown after each tap
- On miss (ball reaches ground line): transition to Game Over screen

### 3. Game Over Screen
- Shows the session score (sum or last reaction time — see notes below)
- Shows the all-time best score
- "Play Again" button — restarts from the same initial ball speed
- No share button, no social features

---

## Scoring Definition

Reaction time per tap is measured in milliseconds from the moment the ball starts
dropping to the moment the player taps.

**Session score**: the number of successful taps in the session (simpler to understand
for a Myanmar audience unfamiliar with ms values). Reaction time in ms is shown
as feedback after each tap, but the score that persists is the tap count.

> Note for developer: if you prefer raw ms as the session score (as originally described),
> confirm before implementation. Tap count is recommended for MVP clarity.

---

## Game Mechanics — Precise Definitions

| Parameter               | Value                        | Notes                                      |
|-------------------------|------------------------------|--------------------------------------------|
| Initial drop duration   | 2000ms                       | Time for ball to fall from top to ground   |
| Speed multiplier        | 0.92 per successful tap      | Each tap: new duration = prev × 0.92       |
| Minimum drop duration   | 400ms                        | Floor — ball never drops faster than this  |
| Ball diameter           | 48dp                         | Fixed size regardless of screen size       |
| Ground line Y           | 85% of screen height         | Leaves room for reaction time text below   |
| Randomized X range      | Ball radius to width - radius| Ball always fully visible at spawn         |
| Miss detection          | Ball center crosses ground Y | Not ball bottom — consistent feel          |

---

## State

| State                  | Storage         | Notes                                         |
|------------------------|-----------------|-----------------------------------------------|
| Best score (tap count) | SharedPreferences | Persisted across sessions                   |
| Current session taps   | Memory only     | Lost on app close — intentional               |
| Ball speed state       | Memory only     | Reset on Play Again                           |

---

## What Is Explicitly Out of Scope for MVP

- Sound effects or background music
- Haptic feedback
- Difficulty selection
- Levels or progression system
- Leaderboard (local or remote)
- Social sharing
- Achievements
- Pause functionality
- Multiple ball types or themes
- Localization (Myanmar language UI text is acceptable as static strings only)
- Accessibility features beyond default Flutter semantics
- Tablet layout optimization
- Analytics or crash reporting
- App rating prompts

---

## Visual Design Reference

Derived from the provided app icon:

- Background: off-white, approximately `#F5F0EB`
- Ball: burnt orange flat circle, approximately `#D94F2B`
- Motion blur: soft white-to-transparent gradient smear painted above the ball, simulating motion trail
- Ground line: solid black, 2dp height
- Ball geometric pattern: simple lines or arcs suggesting woven rattan — painted via `CustomPaint`, no image asset
- All text: dark on light, system font, clean and minimal
