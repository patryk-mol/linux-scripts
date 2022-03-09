#!/bin/sh

sudo pacman -Syu
sudo pacman -R $(pacman -Qdtq)
sudo pacman -Syu \
 xorg \
 thunar \
 thunar-volman \
 evince \
 neofetch \
 alacritty \
 gitg \
 steam \
 mpv \
 audacious \
 audacious-plugins \
 mc \
 cmatrix \
 filezilla \
 brave \
 firefox \
 mailspring \
 gnome-calendar \
 vlc \
 lxsession \
 lxappearance \
 exa \
 qemu \
 virt-manager \
 xdotool \
 qtile \
 alsa-utils \
 libpulse \
 lm_sensors \
 python-dbus-next \
 python-iwlib \
 python-pyxdg \
 python-psutil \
 zsh \
 zsh-autosuggestions \
 zsh-syntax-highlighting \
 xterm \
 xdg-utils \
 xarchiver \
 simple-scan \
 bat \
 bottom \
 ripgrep \
 git-delta \
 procs \
 bandwhich \
 tealdeer \
 rust \
 neovim \
 bitwarden \
 xf86-video-intel \
 intel-media-driver \
 libva-utils \
 vdpauinfo \
 ttf-font-awesome \
 otf-font-awesome \
 docker \
 tlp \
 xfce4-power-manager \

# Laptop
if [ $1 =z "laptop" ]; then
sudo pacman -Syu \
 networkmanager-l2tp \
 strongswan
fi

cargo install paper-terminal

sudo paru -Syu gzdoom \
 vscodium-bin \
 meteo-gtk \
 deadd-notification-center-bin \
 nerd-fonts-complete \


# Change default shell
chsh -s /usr/bin/zsh

# qemu setup
sudo systemctl enable libvirtd.service
sudo systemctl start libvirtd.service
sudo echo "unix_sock_group = \"libvirt\"" >> /etc/libvirt/libvirtd.conf
sudo echo "unix_sock_rw_perms = \"0770\"" >> /etc/libvirt/libvirtd.conf
sudo usermod -a -G libvirt $(whoami)
sudo newgrp libvirt
sudo systemctl restart libvirtd.service

# Enable nested virtualization
sudo modprobe -r kvm_intel
sudo modprobe kvm_intel nested=1
sudo echo "options kvm-intel nested=1" | tee /etc/modprobe.d/kvm-intel.conf

# Enable CUPS
sudo systemctl enable cups.service
sudo systemctl start cups.service

# Cheat.sh
curl https://cht.sh/:cht.sh | sudo tee /usr/local/bin/cht.sh
sudo chmod +x /usr/local/bin/cht.sh

# Other
tldr --update
