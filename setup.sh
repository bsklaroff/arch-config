#!/bin/bash

# Install and update packages if specified
if [[ "$1" == "-p" ]]
then
  sudo pacman -Syu --needed $(< paclist.txt)
fi

function link_files () {
  base_dir=$1
  prefix_len=$((${#base_dir}+6))
  echo "Linking $base_dir dotfiles..."
  # Soft link common dotfiles into home directory
  for f in $base_dir/dotfiles/*
  do
    ln -sf "$(pwd)/$f" "$HOME/.$(basename $f)"
  done

  # Remove annoying recursive soft links
  rm $base_dir/dotfiles/xmonad/xmonad
  rm $base_dir/dotfiles/vim/vim

  echo "Linking $base_dir rootfiles..."
  # Make directories as needed
  for d in $(find $base_dir/root -type d)
  do
    sudo mkdir -p "/${d:$prefix_len}$"
  done
  # Soft link common files into / directory
  for f in $(find $base_dir/root -type f)
  do
    sudo ln -sf "$(pwd)/$f" "/${f:$prefix_len}"
  done
}

link_files 'common'
link_files 'acer-c720'

# Generate locale in /etc/locale.gen
sudo locale-gen
# Set localtime
sudo ln -sf /usr/share/zoneinfo/US/Eastern /etc/localtime
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
# Start music player daemon
sudo systemctl enable mpd
sudo systemctl restart mpd

echo 'Done!'

# For hibernation (only needed once):
# Make swapfile
## sudo fallocate -l 512M /swapfile
## sudo chmod 600 /swapfile
## sudo mkswap /swapfile
## sudo swapon /swapfile
# Add the line '/swapfile none swap defaults 0 0' to /etc/fstab
# Find <Root UUID> in /etc/fstab
# Run 'sudo filefrag -v /swapfile' and look at first row of physical_offset
# column to find <Swap File Offset>
# Then add kernel parameters to the APPEND line of /boot/syslinux/syslinux.cfg:
# resume=/dev/disk/by-uuid/<Root UUID> resume_offset=<Swap File Offset>
# Finally, make sure resume hook is in /etc/mkinitcpio.conf after block and
# before filesystems

# Rebuild mkinitcpio (anytime /etc/mkinitcpio.conf is changed)
## mkinitcpio -p linux

# For mpd (only needed once):
## sudo touch {/run/mpd/mpd.pid,/var/log/mpd/mpd.log,/var/lib/mpd/{mpd.pid,mpdstate}}
## sudo chown mpd {/run/mpd/mpd.pid,/var/log/mpd/mpd.log,/var/lib/mpd/{mpd.pid,mpdstate}}
## sudo chgrp mpd {/run/mpd/mpd.pid,/var/log/mpd/mpd.log,/var/lib/mpd/{mpd.pid,mpdstate}}
