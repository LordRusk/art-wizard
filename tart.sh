#!/usr/bin/env sh

# Welcome
clear
echo "Welcome to the Tiny Art Installer"
echo "This script makes it fast and easy and fast to install Arch or Artix while meeting many needs you may have."
echo "Any programs that are needed and installed by the script that are not needed afterwords will be removed from your install"
echo "Press Enter to continue..."
read temp

# Install Needed Programs and Packages
pacman --noconfirm --needed -Sy dash tcc make patch;
git clone https://www.github.com/LordRusk/tart
git clone https://github.com/JCoMcL/umenu
cp tart/umenu-tcc.diff umenu/
cd umenu
patch < umenu-tcc.diff
make install
cd ../
cd tart
dash tart-pre-chroot

