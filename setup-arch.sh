!#/bin/sh

pacman -Syu
pacman -R $(pacman -Qdtq)
pacman -Syu \
 xorg \
 lightdm \
 lightdm-gtk-greeter-settings \
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
 firefox \
 mailspring \
 gnome-calendar \
 vlc \
 lxsession \
 lxappearance \
 trayer \
 volumeicon \
 dunst \
 exa \
 qemu \
 virt-manager \
 xdotool \
 xmobar \
 xmonad \
 xmonad-contrib \
 xmonad-log \
 xmonad-utils \
 zsh \
 zsh-autosuggestions \
 zsh-syntax-highlighting \
 xterm \
 xdg-utils \
 xarchiver \
 simple-scan \
 sane-airscan \
 bat \
 bottom \
 ripgrep \
 git-delta \
 procs \
 bandwhich \
 tealdeer \
 rust \
 neovim

#laptop
if [ $1 =z "laptop" ]; then
pacman -Syu \
 cbatticon \
 tlp \
 blueberry \
 xfce4-power-manager
fi

cargo install paper-terminal

yay -Syu gzdoom \
 vscodium-bin \
 meteo-gtk \
 nerd-fonts-fira-code

#qemu setup
systemctl enable libvirtd.service
systemctl start libvirtd.service
echo "unix_sock_group = \"libvirt\"" >> /etc/libvirt/libvirtd.conf
echo "unix_sock_rw_perms = \"0770\"" >> /etc/libvirt/libvirtd.conf
usermod -a -G libvirt $(whoami)
newgrp libvirt
systemctl restart libvirtd.service

#Enable nested virtualization
modprobe -r kvm_intel
modprobe kvm_intel nested=1
echo "options kvm-intel nested=1" | tee /etc/modprobe.d/kvm-intel.conf

#Enable CUPS
systemctl enable cups.service
systemctl start cups.service

#Cheat.sh
curl https://cht.sh/:cht.sh | sudo tee /usr/local/bin/cht.sh
sudo chmod +x /usr/local/bin/cht.sh
