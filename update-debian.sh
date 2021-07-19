#!/bin/zsh

apt update
apt upgrade -y
apt autoremove -y
flatpak update
snap refresh
