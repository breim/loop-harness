# Changelog

Notable changes to loop-harness. Follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/) and [Semantic Versioning](https://semver.org/).

## [0.2.0] - 2026-07-08

### Added

- Success exit for scaffolded loops: a run that finds the goal met (or no in-scope work left) records the reason under "Stop conditions met" and ends with `LOOP DONE: <reason>`, the signal for `/loop` wrappers and schedulers to stop re-invoking.
- Metrics tally in scaffolded `STATE.md` (`Runs · Accepted · Rejected`): the loop counts runs, `/loop-review` records verdicts and warns when acceptance falls below the 50% kill switch.
- `loop-verifier` check 6: a declared "done" is verified independently; a premature done is a rejection.
- Worked examples in `examples/`: `ci-triage` (recurring loop) and `lint-fix` (finite loop ending with `LOOP DONE`).
- This changelog.

### Changed

- One canonical lifecycle across README and skills: every batch, at every rollout stage, ends with `/loop-review`.
- `loop-verifier` no longer treats the loop's own `STATE.md` bookkeeping as scope creep (it is still checked for truthfulness).
- README documents that `npx skills add` installs the skills but not the `loop-verifier` agent (`/loop-review` falls back to a general-purpose subagent; the plugin install provides the dedicated agent).

### Fixed

- README skill count ("four skills" now correctly described as three slash commands plus the auto-triggered `loop-engineering`).
- Owner email in `.claude-plugin/marketplace.json` now matches `plugin.json`.

## [0.1.1] - 2026-06-11

### Changed

- `npx skills add breim/loop-harness` became the primary install method.
- Qualification gate simplified from four conditions to two (dropped "repeats at least weekly" and "agent can run the code it changes").

## [0.1.0] - 2026-06-11

### Added

- Initial release: `/loop-check` (qualification gate), `/loop-init` (scaffolding), `/loop-review` (independent verification), the `loop-engineering` methodology skill, and the `loop-verifier` agent.
- MIT license, install script, and Claude Code plugin manifests.
