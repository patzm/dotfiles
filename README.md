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
* terminals
* tmux
* vim
* zsh

## Setup
Clone the repo
```shell
git clone https://github.com/patzm/dotfiles.git ~/repos/dotfiles
```

Run the OS-specific bootstrap script:
* Arch / Manjaro: `./arch-bootstrap`
* macOS: `./mac-bootstrap`
* Ubuntu: `./ubuntu-bootstrap`

Then run the setup routines through the helper script `setup`.

Help:
```
usage: setup [-h] [-K] [--hosts [HOSTS ...]] [--tags [TAGS ...]]

facilitator to launch setup.yml

optional arguments:
  -h, --help           show this help message and exit
  -K                   prompt for SUDO password
  --hosts [HOSTS ...]  specify any remote hosts if not the local host
  --tags [TAGS ...]    specify tags
```

## Examples
Install dotfiles
```shell
./setup --tags dotfiles
```

Install all packages for the current OS, this requires `root` permissions:
```shell
./setup -K --tags packages
```

Run anything from above for remote host(s)
```shell
./setup <other-args> --hosts my-remote-machine,
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

### Keychron function keys

Sometimes the system disables function keys for my Keychron K2.
To re-enable them, simply run
```shell
echo 0 | sudo tee /sys/module/hid_apple/parameters/fnmode
```
