#!/usr/bin/env sh

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
