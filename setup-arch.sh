#!/bin/sh

sudo pacman -Syu
sudo pacman -R $(pacman -Qdtq)
sudo pacman -Syu \
 xorg \
 wayland \
 xorg-xwayland \
 plasma \
 plasma-wayland-session \
 qtile \
 sddm \
 thunar \
 thunar-volman \
 wget \
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
 libva-utils \
 vdpauinfo \
 ttf-font-awesome \
 otf-font-awesome \
 docker \
 docker-compose \
 tlp \
 ranger \
 pinta \
 cmake \
 cairo \
 python-cairo \
 libsass \
 sassc \
 fzf \
 fd \
 nodejs \
 soundconverter \
 ulauncher \
 sublime-text-4 \
 spotify \
 onlyoffice \
 x11-ssh-askpass \
 skype \
 mediainfo-gui \
 picard \
 appimagelauncher

# Laptop
if [ $1 =z "laptop" ]; then
sudo pacman -Syu \
 xf86-video-intel \
 intel-media-driver \
 networkmanager-l2tp \
 strongswan
fi

cargo install paper-terminal

paru -Syu gzdoom \
 vscodium-bin \
 meteo-gtk \
 deadd-notification-center-bin \
 nerd-fonts-complete \
 xidlehook \
 mkinitcpio-firmware \
 shntool \
 mac \
 sonixd-appimage

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

# Setup NFS

sudo echo "192.168.1.2:/mnt/user/books /mnt/nas/books nfs defaults,timeo=900,retrans=5,_netdev 0 0" | sudo tee -a /etc/fstab
sudo echo "192.168.1.2:/mnt/user/general /mnt/nas/general nfs defaults,timeo=900,retrans=5,_netdev 0 0" | sudo tee -a /etc/fstab
sudo echo "192.168.1.2:/mnt/user/movies /mnt/nas/movies nfs defaults,timeo=900,retrans=5,_netdev 0 0" | sudo tee -a /etc/fstab
sudo echo "192.168.1.2:/mnt/user/music /mnt/nas/music nfs defaults,timeo=900,retrans=5,_netdev 0 0" | sudo tee -a /etc/fstab
sudo echo "192.168.1.2:/mnt/user/tv /mnt/nas/tv nfs defaults,timeo=900,retrans=5,_netdev 0 0" | sudo tee -a /etc/fstab
sudo echo "192.168.1.2:/mnt/disks/download /mnt/nas/download nfs defaults,timeo=900,retrans=5,_netdev 0 0" | sudo tee -a /etc/fstab

# Other
tldr --update
