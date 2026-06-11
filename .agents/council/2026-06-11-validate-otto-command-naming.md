# Council Report — validate: otto command naming

- Date: 2026-06-11
- Mode: verdict (default), 3 judges, parallel, independent
- Subject: proposal to rename `/otto:loop-check`, `/otto:loop-init`, `/otto:loop-review` to `/otto:check`, `/otto:init`, `/otto:review`

## Consensus

**FAIL — keep the current `loop-*` names.** (Rule: any FAIL → FAIL. Votes: 1 PASS / 2 FAIL.)

## Judge verdicts

| Judge | Perspective | Verdict | Confidence |
|---|---|---|---|
| 1 | Developer ergonomics / DX | PASS | 78 |
| 2 | API design / naming, future-proofing | FAIL | 85 |
| 3 | Claude Code ecosystem conventions | FAIL | 85 |

## Consolidated findings

**Against the rename (majority):**

- `otto` is an opaque brand name carrying no domain meaning, so the command segment must carry it all. `/otto:init` reads as "initialize otto" — and Claude Code ships a built-in `/init` that means exactly that. The bare verb actively misleads.
- `check` and `review` are near-synonyms; the `loop-` noun is what anchors the timeline (check = pre-flight GO/NO-GO on a task; review = post-hoc ACCEPT/REJECT on output). Strip it and the pair becomes a coin flip for both user and model.
- Fuzzy-autocomplete collisions: the environment has built-in `/init`, `/review`, `/code-review`, `/security-review`, plus `cost-budget-check`, `dependency-check`. Generic verbs increase menu ambiguity; `loop-*` tokens are unambiguous.
- Ecosystem survey (37 installed plugins): the prevailing convention repeats the domain in the command (`ralph-loop:cancel-ralph`, `gaia-run`, `kg-extract`, `ddd-validate`). Bare verbs are the rare exception. `otto:loop-check` fits the norm.
- Typing "/loop" surfaces all three otto commands next to built-in `/loop` and ralph-loop — discoverability asset for a loop kit, forfeited by the rename.
- CLI precedent: bare verbs bind to a tool's primary noun (`git init` → repo). If otto is meant to grow into an umbrella toolkit, bare verbs squat its most valuable namespace and force a breaking rename later.

**For the rename (dissent, recorded verbatim in spirit):**

- Canonical names are typed in prose (READMEs, prompts, chat) where autocomplete doesn't help; shorter names pay off there.
- `/otto:loop-init my-sync-loop` says "loop" three times; with only three commands, all loop-related, the prefix adds zero information today. YAGNI applies to names; renaming three markdown files later costs minutes.

## Optional polish surfaced (not required)

- Judge 2: consider `loop-review` → `loop-verify` to mirror the `loop-verifier` agent and sharpen the contrast with `loop-check`. Only worth doing pre-1.0, if at all.
- Judge 3: a stale `otto-loops` 0.1.0 entry remains in the plugin cache from the previous install — harmless, can be cleaned.

## Decision guidance

Keep `/otto:loop-check`, `/otto:loop-init`, `/otto:loop-review`. Do not split the verb scheme (renaming only one command was judged strictly worse by all perspectives that considered it). A `/otto:loop <action>` dispatcher was considered and rejected: it trades per-command descriptions and argument-hints for internal routing at n=3.
