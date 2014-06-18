#!/bin/bash

# Install and update packages if specified
if [[ "$1" == "-p" ]]
then
  sudo pacman -Syu --needed $(< paclist.txt)
fi

echo 'Linking dotfiles...'
# Soft link dotfiles into home directory
for f in dotfiles/*
do
  ln -sf "$(pwd)/$f" "$HOME/.$(basename $f)"
done

# Remove annoying recursive soft links
rm dotfiles/xmonad/xmonad
rm dotfiles/vim/vim

echo 'Linking etc...'
# Soft link etc files into /etc directory
for f in $(find etc -type f)
do
  sudo ln -sf "$(pwd)/$f" "/$f"
done

# Generate locale in /etc/locale.gen
sudo locale-gen
# Set localtime
sudo ln -sf /usr/share/zoneinfo/US/Pacific /etc/localtime
# Set the hardware clock to UTC
sudo hwclock --systohc --utc

echo 'Starting systemd services...'
### Systemd services
# Automatically connect to WiFi
sudo systemctl enable netctl-auto@wlp1s0
sudo systemctl restart netctl-auto@wlp1s0
# Sync date and time over the Internet
sudo systemctl enable ntpd
sudo systemctl restart ntpd

echo 'Done!'

# Patch touchpad kernel modules (only needed once)
# wget http://pastie.org/pastes/9074242/download -O cros-haswell-modules-archlinux.sh
# chmod +x cros-haswell-modules-archlinux.sh
# ./cros-haswell-modules-archlinux.sh
