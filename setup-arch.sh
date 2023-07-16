#!/bin/sh

sudo pacman -Syu
sudo pacman -R $(pacman -Qdtq)
sudo pacman -Syu \
 base-devel \
 xorg \
 wayland \
 xorg-xwayland \
 gnome \
 syncthing \
 flatpak \
 thunar \
 thunar-volman \
 kvantum \
 krename \
 krusader \
 wget \
 evince \
 neofetch \
 alacritty \
 steam \
 mpv \
 audacious \
 audacious-plugins \
 mc \
 cmatrix \
 filezilla \
 brave \
 firefox \
 thunderbird \
 vlc \
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
 appimagelauncher \
 traceroute \
 papirus-folders

# Laptop software
printf "\n\n\nInstall laptop specific software?\n"
echo "1 - Do not install"
echo "2 - Intel based laptop"

option=0

while [ $option -lt 1 ] || [ $option -gt 2 ]; do
    printf "Select [1-2]: "
    read option
    if [ $option -lt 1 ] || [ $option -gt 2 ]; then
           echo "Invalid option"
    fi
done

if [ $option -eq 2 ]; then
    sudo pacman -Syu \
     xf86-video-intel \
     intel-media-driver
fi
if [ $option -ge 2 ]; then
    sudo pacman -Syu \
     networkmanager-l2tp \
     strongswan
fi

cargo install paper-terminal

paru -Syu gzdoom \
 vscodium-bin \
 nerd-fonts-complete \
 xidlehook \
 mkinitcpio-firmware \
 shntool \
 mac \
 sonixd-appimage

flatpak install flathub com.github.Murmele.Gittyup

# Change default shell
chsh -s /usr/bin/zsh

# Enable NTP sync
sudo systemctl enable systemd-timesyncd.service
sudo systemctl start systemd-timesyncd.service

# qemu setup
sudo systemctl enable libvirtd.service
sudo systemctl start libvirtd.service
sudo echo "unix_sock_group = \"libvirt\"" | sudo tee /etc/libvirt/libvirtd.conf
sudo echo "unix_sock_rw_perms = \"0770\"" | sudo tee /etc/libvirt/libvirtd.conf
sudo usermod -a -G libvirt $(whoami)
sudo newgrp libvirt
sudo systemctl restart libvirtd.service

# Enable nested virtualization
cpuAMD=$(lscpu | grep "AuthenticAMD")
cpuIntel=$(lscpu | grep "GenuineIntel")

if [[ -n $cpuAMD ]]; then
    sudo modprobe -r kvm_amd
    sudo modprobe kvm_amd nested=1
    sudo echo "options kvm-amd nested=1" | sudo tee /etc/modprobe.d/kvm-amd.conf
elif [[ -n $cpuIntel ]]; then
    sudo modprobe -r kvm_intel
    sudo modprobe kvm_intel nested=1
    sudo echo "options kvm-intel nested=1" | sudo tee /etc/modprobe.d/kvm-intel.conf
fi

# Enable CUPS
sudo systemctl enable cups.service
sudo systemctl start cups.service

# Cheat.sh
curl https://cht.sh/:cht.sh | sudo tee /usr/local/bin/cht.sh
sudo chmod +x /usr/local/bin/cht.sh

# Setup NFS
sudo echo "10.23.0.40:/mnt/user/books /mnt/nas/books nfs defaults,timeo=900,retrans=5,_netdev 0 0" | sudo tee -a /etc/fstab
sudo echo "10.23.0.40:/mnt/user/general /mnt/nas/general nfs defaults,timeo=900,retrans=5,_netdev 0 0" | sudo tee -a /etc/fstab
sudo echo "10.23.0.40:/mnt/user/movies /mnt/nas/movies nfs defaults,timeo=900,retrans=5,_netdev 0 0" | sudo tee -a /etc/fstab
sudo echo "10.23.0.40:/mnt/user/music /mnt/nas/music nfs defaults,timeo=900,retrans=5,_netdev 0 0" | sudo tee -a /etc/fstab
sudo echo "10.23.0.40:/mnt/user/tv /mnt/nas/tv nfs defaults,timeo=900,retrans=5,_netdev 0 0" | sudo tee -a /etc/fstab
sudo echo "10.23.0.40:/mnt/disks/download /mnt/nas/download nfs defaults,timeo=900,retrans=5,_netdev 0 0" | sudo tee -a /etc/fstab

# Other
tldr --update
