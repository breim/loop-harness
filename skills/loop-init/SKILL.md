---
name: loop-init
description: Scaffold a new loop (skill + state + vision + gate) in the current project
argument-hint: "<loop-name>"
---

Scaffold a new agent loop in the current project. Loop name argument: $ARGUMENTS

## Step 1 — qualify

If the 4-condition test (`/loop-check`) was not run for this task in the current session, run its evaluation inline now. On NO-GO, abort and explain which condition failed — do not scaffold a loop that fails the test.

## Step 2 — gather inputs

Collect from the user (ask only for what the conversation has not already established):

- **Loop name** — kebab-case; use $ARGUMENTS if provided
- **Purpose** — one sentence describing what the loop does
- **Cadence** — how often it runs (e.g. every 30m in-session, nightly, on PR open)
- **Gate command** — the exact test/build/lint command that rejects bad output via exit code
- **Hard stop** — max iterations, token budget, or time limit per run
- **Extra approval boundaries** — anything beyond merge/deploy/dependencies that needs a human
- **Scope** — what the loop may touch; **out of scope** additions beyond the defaults

## Step 3 — scaffold

Read the three templates from the `templates/` directory under this skill's base directory and write them into the current project as:

- `.claude/skills/<loop-name>/SKILL.md` — from `loop-skill.md`
- `.claude/skills/<loop-name>/STATE.md` — from `STATE.md`
- `.claude/skills/<loop-name>/VISION.md` — from `VISION.md`

Replace every placeholder (`<LOOP_NAME>`, `<PURPOSE>`, `<CADENCE>`, `<GATE_COMMAND>`, `<HARD_STOP>`, `<HUMAN_APPROVAL>`, `<SCOPE>`, `<OUT_OF_SCOPE>`, `<CLASSIFICATION_RULES>`, `<FIX_PATTERNS>`) with the gathered answers. For classification rules and fix patterns, draft initial entries from what you know of the project and tell the user to refine them after the first manual runs. Remove any placeholder bullet you have no content for, but never remove the prefilled "Never do" items.

## Step 4 — print next steps

Tell the user, in this order (order matters — skipping ahead is how loops fail):

1. **Run manually first**: invoke the `<loop-name>` skill in a normal session and supervise it until a full run is reliable. Refine classification rules and fix patterns in its SKILL.md as you learn.
2. **Then loop it**: wrap it with `/loop` (or the ralph-loop plugin) using the cadence and the gate as the stop condition.
3. **Then schedule it**: only after looped runs are boring, move to a scheduled task or cron.
4. **Review STATE.md after every batch** and read the diffs the loop ships. Track cost per accepted change; if acceptance drops below 50%, kill the loop and redesign.
5. Use `/loop-review <loop-name>` to check the loop's output — never let the maker grade its own work.
