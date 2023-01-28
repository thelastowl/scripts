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
#gsettings set org.gnome.desktop.wm.preferences theme "default" 
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

###DASH
# Install Dash To Panel - https://extensions.gnome.org/extension/1160/dash-to-panel/
# wget https://raw.githubusercontent.com/thelastowl/configs/main/dashtopanel -O dtp_settings
# dconf load /org/gnome/shell/extensions/dash-to-panel/ < dtp_settings
# rm dtp_settings
gsettings set org.gnome.shell favorite-apps "['com.gexperts.Tilix.desktop', 'brave-browser.desktop', 'org.gnome.Nautilus.desktop', 'sublime_text.desktop']"


