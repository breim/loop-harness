---
name: <LOOP_NAME>
description: Use only when executing the <LOOP_NAME> loop. <PURPOSE>
---

# <LOOP_NAME> loop

Cadence: <CADENCE>

## Procedure

1. Read VISION.md in this directory. It is the contract — do not act outside it.
2. Read STATE.md in this directory. Resume from "In progress"; do not redo "Completed" items.
3. Do one unit of work within scope.
4. Run the gate command from VISION.md. If it fails, fix and rerun; after 3 consecutive failures on the same item, escalate.
5. Update STATE.md (see State updates below) before ending the run.

## Classification rules

<!-- Map symptoms to categories and actions. Example:
- env: missing secret or env var -> escalate to humans
- flake: passes on retry without code change -> retry once, then file
- bug: deterministic failure tied to a recent commit -> draft fix
-->

- <CLASSIFICATION_RULES>

## Fix patterns

<!-- Known-good fixes per category, specific to this project. Example:
- Auth test failures -> check src/auth/middleware first
-->

- <FIX_PATTERNS>

## Never do

- Weaken, skip, or modify the gate to make it pass
- Touch authentication, payments, or architecture
- Merge, deploy, or change dependencies without human approval
- Declare done without the gate passing in this run
- Edit VISION.md

## State updates

After each run, update STATE.md:

- **Last run**: date, items processed, outcomes (one line)
- **In progress**: items started but not gated yet, with branch names
- **Completed**: items that passed the gate this run
- **Escalated to humans**: items that hit a never-do boundary, an out-of-scope need, or 3 gate failures — with the reason
- **Lessons learned**: any durable fact discovered (environment quirk, flaky test, misleading error), dated
- **Stop conditions met**: when the goal condition holds, record commit and timestamp
