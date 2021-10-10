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

#### Manage multiple monitors
Use `wdisplays` as a convenient GUI front end to configure displays in Wayland compositors.
Configure your monitor layout until you are happy.
Save the configuration with a human-readable name. E.g.
```shell
outputs2kanshi --save my-monitor-setup
```

#### Change the default display manager
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