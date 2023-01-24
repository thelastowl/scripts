#!/bin/bash

#Checking for sudo
if (( $EUID != 0 )); then
    echo "Please run as root"
    exit
fi

echo "Enter username:"
read username

apt-get update

#sudo nopassword
echo "Adding to sudoers"
echo "$username ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

#resolution
echo "Setting resolution"
wget https://github.com/thelastowl/configs/blob/main/monitor.xml -O /home/$username/.config/monitors.xml

echo "Setting theme"
apt-get install -y gtk2-engines-murrine sassc gnome-themes-extra
git clone https://github.com/vinceliuice/Graphite-gtk-theme.git && cd Graphite-gtk-theme
./install.sh -l -d /usr/share/themes -t all
#git clone https://github.com/vinceliuice/Tela-circle-icon-theme && cd Tela-circle-icon-theme 
#./install.sh -a -c -d /usr/share/icons

#Legacy applications
gsettings set org.gnome.desktop.interface gtk-theme "Graphite-blue-dark" 
#shell theme
gsettings set org.gnome.shell.extensions.user-theme name "Graphite-blue-dark" 
#Window manager
gsettings set org.gnome.desktop.wm.preferences theme "Graphite-blue-dark" 
#gsettings set org.gnome.desktop.interface cursor-theme 
#gsettings set org.gnome.desktop.interface icon-theme 

#general settings
echo "Various settings" 
gsettings set org.gnome.desktop.interface text-scaling-factor 1.3
gsettings set org.gnome.desktop.session idle-delay 0 
gsettings set org.gnome.desktop.lockdown disable-lock-screen 'true'
gsettings set org.gnome.desktop.interface enable-animations false
dconf write /org/gnome/desktop/interface/clock-show-date true
dconf write /org/gnome/desktop/interface/clock-show-weekday true
dconf write /org/gnome/desktop/interface/clock-show-seconds false
dconf write /org/gnome/nautilus/preferences/show-hidden-files true

#dash settings
echo "Setting dash settings" 
gsettings set org.gnome.shell favorite-apps "['com.gexperts.Tilix.desktop', 'brave-browser.desktop', 'org.gnome.Nautilus.desktop', 'sublime_text.desktop']"
gsettings set org.gnome.shell.extensions.dash-to-dock extend-height false
gsettings set org.gnome.shell.extensions.dash-to-dock dock-position 'LEFT'
gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed false
gsettings set org.gnome.shell.extensions.dash-to-dock transparency-mode 'FIXED'
gsettings set org.gnome.shell.extensions.dash-to-dock background-opacity 0.0


#enable autologin
echo "Enabling autologin"
file=/etc/gdm3/daemon.conf
cp $file /etc/gdm3/daemon.conf.bak
sed -i "s/^.*AutomaticLoginEnable = .*/AutomaticLoginEnable = true/" "${file}"
sed -i "s/^.*AutomaticLogin = .*/AutomaticLogin = $username/" "${file}"
