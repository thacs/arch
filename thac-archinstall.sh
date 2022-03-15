#!/bin/bash
clear &&
lsblk &&
read -p "disk " diskvar &&
cfdisk $diskvar &&
clear &&
lsblk &&
read -p "root partition " fulldiskvar &&
clear &&
mkfs.ext4 -F $fulldiskvar &&
mount $fulldiskvar /mnt &&
pacstrap /mnt base base-devel linux-zen linux-firmware linux-headers vim grub dhcpcd reflector &&
genfstab -U /mnt >> /mnt/etc/fstab &&
arch-chroot /mnt grub-install $diskvar &&
cp arch-chroot.sh /mnt &&
cd /mnt &&
chmod +x arch-chroot.sh &&
arch-chroot /mnt ./arch-chroot.sh &&
rm arch-chroot.sh &&
echo "Install Finished"
