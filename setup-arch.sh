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
 thunderbird \
 gnome-calendar \
 vlc \
 lxsession \
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
 zsh-completions \
 zsh-syntax-highlighting \

#laptop
if [ $1 =z "laptop" ] then
pacman -Syu \
 cbatticon \
 tlp \
 blueberry \
 xfce4-power-manager \
 optimus-manager
fi

yay -Syu gzdoom \
 vscodium-bin

#Install Sublime Text
curl -O https://download.sublimetext.com/sublimehq-pub.gpg && pacman-key --add sublimehq-pub.gpg && pacman-key --lsign-key 8A8F901A && rm sublimehq-pub.gpg
echo -e "\n[sublime-text]\nServer = https://download.sublimetext.com/arch/stable/x86_64" | tee -a /etc/pacman.conf
pacman -Syu sublime-text

#Oh my zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
yay -S --noconfirm zsh-theme-powerlevel10k-git
p10k configure
chsh -s /bin/zsh

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