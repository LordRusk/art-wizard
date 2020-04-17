#!/usr/bin/env sh

while getopts "d:p:" parm; do case $parm in
	d) dotfilesrepo=$OPTARG && \
	printf "Checking if git repository is valid...\n" && \
	pacman --needed --noconfirm -Sy git >/dev/null 2>&1 \
	;;
	p) progsfile=$OPTARG ;;
	*) printf "Invalid option: -%s\\n" && exit ;;
esac done

clear
cat << EOF
Welcome to The Art Wizard,
------------------------------------------------------
This wizard is here to help you install Arch or Artix
fast, easy, and with as much customazation as possible.
------------------------------------------------------
Please contribute by adding more bootloader support,
more network managers, better writen code, etc.
------------------------------------------------------
Would you like to continue
With the installer? [Y/n]
EOF
read -r tmp
case $tmp in
	[Nn]) break;;
	*) \
	cd ~
	printf "Downloading Art Wizard Repository..."
	git clone https://github.com/lordrusk/art-wizard >/dev/null 2>&1
	sh ~/art-wizard/bin/aw-pre-chroot
	;;
esac
