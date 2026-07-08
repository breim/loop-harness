---
name: ci-triage
description: Worked example from loop-harness — for reading, not installing. Use only when executing the ci-triage loop. Triage failing nightly CI runs into flake, environment, or bug, and draft a fix branch for deterministic bugs.
---

# ci-triage loop

Cadence: nightly

## Procedure

1. Read VISION.md in this directory. It is the contract — do not act outside it.
2. Read STATE.md in this directory. Resume from "In progress"; do not redo "Completed" items.
3. Check whether the loop is done: if "Stop conditions met" in STATE.md is already filled, the VISION.md goal now holds, or no in-scope work remains, record the reason under "Stop conditions met", end your output with the line `LOOP DONE: <reason>`, and stop without doing work.
4. Do one unit of work within scope.
5. Run the gate command from VISION.md. If it fails, fix and rerun; after 3 consecutive failures on the same item, escalate.
6. Update STATE.md (see State updates below) before ending the run.

## Classification rules

- env: missing secret, expired token, or runner image change -> escalate to humans
- flake: passes on rerun with no code change -> rerun once; if green, log the test name under Lessons learned
- bug: deterministic failure introduced by a recent commit -> draft a fix on a `ci-triage/<issue>` branch
- unknown: cannot classify within 15 minutes of investigation -> escalate with findings so far

## Fix patterns

- Date or timezone assertion failures -> CI runners are UTC; check the test for local-time assumptions before touching src
- Timeout failures in `tests/api/` -> look for a missing `await` first; raising the timeout is a last resort and must be noted in STATE.md
- Snapshot mismatches after a design-system bump -> escalate; never regenerate snapshots blindly

## Never do

- Weaken, skip, or modify the gate to make it pass
- Touch authentication, payments, or architecture
- Merge, deploy, or change dependencies without human approval
- Declare done without the gate passing in this run
- Edit VISION.md

## State updates

After each run, update STATE.md:

- **Last run**: date, items processed, outcomes (one line)
- **Metrics**: increment the Runs count. Accepted/Rejected belong to `/loop-review`, never to you
- **In progress**: items started but not gated yet, with branch names
- **Completed**: items that passed the gate this run
- **Escalated to humans**: items that hit a never-do boundary, an out-of-scope need, or 3 gate failures — with the reason
- **Lessons learned**: any durable fact discovered (environment quirk, flaky test, misleading error), dated
- **Stop conditions met**: the reason and date when the loop is done — goal met, no in-scope work left, or a VISION.md hard stop. Filling this ends the loop (step 3)
