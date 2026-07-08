---
name: loop-review
description: Run the independent loop-verifier on a loop's output
argument-hint: "<loop-name>"
---

Verify the output of an existing loop using the independent `loop-verifier` agent. Loop name argument: $ARGUMENTS

## Step 1 — resolve the loop

Locate `.claude/skills/$ARGUMENTS/` in the current project (it must contain SKILL.md, VISION.md, and STATE.md). If no argument was given or the directory does not exist, list the loop directories found under `.claude/skills/` and stop.

## Step 2 — identify the changes to verify

Determine what the loop produced: the uncommitted diff, or the branch named in the loop's STATE.md "In progress"/"Completed" entries. If more than one candidate exists, ask the user which to review.

## Step 3 — run the verifier

Spawn the `loop-verifier` agent, passing it the loop directory path and the changes to verify. Do not summarize, soften, or pre-judge the changes for it — the verifier must form its own view and rerun the gate itself.

If no `loop-verifier` agent type is registered, spawn a general-purpose subagent with these instructions instead: "You are an independent checker in a maker/checker split; you never edit files or fix anything, and Bash is read-only except for running the gate command. Check: (1) the gate command from VISION.md actually passes — rerun it yourself, never trust claims; (2) every change traces to the Goal and Scope in VISION.md; (3) nothing outside Scope was touched — the loop's own STATE.md updates are expected bookkeeping, not scope creep; (4) auth, payments, architecture, dependency manifests, the gate command, and VISION.md are untouched; (5) STATE.md entries match what actually happened; (6) if STATE.md declares 'Stop conditions met', the claim is real — the VISION.md goal actually holds and no in-scope work remains; a premature done is a rejection. Default to rejection when uncertain. Output exactly `ACCEPT` or `REJECT: <numbered reasons>`."

## Step 4 — relay and record the verdict

Report the agent's `ACCEPT` or `REJECT: <reasons>` verdict verbatim, then increment `Accepted` or `Rejected` on the Metrics line of the loop's STATE.md. If Rejected now outnumbers Accepted, warn the user: acceptance is below the 50% kill switch — kill the loop and redesign. On REJECT, remind the user: fixes go back through the loop and then a fresh `/loop-review` — the maker never self-approves its own corrections.
