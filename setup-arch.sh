#!/bin/sh

sudo nano /etc/pacman.conf

sudo pacman -Syu
sudo pacman -R $(pacman -Qdtq)
sudo pacman -Syu \
 base-devel \
 xorg \
 wayland \
 xorg-xwayland \
 gnome \
 gnome-extra \
 gnome-themes-extra \
 networkmanager \
 syncthing \
 flatpak \
 wget \
 neofetch \
 alacritty \
 steam \
 mpv \
 mc \
 cmatrix \
 filezilla \
 firefox \
 cargo \
 cups \
 sof-firmware \
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
 starship \
 xterm \
 xdg-utils \
 xarchiver \
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
 dosfstools \
 exfatprogs \
 ntfs-3g \
 fzf \
 fd \
 nodejs \
 soundconverter \
 x11-ssh-askpass \
 mediainfo-gui \
 picard \
 traceroute \
 unrar \
 openscad \
 freecad \
 prusa-slicer \
 adwaita-qt5 \
 adwaita-qt6 \
 sane \
 sane-airscan \
 nfs-tools \
 net-tools

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

# Install Paru
cd
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
cd
rm -rf paru/

paru -Syu gzdoom \
 mailspring \
 papirus-folders \
 vscodium-bin \
 nerd-fonts-meta \
 mkinitcpio-firmware \
 brave-bin \
 spotify \
 onlyoffice-bin \
 skypeforlinux-stable-bin \
 appimagelauncher \
 shntool \
 mac \
 sublime-text-4 \
 brother-mfc-l2710dw \
 brscan4 \
 gnome-shell-extension-dash-to-dock \
 gnome-shell-extension-search-light-git \
 gnome-shell-extension-appindicator-git \
 sonixd-bin

flatpak install flathub com.github.Murmele.Gittyup

# Change default shell
chsh -s /usr/bin/zsh

# Enable NTP sync
sudo systemctl enable systemd-timesyncd.service
sudo systemctl start systemd-timesyncd.service

# Enable Syncthing
systemctl --user enable syncthing.service
systemctl --user start syncthing.service

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

# nVidia GPU
nvidiaGPU=$(lspci | grep "GeForce")

if [[ -n $nvidiaGPU ]]; then
    sudo pacman -Syu nvidia-settings
    sudo nvidia-settings
fi

# GRUB settings
grub=$(grub-install -V)

if [[ -n $grub ]]; then
    sudo pacman -Syu os-prober
    sudo nano /etc/default/grub
    sudo grub-mkconfig -o /boot/grub/grub.cfg
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

# Gnome settings
gsettings set org.gnome.shell.extensions.dash-to-dock disable-overview-on-startup true

# Other
tldr --update

cd
mkdir temp random
