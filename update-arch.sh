#!/bin/sh

sudo pacman -Syu
sudo pacman -R $(pacman -Qdtq)
paru -Syu
paru -R $(paru -Qdtq)
flatpak update
sudo snap refresh
