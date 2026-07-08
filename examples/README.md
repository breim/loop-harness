# Examples

Two worked loops, exactly as `/loop-init` scaffolds them, shown after a few real runs. Read them to see what a healthy loop looks like before installing anything.

- [`ci-triage/`](ci-triage): a **recurring** loop. Nightly CI triage never "finishes", so "Stop conditions met" stays empty and the hard stop bounds each run.
- [`lint-fix/`](lint-fix): a **finite** loop. It migrates one directory per run toward a strict ESLint config, then ends itself with `LOOP DONE` once the goal holds.

These files are documentation, not installable skills: copy the shape, not the content.
