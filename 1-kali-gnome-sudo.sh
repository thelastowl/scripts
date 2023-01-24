#!/bin/bash

#Checking for sudo
if (( $EUID != 0 )); then
    echo "Please run as root"
    exit
fi

echo "Enter username:"
read username

apt-get update

echo "Installing essentials" 
INSTALL_PKGS="dbus-x11 gtk2-engines-murrine sassc gnome-themes-extra"

for i in $INSTALL_PKGS; do
  apt-get install -y $i
done

#sudo nopassword
echo "Adding to sudoers"
echo "$username ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

#enable autologin
echo "Enabling autologin"
file=/etc/gdm3/daemon.conf
cp $file /etc/gdm3/daemon.conf.bak
sed -i "s/^.*AutomaticLoginEnable = .*/AutomaticLoginEnable = true/" "${file}"
sed -i "s/^.*AutomaticLogin = .*/AutomaticLogin = $username/" "${file}"
