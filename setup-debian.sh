!#/bin/sh

# Upgrade everythings
apt update
apt upgrade -y
apt autoremove -y

# Install snapd and flatpak
apt install flatpak
apt install snapd

# Upgrade snapd and flatpak
flatpak update
snap refresh

# Install zsh
apt install zsh -y
chsh -s	/bin/zsh

# Install Sublime Text
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | apt-key add -
apt install apt-transport-https
echo "deb https://download.sublimetext.com/ apt/stable/" | tee /etc/apt/sources.list.d/sublime-text.list
apt update
apt install sublime-text

# Install apps
apt install neofetch alacritty gitg steam mpv audacious mc cmatrix filezilla thunderbird vlc libreoffice qemu-system-x86 libvirt-daemon-system virt-manager
snap install bitwarden codium skype
flatpak install flathub org.onlyoffice.desktopeditors
flatpak install flathub com.spotify.Client
