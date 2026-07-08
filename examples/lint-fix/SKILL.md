---
name: lint-fix
description: Worked example from loop-harness — for reading, not installing. Use only when executing the lint-fix loop. Migrate src/ to the strict ESLint config one directory per run until zero warnings remain.
---

# lint-fix loop

Cadence: every 30 minutes in-session, via /loop

## Procedure

1. Read VISION.md in this directory. It is the contract — do not act outside it.
2. Read STATE.md in this directory. Resume from "In progress"; do not redo "Completed" items.
3. Check whether the loop is done: if "Stop conditions met" in STATE.md is already filled, the VISION.md goal now holds, or no in-scope work remains, record the reason under "Stop conditions met", end your output with the line `LOOP DONE: <reason>`, and stop without doing work.
4. Do one unit of work within scope.
5. Run the gate command from VISION.md. If it fails, fix and rerun; after 3 consecutive failures on the same item, escalate.
6. Update STATE.md (see State updates below) before ending the run.

## Classification rules

- auto-fixable (formatting, import order) -> run `npx eslint --fix` on the directory, then review the diff line by line
- manual rules (`no-floating-promises`, `no-explicit-any`) -> fix by hand within the directory
- a rule seems wrong for this codebase -> escalate with the rule name and one example; never silence it inline

## Fix patterns

- `@typescript-eslint/no-floating-promises` -> add `await`, or `void` only after confirming the call is fire-and-forget
- `no-explicit-any` on API responses -> the real types live in `src/types/api.ts`; import them, don't redeclare
- Import-order autofix breaks the barrel files in `src/api` -> reorder those by hand

## Never do

- Weaken, skip, or modify the gate to make it pass
- Touch authentication, payments, or architecture
- Merge, deploy, or change dependencies without human approval
- Declare done without the gate passing in this run
- Edit VISION.md
- Add `eslint-disable` comments or loosen rules in the ESLint config

## State updates

After each run, update STATE.md:

- **Last run**: date, items processed, outcomes (one line)
- **Metrics**: increment the Runs count. Accepted/Rejected belong to `/loop-review`, never to you
- **In progress**: items started but not gated yet, with branch names
- **Completed**: items that passed the gate this run
- **Escalated to humans**: items that hit a never-do boundary, an out-of-scope need, or 3 gate failures — with the reason
- **Lessons learned**: any durable fact discovered (environment quirk, flaky test, misleading error), dated
- **Stop conditions met**: the reason and date when the loop is done — goal met, no in-scope work left, or a VISION.md hard stop. Filling this ends the loop (step 3)
