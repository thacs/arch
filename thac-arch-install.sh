#!/bin/bash
pacstrap /mnt base base-devel linux-zen linux-firmware linux-headers vim grub dhcpcd
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt ./thac-arch-chroot.sh
