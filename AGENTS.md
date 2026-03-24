# Agent Notes

## Environment Constraint

This workspace runs in an environment where `apply_patch` may fail because the
underlying sandbox launcher invokes `bwrap` with unsupported flags.

## Editing Guidance

When working in this repository:

1. Do not rely on `apply_patch`.
2. Prefer non-`bwrap` editing paths such as direct shell-based file edits.
3. Prefer `sed`, `perl -0pi`, or other simple file-safe edit commands for small
   updates.
4. Use formatting and validation commands after edits.

## Reason

The installed `bubblewrap` version in this environment does not support the
`--argv0` flag used by the patch tool wrapper, which causes patch application to
fail before the repository code is even reached.
