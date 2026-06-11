# Naming session — project rename (otto → loop-harness)

## Diagnosis

- **State N4 (wrong signals):** "otto" reads as a person's name or bot mascot; communicates nothing about loop engineering.
- **State N3 (forgettable/unfindable):** zero keyword overlap with how anyone searches for this ("loop engineering", "claude code", "harness").
- **State N2 (family coherence):** commands are `/loop-check`, `/loop-init`, `/loop-review`; the repo name should belong to the same `loop-*` family.

## Candidates evaluated

| Candidate | Meaning layer | Functional layer | Outcome |
|---|---|---|---|
| loop-harness | Literal — the user's own term ("harness for engineering") | Perfect search keywords; kebab-case dev-tool convention; only minor GitHub collisions (≤30★) | **Selected** |
| loopsmith | Metaphor — a smith who forges loops; memorable single word | Minor collisions; weaker literal search | Runner-up |
| loop-forge | Good metaphor | 62 GitHub collisions incl. LoopForge with traction | Rejected |
| loopwright | Maker-of-loops suffix | Sound-alike of Playwright (anti-pattern) | Rejected |

## Decision

**loop-harness**, chosen by the user 2026-06-11.

GitHub description: "Loop engineering harness for Claude Code — qualify, scaffold, and verify automated agent loops."

Rationale: aligns all four layers — literal meaning matches what the tool is, searchable by its actual keywords, coheres with the `loop-*` command family, and follows the descriptive kebab-case convention of developer tooling.
