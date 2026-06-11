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

## Step 4 — relay the verdict

Report the agent's `ACCEPT` or `REJECT: <reasons>` verdict verbatim. On REJECT, remind the user: fixes go back through the loop and then a fresh `/loop-review` — the maker never self-approves its own corrections.
