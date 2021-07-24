#!/bin/sh

pacman -Syu
pacman -R $(pacman -Qdtq)
flatpak update
snap refresh
