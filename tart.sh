#!/usr/bin/env sh

# Welcome
clear
echo "Welcome to the Tiny Art Installer"
echo "This script makes it easy and fast to install Arch or Artix while meeting many needs you may have."
echo "Press Enter to continue..."
read temp

clear
echo "Tart needs dash, tcc, make, patch, and umenu. Would you like to install them? Y/n"
read temp
case $temp in
	n) echo "Exiting INstaller..."; exit ;;
	*)
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
	;;
esac

