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
- Commit protocol (strict):
  - `commit` means: create commit(s) now.
  - Before committing:
    - inspect staged and unstaged diffs
    - identify logical change groups
  - Commit grouping rules:
    - default to multiple granular commits when more than one concern is present
    - one commit = one concern (e.g., package data, CLI behavior, tests/refactor)
    - never mix unrelated concerns
    - if only one logical concern exists, one commit is fine
  - If grouping is ambiguous, propose a commit plan first and wait for confirmation.
  - Before finalizing commit(s), run:
    - `git --no-pager diff --name-only`
    - `git --no-pager diff --stat`
    - targeted tests for touched behavior
- Push protocol:
  - push means push to remote
- Worktree means do the requested work in a git worktree.
- If the task includes opening or pushing a PR, ask whether local cleanup is requested after handoff.
- Local cleanup means deleting the local branch and worktree.
- For PRs: file the PR, check existing labels, add relevant labels, and keep the PR description crisp.
- Never merge PRs directly. Always hand off merge to the operator, or get explicit user confirmation immediately before invoking any merge action.

## Communication defaults

- Prefer concise status updates.
- Show changed file paths and key verification steps.
- Offer short numbered next steps when useful.

## Coding

### Python

- run tools through `uvx`
- run packaged scripts through `uv run` or `source .venv/bin/python` (assuming that a virtual environment is set up and exists in that folder)
