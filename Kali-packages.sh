#!/bin/bash

#Checking for sudo
if (( $EUID != 0 )); then
    echo "Please run as root"
    exit
fi

echo "Enter username:"
read username

echo "Upgrading system"
apt-get update && apt-get -y upgrade
echo "Upgrade Done"

#vmware tools, kali-tweaks
echo "Installing VMWare Tools and Kali-tweaks"
apt-get install -y open-vm-tools-desktop open-vm-tools kali-tweaks python3-newt
install -v -D -m0755 /usr/lib/kali_tweaks/data/mount-shared-folders /usr/local/sbin/mount-shared-folders

#open shared folder
echo "Opening Shared Folder"
sudo vmhgfs-fuse .host:/ /mnt/ -o allow_other -o uid=1000

#packages
echo "Installing Packages"

INS_UTIL="unrar htop wget curl git locate gzip net-tools zsh make gettext python3 python2 python3-pip default-jdk default-jre"

for i in $INS_UTIL; do
  apt-get install -y $i
done

INS_TOOLS="nmap metasploit-framework rlwrap netcat-traditional netdiscover john hashcat hydra wpscan sqlmap wireshark sublist3r gobuster steghide exiftool name-that-hash ffuf"

for j in $INS_TOOLS; do
  apt-get install -y $j
done

INS_OTHERS="openvpn tilix whatweb whois smbclient remmina bleachbit hexedit"
for k in $INS_OTHERS; do
    apt-get install -y $k
done

#rustscan 
echo" Installing rustscan" 
mkdir /opt/rustscan
cd /opt/rustscan
wget https://github.com/RustScan/RustScan/releases/download/2.0.1/rustscan_2.0.1_amd64.deb
dpkg -i rustscan_2.0.1_amd64.deb
rm -rf /opt/rustscan/

#sublime, brave 
echo "Installing sublime and brave"
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
apt-get update
apt-get install -y sublime-text brave-browser 

#tilix setup ###-Backup More Later
echo "Setting up tilix"

echo -e "if [ \$TILIX_ID ] || [ \$VTE_VERSION ]; then
        source /etc/profile.d/vte.sh
fi" >> /home/$username/.zshrc
echo -e "if [ \$TILIX_ID ] || [ \$VTE_VERSION ]; then
        source /etc/profile.d/vte.sh
fi" >> /root/.zshrc
ln -s /etc/profile.d/vte-2.91.sh /etc/profile.d/vte.sh

mkdir -p /home/$username/.config/tilix/schemes #theme
wget -qO /home/$username"/.config/tilix/schemes/flatty.json"  https://git.io/vFkVc
#wget -qO /home/$username"/.config/tilix/schemes/sea-shells.json" https://git.io/v7Qay

#burp 
cp -r /mnt/Shared/burp /opt/burp
echo -e "alias burp=\"java -jar -noverify /opt/burp/burploader.jar\"" >> /home/$username/.zshrc
echo -e "alias burp=\"java -jar -noverify /opt/burp/burploader.jar\"" >> /root/.zshrc

echo -e "alias thmvpn=\"openvpn /opt/NotSoWise.ovpn\"" >> /home/$username/.zshrc
echo -e "alias thmvpn=\"openvpn /opt/NotSoWise.ovpn\"" >> /root/.zshrc

#remove packages
echo "Removing packages (if installed)"
REMOVE_PKGS="firefox-esr"

for l in $REMOVE_PKGS; do 
    apt-get remove -y $l
done
#######
#   Use vlc separately for each DE, Removing vlc in kde also removes default theme and affects GUI
#######

alias thmvpn = "openvpn /opt/NotSoWise.ovpn"

#cleaning
echo "Cleaning up"
apt-get update 
apt-get -y clean
apt-get -y autoremove 
