# arshbot's dotfiles

Pretty self explanitory. `setup.*.sh` scripts are OS specific. 

## Useful shortcuts

### Running

```
$ sudo bash setup_popos.sh
$ exit # No idea why this is necessary, but sudo or bash drops the script
       # into a shell that needs to be exited
```

### Download via zipfile

```
# Pop!_os

$ cd ~/Downloads
$ wget bit.ly/arshbotdotfileszip -O dotfiles.zip
$ unzip dotfiles.zip
```

## bit.ly links

| shortened link | Use case |
| -------------- | -------- |
| bit.ly/arshbotsetuppop | setup_popos.sh |
| bit.ly/arshbotdotfilesgit | .git file for dotfiles repo; useful for git installing dotfiling |
| bit.ly/arshbotdotfileszip | zip file useful for downloading when git not available |

# Gnome extensions to install

| Name | Purpose | Link |
| ---- | ------- | ---- |
| Netspeed | To monitor bandwidth usage on the fly. Very useful when traveling | https://extensions.gnome.org/extension/104/netspeed/ |
| Workspace Matrix | Creates an n by n matrix of desktops | https://extensions.gnome.org/extension/1485/workspace-matrix/ |

# gpg setup

Including this because I forget how to literally every time

```
# gpg should be installed already. If not gl
# Download Harsha\ Goli\ Secret.asc from secure source
$ gpg --import Harsha\ Goli\ Secret.asc
# Use pass from manager to get past armour
```

# tmux notes

* the git patch for kube-tmux: https://github.com/jonmosco/kube-tmux/issues/12#issuecomment-570996392
