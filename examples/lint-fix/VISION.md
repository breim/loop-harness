<!-- Standing spec for the lint-fix loop. Reread at the start of every run. The loop must not act outside this file. -->

# Vision · lint-fix

## Goal

`npx eslint src --max-warnings 0` exits 0 under the strict config — every directory in `src/` migrated, with no behavior changes.

## Scope

- Lint fixes under `src/`, one directory per run
- Matching test updates when a fix changes an import path

## Out of scope

- Architecture changes
- Authentication, payments, or billing code
- Anything requiring a judgment call about product direction
- The ESLint config itself (`eslint.config.js`)
- Rewrites beyond what a lint rule requires

## Definition of done

The gate passes and the change is within scope. Nothing else counts as done.

## Gate

```
npm test
```

Pass criteria: exit code 0. The loop must run this command itself and see it pass — a claim of success without a run is a failure.

## Hard stops

- 1 directory per run
- If the gate fails 3 consecutive times on the same item, escalate instead of retrying.

## Human approval required for

- Merging any pull request
- Deploying
- Adding, removing, or upgrading dependencies
- Any change to `eslint.config.js`
