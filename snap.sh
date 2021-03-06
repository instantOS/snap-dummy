#!/bin/bash

source /usr/share/paperbash/import.sh
pb dialog
messagebox "warning: snaps come with significantly higher resource and storage usage. \
They also put no restrictions on low quality or broken applications and have no way to distinguish them from working programs. \
use only if you have to. "

if ! confirm "are you sure you want to enable snap support?"; then
    clear
    echo "good choice, but that's just my opinion..."
    exit
fi

clear

yay -S snapd || exit
sudo pacman -R --noconfirm snap-dummy

sudo systemctl enable --now snapd.socket
# make pamac show snaps
echo 'EnableSnap' | sudo tee -a /etc/pamac.conf

sleep 2
if confirm "a reboot is required. would you like to reboot now?"; then
    reboot
else
    echo "snap installation done"
fi
