#!/bin/bash

#resolution
echo "Setting resolution"
wget https://github.com/thelastowl/configs/blob/main/monitor.xml -O ~/.config/monitors.xml

echo "Setting theme"
#dark mode
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
#Legacy applications
gsettings set org.gnome.desktop.interface gtk-theme "gnome-professional-40.1-dark" 
#shell theme
gsettings set org.gnome.shell.extensions.user-theme name "gnome-professional-40.1-dark" 
#Window manager
gsettings set org.gnome.desktop.wm.preferences theme "default" 
#gsettings set org.gnome.desktop.interface cursor-theme 
gsettings set org.gnome.desktop.interface icon-theme "Gnome"

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
#gsettings set org.gnome.shell.extensions.dash-to-dock extend-height false
#gsettings set org.gnome.shell.extensions.dash-to-dock dock-position 'LEFT'
#gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed false
#gsettings set org.gnome.shell.extensions.dash-to-dock transparency-mode 'FIXED'
#gsettings set org.gnome.shell.extensions.dash-to-dock background-opacity 0.0
