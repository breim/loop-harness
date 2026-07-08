<!-- Working memory for the ci-triage loop. Updated by the loop at the end of every run, read at the start of every run. -->

# Loop state · ci-triage

## Last run

2026-07-07: 4 failures triaged: 2 flakes logged, 1 env escalated, 1 bug drafted on ci-triage/1482

## Metrics

<!-- Runs is incremented by the loop; Accepted/Rejected by /loop-review. Below 50% acceptance, kill the loop. -->

Runs: 12 · Accepted: 9 · Rejected: 2

## In progress

- ci-triage/1482: fix for `order-total.test.ts` regression from commit 91c3aa0; gate green, awaiting review

## Completed

- 2026-07-07: `search-index.test.ts` flake (green on rerun, logged)
- 2026-07-06: `invoice-render.test.ts` regression fixed on ci-triage/1471, accepted by /loop-review
- 2026-07-04: `user-profile.test.ts` timeout: missing `await` in test setup, fixed on ci-triage/1466

## Escalated to humans

- 2026-07-07: nightly job fails at checkout: `NPM_TOKEN` expired; the loop cannot rotate secrets
- 2026-07-02: `payment-webhook.test.ts` failing; payments code is out of scope

## Lessons learned

<!-- Write durable facts here, not in chat: environment quirks, flaky tests, things that only fail in CI. Date each entry. -->

- 2026-07-05: `search-index.test.ts` is order-dependent: flakes whenever the suite runs sharded; rerun before classifying as bug
- 2026-06-30: CI runners are UTC; any test asserting local dates fails only in CI

## Stop conditions met

(none; triage recurs nightly and each run is bounded by the 10-item hard stop)
