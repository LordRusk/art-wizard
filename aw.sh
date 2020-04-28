#!/usr/bin/env sh

# getopts
while getopts "r" parm; do case $parm in
	r) installtools="y" ;;
esac done

# script
clear
cat << EOF
Welcome to The Art Wizard,
------------------------------------------------------
This wizard is here to help you install Arch or Artix
fast, easy, and with as much customazation as possible.
------------------------------------------------------
This script can be used on a real install, or from the
iso. If you are running on a real install, give the -r
option, and it will install the needed tools using yay
if installed. If not, it will build it using makepkg.
------------------------------------------------------
Please contribute by adding more bootloader support,
more network managers, better writen code, etc.
------------------------------------------------------
Would you like to continue
With the installer? [Y/n]
EOF
read -r tmp
[ "$tmp" != "n" ] && [ "$tmp" != "N" ] && {
	[ "$installtools" = "y" ] && {
		printf "\n\nIt's always good to do a system update before using. Would you like to continue? [Y/n]"
		read -r tmp
		case $tmp in
			[Nn]) exit;;
			*) pacman -Syu ;;
		esac
		printf "\nInstalling Tools..." && pacman -S arch-install-scripts >/dev/null 2>&1\
		}

	cd ~
	printf "Downloading Art Wizard Repository..."
	git clone https://github.com/lordrusk/art-wizard >/dev/null 2>&1
	sh ~/art-wizard/bin/aw-pre-chroot
	}
