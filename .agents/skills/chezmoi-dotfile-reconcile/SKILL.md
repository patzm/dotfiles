---
name: chezmoi-dotfile-reconcile
description: Reconcile local dotfile drift back into this chezmoi repo. For templated sources (*.tmpl), propose a smart merge into the template instead of blind add; for non-template sources, use chezmoi add. Ask the user when reconciliation intent is ambiguous.
---

# Chezmoi Dotfile Reconcile

Use this skill when the user wants to bring local dotfile changes back into this chezmoi repo.

## Goal

Keep one source of truth in chezmoi source files while avoiding template breakage.

## Workflow

1. Preflight Bitwarden session before running chezmoi commands that may read secret-backed templates.
   - Run `bw status`.
   - If status is not `unlocked`, stop and ask the user to leave this session, run `bw_unlock`, and re-enter.
2. Confirm the target file(s) and inspect corresponding chezmoi source path(s).
3. For each file, choose one reconciliation mode explicitly:
   - **Update committed from local** (promote local drift into source)
   - **Apply committed to local** (discard local drift and enforce source)
   - **Ignore local-only drift** (machine-specific; keep out of source)
4. Classify each source file:
   - **Template-backed**: source path ends with `.tmpl`.
   - **Non-template**: source path does not end with `.tmpl`.
5. Apply the correct reconciliation strategy per file type.
6. If intent is unclear, ask a focused question before editing.

## Rules

### A) Non-template sources

If the source file is not templated, use `chezmoi add` as a merge helper, not as a blind overwrite.

1. Read both files first: destination target file and current source file.
2. Run `chezmoi add <target-file>`.
3. Immediately review source diff in git.
4. Keep local drift that should be reconciled, but restore source-only settings that were unintentionally deleted.

Default for ambiguous deletions in non-template files: preserve existing source settings and ask before removing them.

Quick safety checks before keeping the add result:

- Did entire sections disappear (for example `[submodule]`, `Host`, plugin lists)?
- Did only formatting/indentation change without semantic value?
- Did machine-local values replace previously shared values?

If any answer is "yes", do not keep the raw add result without user confirmation.

If mode is **apply committed to local**, do not use `chezmoi add`; use `chezmoi apply --source-path <source-file>`.

If mode is **ignore local-only drift**, make no source edit and call it out in the summary.

### B) Template-backed sources (`*.tmpl`)

Do **not** blindly run `chezmoi add` when it would overwrite template logic with rendered concrete values.

Instead, propose a smart reconciliation:

1. Compare target drift with current template output.
2. Port only meaningful logic/content changes into the `.tmpl` source.
3. Preserve existing template directives (`{{ ... }}`), conditionals, and data-driven structure.
4. If new host/user-specific values appeared, prefer parameterizing via template data rather than hard-coding.

When the right abstraction is uncertain, present 2-3 options (for example: literal value, template variable, or machine-specific include) and ask the user to choose.

If mode is **apply committed to local**, do not edit template source unless requested; apply current rendered template to target and verify drift is gone.

If mode is **ignore local-only drift**, keep template source unchanged and call out the ignored local drift.

## Non-obvious cases (must ask)

Ask the user what to do when any of these apply:

- A rendered change could be either universal or machine-specific.
- A change removes or conflicts with existing template conditionals.
- Multiple files could reasonably own the same setting.
- The user’s intent (global default vs host override) is not explicit.

Ask concise, decision-oriented questions and include a recommended default.

## Output expectations

- Summarize each file as: `template` or `non-template`.
- State exactly what was changed in source files.
- Call out any unresolved choices.
- Reference edited files with project-relative paths.
