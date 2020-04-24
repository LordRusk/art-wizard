Things that need to be done.
============================

A Builder function
------------------
This is #1 on the todo list. This should support building from source, and perhaps from the aur. This should make it easier to add things like grub-legacy that must be built from source. This probably won't be hard to do, but it will be hard to do it well.
#### Requirement: Knowledge and Skill in writing efficent posix shell and knowledge about the build proccess of many programs and laungouges.

More bootloader support
-----------------------
Currently, only grub2 is supported on efi and bios. Grub-legacy and refind are top priority for efi and bios respectivly.
#### Requirement: Good Knowledge of Arch / Artix, Posix shell (and how to write efficent procedural scripts), and be familer with the bootloader you are trying to add.

More networkmanager support
---------------------------
Currently only NetworkManager is supported, and it is the only one I am familier with, so this will have to be done by a third party.
#### Requirement: Good knowledge of Arch and systemd, Artix and all the init systems that go with that, Posix shell (and how to write efficent procedural scripts), and be familer with the NetworkManager you are trying to add.
