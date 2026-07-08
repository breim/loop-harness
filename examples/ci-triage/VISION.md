<!-- Standing spec for the ci-triage loop. Reread at the start of every run. The loop must not act outside this file. -->

# Vision · ci-triage

## Goal

Every failing run on main's nightly CI is triaged into flake, environment, or bug, with a drafted fix branch for each deterministic bug.

## Scope

- Test files under `tests/`
- Source fixes under `src/` for deterministic failures introduced by recent commits
- Triage notes in this directory's STATE.md

## Out of scope

- Architecture changes
- Authentication, payments, or billing code
- Anything requiring a judgment call about product direction
- CI pipeline definitions (`.github/workflows/`)
- Deleting or quarantining tests

## Definition of done

The gate passes and the change is within scope. Nothing else counts as done.

## Gate

```
npm test
```

Pass criteria: exit code 0. The loop must run this command itself and see it pass; a claim of success without a run is a failure.

## Hard stops

- 10 triaged items per run
- If the gate fails 3 consecutive times on the same item, escalate instead of retrying.

## Human approval required for

- Merging any pull request
- Deploying
- Adding, removing, or upgrading dependencies
- Skipping or quarantining any test
