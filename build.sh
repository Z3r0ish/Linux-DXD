#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

rm -rf ./airootfs/etc/skel
rm -rf ./airootfs/etc/os-release
rm -rf ./airootfs/etc/hostname
rm -rf ./airootfs/usr/share/wallpapers
rm -rf ./airootfs/dxd/neofetch
rm -rf ./syslinux/splash.png

rsync -rl ./theming/skel/ ./airootfs/etc/skel
rsync -rl ./theming/hostname ./airootfs/etc/
rsync -rl ./theming/os-release ./airootfs/etc/
rsync -rl ./theming/wallpapers ./airootfs/usr/share/wallpapers
rsync -rl ./theming/neofetch ./airootfs/dxd/neofetch
rsync -rl ./theming/splash.png ./syslinux/splash.png

rm -rf /tmp/linux-dxd
mkarchiso -C ./pacman.conf -v -w /tmp/linux-dxd -o ./output ./ -h

rm -rf /tmp/linux-dxd