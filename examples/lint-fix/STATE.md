<!-- Working memory for the lint-fix loop. Updated by the loop at the end of every run, read at the start of every run. -->

# Loop state · lint-fix

## Last run

2026-07-05: verified goal: `npx eslint src --max-warnings 0` exits 0; ended with LOOP DONE

## Metrics

<!-- Runs is incremented by the loop; Accepted/Rejected by /loop-review. Below 50% acceptance, kill the loop. -->

Runs: 8 · Accepted: 7 · Rejected: 1

## In progress

(none)

## Completed

- 2026-07-04: `src/utils`: 14 warnings fixed, 2 by hand
- 2026-07-03: `src/api`: 31 warnings, mostly `no-floating-promises`
- 2026-07-02: `src/components`: autofix only, diff reviewed
- 2026-07-01: `src/types`: 6 `no-explicit-any` replaced with real types

## Escalated to humans

- 2026-07-02: `import/no-cycle` flags `src/models` <-> `src/api`; breaking the cycle is an architecture change, out of scope

## Lessons learned

<!-- Write durable facts here, not in chat: environment quirks, flaky tests, things that only fail in CI. Date each entry. -->

- 2026-07-03: `eslint --fix` import reordering breaks the barrel files in `src/api`; fix those by hand
- 2026-07-01: run the gate before and after autofix: one "useless" `await` it removed was load-bearing

## Stop conditions met

2026-07-05: `npx eslint src --max-warnings 0` exits 0; goal met, no in-scope work remains. Run ended with `LOOP DONE`.
