#!/usr/bin/env sh

clear
cat << EOF
Welcome to The Art Wizard,
--------------------------
This wizard is here to help
you install Arch or Artix
fast, easy, and with as
much customazation as
possible.
---------------------------
Please contribute by adding
more bootloader support,
better writen code, etc.
---------------------------
Would you like to continue
With the installer? [Y/n]
EOF

read -r tmp
case $tmp in
	[Nn]) break;;
	*) \
	printf "\nDownloading Art Wizard Repository..."
	git clone https://www.github.com/lordrusk/tart >/dev/null 2>&1
	sh ~/tart/bin/tart-pre-chroot
	;;
esac

