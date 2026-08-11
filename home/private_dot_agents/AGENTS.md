# Personal Root Agent Guide

Shared baseline instructions for all local agent tools. Keep this file personal and tool-agnostic.

## Starting a task
- Assess the difficulty of the task. If non-trivial, find relevant skills for it.

## Editing defaults

- Use direct file editing tools for file changes. Do not use Python scripts to edit files.
- Keep edits minimal, scoped, and consistent with the target style.
- When writing code, use the [~/.local/share/ponytail/AGENTS.md](ponytail skill) by default.

## Version control work

- Commit only when explicitly requested with the keyword "commit".
- Use granular commits: one concept, refactor, or idea per commit.
- Push means push to remote.
- Worktree means do the requested work in a git worktree.
- If the task includes opening or pushing a PR, ask whether local cleanup is requested after handoff.
- Local cleanup means deleting the local branch and worktree.
- For PRs: file the PR, check existing labels, add relevant labels, and keep the PR description crisp.

## Communication defaults

- Prefer concise status updates.
- Show changed file paths and key verification steps.
- Offer short numbered next steps when useful.
