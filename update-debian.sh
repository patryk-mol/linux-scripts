#!/bin/zsh

sudo apt update
sudo apt upgrade -y
sudo apt autoremove -y
flatpak update
snap refresh
