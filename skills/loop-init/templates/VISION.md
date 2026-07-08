<!-- Standing spec for the <LOOP_NAME> loop. Reread at the start of every run. The loop must not act outside this file. -->

# Vision · <LOOP_NAME>

## Goal

<PURPOSE>

## Scope

- <SCOPE>

## Out of scope

- Architecture changes
- Authentication, payments, or billing code
- Anything requiring a judgment call about product direction
- <OUT_OF_SCOPE>

## Definition of done

The gate passes and the change is within scope. Nothing else counts as done.

## Gate

```
<GATE_COMMAND>
```

Pass criteria: exit code 0. The loop must run this command itself and see it pass; a claim of success without a run is a failure.

## Hard stops

- <HARD_STOP>
- If the gate fails 3 consecutive times on the same item, escalate instead of retrying.

## Human approval required for

- Merging any pull request
- Deploying
- Adding, removing, or upgrading dependencies
- <HUMAN_APPROVAL>
