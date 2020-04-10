#!/usr/bin/env sh

while getopts ":d:" o; do case "${o}" in
	d) dotfilesrepo=${OPTARG} && git ls-remote "$dotfilesrepo" || exit ;;
	*) printf "Invalid option: -%s\\n" "$OPTARG" && exit ;;
esac done

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
This wizard uses the core
of LARBS to install specific
programs defined in
tart/share/progs.csv, in
this file, you can find
commented out examples for
xorg. If exit the wizard
and edit the file.
---------------------------
This wizard also has the
capability of depoying
a dotfiles repository. This
can be achieved with option
-d [git url].
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
	printf "Downloading Art Wizard Repository..."
	cd ~/
	git clone https://www.github.com/lordrusk/tart >/dev/null 2>&1
	export dotfilesrepo
	sh ~/tart/bin/tart-pre-chroot
	;;
esac
