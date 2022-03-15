#!/bin/bash
lsblk &&
read -p "disk " diskvar &&
cfdisk $diskvar &&
clear &&
lsblk &&
read -p "root partition " fulldiskvar &&
clear &&
echo 'Please pick from the following'

select install in gnome xfce plasma none ssh
do
        case $install in 
        gnome|xfce|plasma|none|ssh)   
                break
                ;;
        *)
                echo "Invalid" 
                ;;
        esac
done &&
mkfs.ext4 -F $fulldiskvar &&
mount $fulldiskvar /mnt &&
pacstrap /mnt base base-devel linux-zen linux-firmware linux-headers vim grub &&
genfstab -U /mnt >> /mnt/etc/fstab &&
arch-chroot /mnt grub-install $diskvar &&
cp arch-chroot-$install.sh /mnt &&
cd /mnt &&
chmod +x arch-chroot-$install.sh &&
arch-chroot /mnt ./arch-chroot-$install.sh &&
rm arch-chroot-$install.sh &&
echo "Install Finished"
