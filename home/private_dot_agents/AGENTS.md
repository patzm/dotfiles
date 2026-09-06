# Personal Root Agent Guide

Shared baseline instructions for all local agent tools. Keep this file personal and tool-agnostic.

## Starting a task
- Assess the difficulty of the task. If non-trivial, find relevant skills for it.

## Editing defaults

- Use direct file editing tools for file changes. Do not use Python (scripts) to edit files.
- Keep edits minimal, scoped, and consistent with the target style.
- When writing code, use the [~/.local/share/ponytail/AGENTS.md](ponytail skill) by default.

## Version control work

- Commit only when explicitly requested with the keyword "commit".
- Push protocol:
  - push means push to remote
- Worktree means do the requested work in a git worktree.
- If the task includes opening or pushing a PR, ask whether local cleanup is requested after handoff.
- Local cleanup means deleting the local branch and worktree.
- For PRs: file the PR, check existing labels, add relevant labels, and keep the PR description crisp.
- Never merge PRs directly. Always hand off merge to the operator, or get explicit user confirmation immediately before invoking any merge action.

## Commit discipline

When the user says `commit`:

- Treat `commit` as a single-use authorization scoped to the current prompt only.
- Execute the requested commit workflow for this prompt, then immediately clear that authorization.
- Do not carry commit permission forward to later prompts; wait for a fresh `commit` instruction each time.
- `commit` means: create commit(s) now.
- Inspect pending changes first:
  - `git --no-pager diff --name-only`
  - `git --no-pager diff --stat`
- Group changes by intent, not file proximity.
- Default to very granular commits: one commit for each thought that led to an implementation.
- One commit = one concern.
- If grouping is ambiguous, propose a commit plan and wait for confirmation.
- Stage and commit one concern at a time.
- Before finalizing commit(s), run targeted tests for touched behavior.
- After committing, verify clean state:
  - `git --no-optional-locks status --short --branch`

Heuristic: if two changes can be reverted independently without harming each other, they should be separate commits.

## Communication defaults

- Prefer concise status updates.
- Show changed file paths and key verification steps.
- Offer short numbered next steps when useful.

## Coding

### Python

- run tools through `uvx`
- run packaged scripts through `uv run` or `source .venv/bin/python` (assuming that a virtual environment is set up and exists in that folder)


