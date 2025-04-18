# Various configurations scripts

* autorandr
* git
* htop
* i3wm (i3-gaps)
* polybar
* python (virtualenv)
* ranger
* sublime text
* sway wm
* [terminals](https://github.com/patzm/dotfiles/tree/master/roles/terminals):
  * [Alacritty](https://github.com/alacritty/alacritty)
  * [Kitty](https://github.com/kovidgoyal/kitty)
* tmux
* neovim
* zsh

## `ssh` key :key: generation
Generate a new key
```shell
ssh-keygen -t ed25519 -C "your_email@example.com"
```

and add it here: https://github.com/settings/keys.

It is convenient to set the following in your `~/.ssh/config` file:
```ini
Host *
    AddKeysToAgent yes
    # If you are on macOS
    UseKeychain yes
```

## Setup
Clone the repo
```shell
git clone https://github.com/patzm/dotfiles.git ~/repos/dotfiles
```

Run the OS-specific bootstrap script:
* Arch / Manjaro:
  ```shell
  ./arch-bootstrap
  ```
* macOS:
  ```shell
  ./mac-bootstrap
  ```
  and then run the `export` command that got printed.
* Ubuntu:
  ```shell
  ./ubuntu-bootstrap
  ```

Then run the anisble playbook roles for localhost
```shell
ansible-playbook setup.yml --tags tag1,tag2 -i localhost, --connection=local
```

or remote host[s]
```shell
ansible-playbook setup.yml --tags tag1,tag2 -i 'host1,host2'
```

Add `-K` when including tags that require elevated permissions, like `packages`.

After the first run, switch your shell to `zsh`:
```shell
chsh -s $(which zsh)
```  

## Tags
Tags are used to select specific roles, parts of them, or groups of roles.
The available tags are:
* browser: synchronizes Firefox user dictionaries and copies the default user configuration
* dotfiles: well, dotfiles
* packages: sets up the host operating system with the default packages

## Examples
Install dotfiles
```shell
ansible-playbook --tags dotfiles,browser
```

Install all packages for the current OS, this requires `root` permissions:
```shell
ansible-playbook -K --tags packages
```

Run anything from above for remote host(s)
```shell
ansible-playbook <other-args> -i 'my-remote-machine,'
```

## Cheat-sheet for post-installation usage

### `i3`

#### Wallpaper
There are various ways to set the wallpaper.
The recommended way is to use `nitrogen` to set the wallpaper.
This will also persist across sessions.

An alternative is to use `hsetroot`.

#### Manage multiple monitors
Use `arandr` as a convenient GUI front end for XRandR to configure your monitor(s).
Once you are happy, save the configuration with a human-readable name. E.g.
```shell
autorandr --save my-monitor-setup
```

### `sway`

#### Configure environment variables
By default, `sway`, and in general Wayland desktop managers don't read files that were commonly used in XOrg to set environment variables.
For instance
* `.profile`
* `.xprofile`

To bring back this easy way of pre-configuring environment variables and optionally running some `bash` commands before, we launch `sway` through a `bash` login session (using the `-l` flag).
The `sway` role will install a custom `.bash_profile` which is configured to source the legacy profile configs.

To do so, replace the `Exec` line in `/usr/share/wayland-sessions/sway.desktop` with
```
Exec=bash -cl sway
```

#### Manage multiple monitors
Use `wdisplays` as a convenient GUI front end to configure displays in Wayland compositors.
Configure your monitor layout until you are happy.
Save the configuration with a human-readable name. E.g.
```shell
outputs2kanshi --save my-monitor-setup
```

#### Change the default display manager
_Note_: the `sway` role switched to GDM by default.

To get the current display manager, run
```shell
sudo systemctl status display-manager
```

To enable `ligthdm`, run
```shell
sudo systemctl disable greetd  # if greetd is the current active display manager
sudo systemctl enable lightdm
```

And make sure that `/etc/lightdm/lightdm.conf` contains at least these lines

```conf
[LightDM]
run-directory=/run/lightdm
sessions-directory=/usr/share/lightdm/sessions:/usr/share/xsessions:/usr/share/wayland-sessions

[Seat:*]
greeter-session=lightdm-gtk-greeter
session-wrapper=/etc/lightdm/Xsession
```

### Gnome with Wayland
Remove all existing `gnome*.desktop`, such that they don't appear in your display manager:
```shell
sudo rm /usr/shares/xsessions/gnome*.desktop
```

Also, fix the default Wayland session file to contain
```
Exec=/usr/bin/gnome-shell --wayland
TryExec=/usr/bin/gnome-shell
```

To get legacy tray icons / applets working again, e.g. for Nextcloud, install the [Gnome extension _AppIndicator and KStatusNotifierItem Support_](https://extensions.gnome.org/extension/615/appindicator-support/).

### Firefox (browser)
A GitHub Gist token and config file are required for the user dictionary sync to work.
Check [`python-gist`](https://pypi.org/project/python-gist/) for the details.

### macOS
Run
```shell
./mac-bootstrap
export PATH="/opt/homebrew/bin:${PATH}"  # for Arm Macs
```

#### Fonts
Some programs or terminals are configured to use fonts that can't be installed in an already packaged version.
Simply manually install them from [the `roles/fonts/files/meslo-nerd-font` sub-folder](https://github.com/patzm/dotfiles/tree/master/roles/fonts/files/meslo-nerd-font) manually.

#### `brew` for a multi-user system
TL;DR: run
```shell
sudo chgrp -R admin $(brew --prefix) 
sudo chmod -R g+rwX $(brew --prefix)
```
[SO source](https://stackoverflow.com/a/44481141/3702319).

### Windows :see_no_evil:

Disable external numpads triggering the Office key (emulated as `Shift+Control+Alt+Windows`, [source](https://www.howtogeek.com/445318/how-to-remap-the-office-key-on-your-keyboard/))
```powershell
REG ADD HKCU\Software\Classes\ms-officeapp\Shell\Open\Command /t REG_SZ /d rundll32
```

# Ansible cheat-sheet

## Possible values for `ansible_distribution`
| Common name | Ansible name  |
| ----------- | ------------- |
| RedHat      | `RedHat`      |
| Fedora      | `RedHat`      |
| CentOS      | `RedHat`      |
| Scientific  | `RedHat`      |
| SLC         | `RedHat`      |
| Ascendos    | `RedHat`      |
| CloudLinux  | `RedHat`      |
| PSBM        | `RedHat`      |
| OracleLinux | `RedHat`      |
| OVS         | `RedHat`      |
| OEL         | `RedHat`      |
| Amazon      | `RedHat`      |
| XenServer   | `RedHat`      |
| Ubuntu      | `Debian`      |
| Debian      | `Debian`      |
| SLES        | `Suse`        |
| SLED        | `Suse`        |
| OpenSuSE    | `Suse`        |
| SuSE        | `Suse`        |
| Gentoo      | `Gentoo`      |
| Archlinux   | `Archlinux`   |
| Mandriva    | `Mandrake`    |
| Mandrake    | `Mandrake`    |
| Manjaro     | `Archlinux`   |
| Solaris     | `Solaris`     |
| Nexenta     | `Solaris`     |
| OmniOS      | `Solaris`     |
| OpenIndiana | `Solaris`     |
| SmartOS     | `Solaris`     |
| AIX         | `AIX`         |
| Alpine      | `Alpine`      |
| MacOSX      | `MacOSX`      |
| FreeBSD     | `FreeBSD`     |
| HPUX        | `HP-UX`       |
