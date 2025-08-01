# dotfiles

## Setup

1. Install `chezmoi`
2. Run
   ```bash
   chezmoi init --ssh --branch dev/chezmoi patzm
   ```
   Omit the `--ssh` if you just want to deploy a configuration.

## `ssh` configuration
To add keys to the agent, add them once with
```bash
ssh-add ~/.ssh/id_ed25519
```
