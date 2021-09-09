#!/bin/sh

sudo pacman -Syu
sudo pacman -R $(pacman -Qdtq)
yay -Syu
yay -R $(yay -Qdtq)
flatpak update
snap refresh
