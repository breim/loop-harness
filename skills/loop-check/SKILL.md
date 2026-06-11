---
name: loop-check
description: Run the 2-condition test and checklist for a candidate loop
argument-hint: "[task description]"
---

Evaluate whether the task below deserves an automated agent loop. If no task was given, ask the user what task they want to automate before anything else.

Task: $ARGUMENTS

Walk through the evaluation one condition at a time. Ask the user when you cannot verify a condition yourself from the project — do not assume.

## Step 1 — security blocklist

If the task involves architecture rewrites, authentication, payments/billing, production deploys, or work where "done" is a judgment call: stop and output **NO-GO** immediately, naming the blocked category. These need a human in the chair regardless of the other conditions.

## Step 2 — the 2-condition test

1. **Automated verification exists?** Look for a test suite, build, linter, or type checker in the project that would reject bad output with a non-zero exit code. Name the exact command if you find one.
2. **Token budget absorbs waste?** Loops re-read context and retry; ask the user if their plan/budget tolerates 5-10x the tokens of a single run.

## Step 3 — the 30-second checklist

Confirm each box:

- [ ] Objective gate can reject bad output (name the command)
- [ ] A hard stop is feasible (token budget, iteration count, or time limit)
- [ ] Human approval will gate merge, deploy, and dependency changes

## Step 4 — verdict

Output exactly one of:

- **GO** — all conditions pass. List the gate command and suggested hard stop, then point the user to `/loop-init <loop-name>` to scaffold it.
- **NO-GO** — list each failing condition and what would have to change for it to pass. Recommend keeping the task as a manual prompt for now.
