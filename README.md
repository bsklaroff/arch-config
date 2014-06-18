# Arch Config
My Arch Linux configuration for an Acer C720 Chromebook. I save it as

    ~/.arch_config

and then set up my system with

    cd ~/.arch_config
    ./setup.sh

This installs some packages, soft links the config files to their proper
locations, and starts some systemd services

## What is all this stuff?
- `paclist.txt` is a list of packages installed with pacman on my system,
generated with the command `pacman -Qetn | cut -d' ' -f1`
- `dotfiles` contains the hidden config files and folders in my home directory,
such as `.bashrc`, `.xinitrc`, `.xmonad`, etc
- `etc` contains the system config files found in `/etc` and its
subdirectories, such as sound and touchpad settings
