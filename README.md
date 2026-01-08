# dotfiles

## Setup

1. Install [`chezmoi`](https://www.chezmoi.io/install/), `curl`, and `git`.
    TL;DR for `chezmoi`:
    ```bash
    sh -c "$(curl -fsLS get.chezmoi.io)"
    ```
2. Run
   ```bash
   chezmoi init --ssh patzm
   ```
   Omit the `--ssh` if you just want to deploy a configuration.

## `ssh` configuration
To add keys to the agent, add them once with
```bash
ssh-add ~/.ssh/id_ed25519
```

## OS-dependent

### macOS


### Arch

#### With Hyprland

Install https://github.com/JaKooLit/Arch-Hyprland afterwards.
