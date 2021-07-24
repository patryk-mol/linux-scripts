#!/bin/sh

sudo pacman -Syu
sudo pacman -R $(pacman -Qdtq)
flatpak update
snap refresh
