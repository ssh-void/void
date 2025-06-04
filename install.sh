#!/usr/bin/env bash

set -e  # Exit on any error
set -o pipefail

echo "Updating The chsh ...\n"

USERNAME=$(logname)
sudo chsh -s /bin/bash "$USERNAME"
sudo chsh -s /bin/bash root

echo "Updating The System ...\n"
sudo xbps-install -S && sudo xbps-install -u xbps && sudo xbps-install -Syu
clear

echo "mkdir Videos Image ...\n"
cd ~
mkdir -p Videos Images Downloads Documents Music
mkdir -p $HOME/Downloads/{torrent,firefox,brave}
clear

echo "Add void-repo-nonfree & installing packages...\n"
sudo xbps-install -Syu void-repo-nonfree # add void-repo-multilib-nonfree
sudo  xbps-install -Suyf $(cat voidlinuxqemu.txt)
clear

echo "Reconfigure all packages & Update font cache ... \n"
# Reconfigure all packages
sudo xbps-reconfigure -fa

# Update font cache
fc-cache -fv

echo "services on ... \n"
sudo ln -s /etc/sv/dbus/ /var/service/
sudo ln -s /etc/sv/tor/ /var/service/
sudo ln -s /etc/sv/udevd/ /var/service/
sudo ln -s /etc/sv/ufw/ /var/service/
sudo ln -s /etc/sv/cronie /var/service # crontab -e
sudo ln -s /etc/sv/acpid/ /var/service/
clear
#sudo sed -i 's|^#\?FONT=.*|FONT="ter-v20b"|' /etc/rc.conf
permit "### opendoas ..."
echo "permit nopass "$USERNAME" as root" | sudo tee /etc/doas.conf > /dev/null
sudo shutdown -r now # reboot
