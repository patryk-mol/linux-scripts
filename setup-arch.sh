!#/bin/sh

pacman -Syu
pacman -R $(pacman -Qdtq)
pacman -Syu \
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
 volumeicon \
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
 sane-airscan \
 bat \
 bottom \
 ripgrep \
 git-delta \
 procs \
 bandwhich \
 tealdeer \
 rust \
 neovim \
 bitwarden-bin

#laptop
if [ $1 =z "laptop" ]; then
pacman -Syu \
 tlp \
 xfce4-power-manager
fi

cargo install paper-terminal

paru -Syu gzdoom \
 vscodium-bin \
 meteo-gtk \
 nerd-fonts-fira-code \
 deadd-notification-center-bin

#Change default shell
chsh -s /usr/bin/zsh

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

#Sublime Text setup
curl -O https://download.sublimetext.com/sublimehq-pub.gpg && sudo pacman-key --add sublimehq-pub.gpg && sudo pacman-key --lsign-key 8A8F901A && rm sublimehq-pub.gpg
echo -e "\n[sublime-text]\nServer = https://download.sublimetext.com/arch/stable/x86_64" | sudo tee -a /etc/pacman.conf
sudo pacman -Syu sublime-text
