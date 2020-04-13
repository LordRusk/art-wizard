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
This wizard uses the core of LARBS to install specific
programs defined in art-wizard/share/progs.csv, in
this file, you can find commented out examples for
xorg. If needed, exit the wizard and edit the file.
------------------------------------------------------
This wizard also has the capability of depoying a
dotfiles repository. This can be achieved with option
-d [git url]. You do need to create the user for this
operation, so if you skip that step, even if you use
-d, the dotfiles will not be released.
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
	export dotfilesrepo
	sh ~/art-wizard/bin/aw-pre-chroot
	;;
esac
