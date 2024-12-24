#!/bin/bash
clear

echo -ne "\e[1;31m
----------------------------------------------------------------------------
                        Automated Arch Setup Script
                            MadeBy: Vuk1lis™
                        https://github.com/vukilis
----------------------------------------------------------------------------
\e[1;33m"

pacman() {
    command pacman --noconfirm "$@"
}

yay() {
    command yay --noconfirm "$@"
}

echo -ne "
-------------------------------------------------------------------------
                    Updating System and Repositories                            
-------------------------------------------------------------------------
"

pacman -Syu

echo -ne "
-------------------------------------------------------------------------
                            Install Packages                            
-------------------------------------------------------------------------
"

for pkg in `cat pkgs.txt`
    do yay -S $pkg
done


echo -ne "
--------------------------------------------------------------------------
                        Setup GRUB BIOS Bootloader                        
--------------------------------------------------------------------------
"

sed -i 's/set timeout=8/set timeout=3/' /boot/grub/grub.cfg

echo -ne "
-------------------------------------------------------------------------
                    Setup SDDM Display Manager
-------------------------------------------------------------------------
"

echo -e "\nEnabling Login Display Manager"
systemctl enable sddm.service
tar -xzvf ~/sugar‑candy.tar.gz -C /usr/share/sddm/themes
echo -e "[Theme]\nCurrent=sugar-candy" | tee /etc/sddm.conf
systemctl restart sddm.service

