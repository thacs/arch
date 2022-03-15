#!/bin/bash
read -p "disk " diskvar &&
cfdisk $diskvar &&
read -p "root partition " fulldiskvar &&
mkfs.ext4 -F $fulldiskvar &&
mount $fulldiskvar /mnt &&
pacstrap /mnt base base-devel linux-zen linux-firmware linux-headers vim grub dhcpcd &&
genfstab -U /mnt >> /mnt/etc/fstab &&
read -p "username: " uservar &&
arch-chroot /mnt useradd -mg wheel $uservar &&
arch-chroot /mnt passwd $uservar &&
arch-chroot /mnt grub-install $diskvar &&
mv arch-chroot.sh /mnt &&
cd /mnt &&
chmod +x arch-chroot.sh &&
arch-chroot /mnt ./arch-chroot.sh &&
rm arch-chroot.sh &&
echo "Install Finished"
