# dotfiles

## Setup

1. Install [`chezmoi`](https://www.chezmoi.io/install/), `curl`, and `git`.
   TL;DR for `chezmoi`:
   ```bash
   sh -c "$(curl -fsLS get.chezmoi.io)" -- -b $HOME/.local/bin
   ```
2. Run
   ```bash
   chezmoi init --ssh patzm
   ```
   Omit the `--ssh` if you just want to deploy a configuration.

## Update
The default command to run if things have changed is
```bash
chezmoi update
```

If you want to avoid installing any packages, run with `--exclude=scripts`.

## Profiles

Profile defaults to `default` (dotfiles + CLI packages). Set `CHEZMOI_PROFILE=desktop` in the environment for window managers and GUI packages.

## `ssh` configuration
To add keys to the agent, add them once with
```bash
ssh-add ~/.ssh/id_ed25519
```

## OS-dependent

### macOS


### Arch

#### With Hyprland

Set `CHEZMOI_PROFILE=desktop`, then install https://github.com/JaKooLit/Arch-Hyprland afterwards.
