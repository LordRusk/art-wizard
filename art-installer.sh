#!/usr/bin/env dash

### Functions ###
welcome() {
	clear
	echo "Welcome to the Art Installer"
	echo "This script makes it easy to install Arch or Artix quick and easy while meeting any needs you may have."
	echo "Press Enter To Continue..."
	read temp
}

prescript() {
	clear
	echo "Art Installer needs dash. Would you like to install it? Y/n"
	read temp
	case $temp in
		n) echo "Exiting Installer..."; exit ;;
		*) pacman --noconfirm --needed -Sy dash fzf ;;
	esac

	clear
	echo "Are you installing on Arch Linux or Artix Linux?"
	echo "1) Arch Linux"
	echo "2) Artix Linux"
	read OS
	case $OS in
		1) OS="Arch" ;;
		2) OS="Artix" ;;
		*) echo "unkown or unsupported OS..."; exit ;;
	esac

	clear
	echo "Enter the name of your preferred text editor to be used throughout the installation proccess."
	echo "(neovim, nano, etc..."
	read editor
	case $editor in
		neovim) pacman --needed --noconfirm -Sy $editor; editor="nvim" ;;
		*) pacman --needed --noconfirm -Sy $editor ;;
	esac
}

formatdrive() {
	clear
	echo "Are you installing on an Bios or (U)EFI machine?"
	echo "1) Bios"
	echo "2) (U)EFI"
	read bios
	case $bios in
		1) bios="bios" ;;
		2) bios="efi" ;;
		*) echo "unkown option"; exit ;;
	esac

	clear
	echo "Would you like to completely wipe the drive and do a complete (re)install or configure the drives yourself?"
	echo "1) Configure Partitions manually"
	echo "2) Wipe drive and (re)install $OS"
	read auto
	case $auto in
		1) clear
		   if [ $bios = "bios" ]; then echo "If you're going to (re)install grub, mount your boot partition at /mnt/boot"
		   elif [ $bios = "efi" ]; then echo "If you're going to (re)install grub, mount your boot partition at /mnt/boot/efi"; fi
		   echo "General rule of thumb, root partition is mounted at /mnt"
		   echo "and home pertition (if you have one) is mounted at /mnt/home"
		   bash
		   wait

		   echo "Please select the drive you would like to install $OS to:"
		   echo "$(lsblk -lp | grep "disk $" | awk '{print $1, "("$4")"}')"

		   read sdrive
		   cdrive=$(echo "$sdrive" | awk '{print $1}') ;;
		2) clear
		   echo "Please select the drive you would like to install $OS to:"
		   echo "$(lsblk -lp | grep "disk $" | awk '{print $1, "("$4")"}')"

		   read cdrive
		   #cdrive=$(echo "$sdrive" | awk '{print $1}')

		   clear
		   echo "How big do you want your root partition to be? (30gb,50gb,etc)"
		   read rps

		   clear
		   echo "Do you want a swap partition? Y/n"
		   read ssp
		   case $ssp in
		   	n) ;;
			*) clear; echo "How big do you want your swap patition? Usually 1.5x your ram"; read sps ;;
		   esac

		   dd if=/dev/zero of="$cdrive"  bs=512  count=1
		   if [ "$bios" = "efi" ] && [ "$ssp" = "n" ]; then
		   	dash ~/li/partitioner ens $cdrive 500mb $rps
			mkdir /mnt/boot
			mkdir /mnt/boot/efi
			mkfs.fat -F32 "$cdrive"1
			mount "$cdrive"1 /mnt/boot/efi
		   elif [ "$bios" = "efi" ] && [ "$ssp" != "n" ]; then
		   	dash ~/li/partitioner es $cdrive 500mb $rps $sps
			mkdir /mnt/boot
			mkdir /mnt/boot/efi
			mkfs.fat -F32 "$cdrive"1
			mount "$cdrive"1 /mnt/boot/efi
			mkswap "$cdrive"2
			swapon "$cdrive"2
		   elif [ "$bios" = "bios" ] && [ "$ssp" = "n" ]; then
		   	dash ~/li/partitioner bns $cdrive 500mb $rps
			mkfs.ext4 "$cdrive"1
			mkdir /mnt/boot
			mount "$cdrive"1 /mnt/boot
		  elif [ "$bios" = "bios" ] && [ "$ssp" != "n" ]; then
		   	dash ~/li/partitioner bs $cdrive 500mb $rps $sps
			mkfs.ext4 "$cdrive"1
			mkdir /mnt/boot
			mount "$cdrive"1 /mnt/boot
			mkswap "$cdrive"2
			swapon "$cdrive"2
		   fi
		   mkfs.ext4 "$cdrive"3
		   mkfs.ext4 "$cdrive"4
		   mount "$cdrive"3 /mnt
		   mkdir /mnt/home
		   mount "$cdrive"4 /mnt/home
	esac
}

mirrorlist() {
	case $OS in
		Arch) clear
		      echo "The Arch Mirrorlist can be slow and unreliable, please edit the mirrorlist for faster speeds. Press Enter to continue..."
		      read temp
		      $editor /etc/pacman.d/mirrorlist ;;
	esac
}

initsystem() {
	case $OS in
		Artix) echo "Which init system would you like to install?"
		       echo "1) openrc"
		       echo "2) runit"
		       echo "3) s6"

		       read init ;;
	esac
}

install() {
	case $OS in
		Arch) pacstrap /mnt linux linux-firmware base ;;
		Artix) case $init in
			1) basestrap /mnt linux linux-firmware base elogind-openrc openrc ;;
			2) basestrap /mnt linux linux-firmware base elogind-runit runit ;;
			3) basestrap /mnt linux linux-firmware base elogind-s6 s6 ;;
		esac
	esac
}

postinstall() {
	case $OS in
		Arch) genfstab -U -p /mnt >> /mnt/etc/fstab ;;
		Artix) fstabgen -U -p /mnt >> /mnt/etc/fstab ;;
	esac
}


### Actual Script ###

welcome || exit

prescript || exit

formatdrive || exit

mirrorlist || exit

initsystem || exit

install || exit

postinstall || exit

