---
name: loop-engineering
description: Loop engineering methodology — use when designing, reviewing, or debugging automated agent loops (systems that prompt the agent on a schedule instead of by hand)
---

# Loop engineering

A loop is a small system that finds work, hands it to an agent, checks the result with an objective gate, records what happened, and decides the next move — without a human prompting each step.

## When to use, when not to

Use a loop for repetitive, machine-checkable work: CI failure triage, dependency bumps, lint-and-fix passes, flaky test reproduction, issue-to-PR drafts on well-tested code.

Do not loop on judgment-call work: architecture rewrites, auth or payments code, production deploys, vague product decisions. For one-off tasks, a single well-aimed prompt wins.

## The 4-condition test

Build a loop only if all four hold. Miss one and the loop costs more than it returns.

| Condition | Why |
|---|---|
| The task repeats at least weekly | Setup cost must amortize across runs |
| Verification is automated (test/build/lint/typecheck rejects bad output) | Otherwise a human reads every diff — the job the loop was meant to remove |
| The token budget absorbs waste | Loops re-read context, retry, explore; that burns tokens regardless of output |
| The agent has senior-engineer tools (run the code, see logs, reproduce) | Otherwise the loop iterates blind |

## The 30-second checklist

Before turning a specific task into a loop, all five boxes must check:

1. Happens at least weekly
2. An objective gate can reject bad output
3. The agent can run the code it changes
4. The loop has a hard stop (token budget, iteration count, or time limit)
5. A human approves before merge, deploy, or dependency changes

## The 5 building blocks

1. **Automation** — the heartbeat. `/loop` for session cadence, scheduled tasks or cron for unattended runs. Pair with a goal condition checked by a model that did not write the code.
2. **Worktrees** — parallel agents each get their own git worktree so edits cannot collide. Your review bandwidth, not the tool, is the ceiling on parallelism.
3. **Skills** — project knowledge written once, read every run. Without one, the loop re-derives context from zero each cycle.
4. **Connectors (MCP)** — the loop acts in real tools: GitHub first, then issue tracker, Slack, error tracker.
5. **Maker/checker sub-agents** — the agent that wrote the code never grades it. A separate verifier with no exposure to the maker's reasoning issues ACCEPT or REJECT.

## State pattern

- **STATE.md** — working memory across runs: last run, in progress, completed, escalated, lessons learned, stop conditions met. The agent forgets; the file does not.
- **VISION.md** — standing spec reread at the start of every run: goal, scope, gate, hard stops, approval boundaries. Prevents goal drift as context gets summarized away.

## Minimum viable loop

One automation + one skill + one state file + one gate. Order matters:

1. Get one manual run reliable
2. Turn it into a skill
3. Wrap it in a loop
4. Only then schedule it

Skipping ahead is how loops fail in production.

## Failure modes

- **Ralph Wiggum loop** — the agent emits "done" early and the loop exits on a half-finished job. Fix: an objective gate (exit code), never a second agent's opinion.
- **Goal drift** — constraints disappear after summarization. Fix: reread VISION.md every run.
- **Self-preferential bias** — the maker grades its own homework as A+. Fix: the `loop-verifier` agent.
- **Agentic laziness** — "done enough" at partial completion. Fix: goal condition checked by a fresh model.

The metric is **cost per accepted change**, not tokens spent or tasks attempted. If acceptance drops below 50%, the loop is losing — kill it and redesign.

## Security checklist

- Generated code never merges without human review plus security checks in the gate
- Audit skill sources before installing — descriptions are injection vectors
- Sanitize logs; disable verbose logging in unattended loops
- Re-audit the loop's permissions every 30 days
- Never let a loop touch architecture, auth, or payments
