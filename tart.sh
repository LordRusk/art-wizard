#!/usr/bin/env sh

cat << EOF
Welcome to The Art Wizard,
--------------------------
This wzard is here to help
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
	*) sh ~/tart/bin/tart-pre-chroot ;;
esac

