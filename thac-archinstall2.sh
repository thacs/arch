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
sleep 2 &&
genfstab -U /mnt >> /mnt/etc/fstab &&
arch-chroot /mnt grub-install $diskvar &&
arch-chroot /mnt "#!/bin/bash
echo -e "%wheel ALL=(ALL) ALL" > /etc/sudoers.d/99_wheel &&
echo -e "en_US.UTF-8 UTF-8\nen_US ISO-8859-1" > /etc/locale.gen &&
locale-gen &&
echo "LANG=en_US.UTF-8" >> /etc/locale.conf &&
echo "KEYMAP=fi" >> /etc/vconsole.conf &&
ln -sf /usr/share/zoneinfo/Europe/Helsinki /etc/localtime &&
grub-mkconfig -o /boot/grub/grub.cfg &&
systemctl enable dhcpcd &&
echo -e "--save /etc/pacman.d/mirrorlist\n--country Finland,Sweden,\n--protocol https\n--latest 5" > /etc/xdg/reflector/reflector.conf &&
systemctl enable reflector &&
clear &&
read -p "username: " uservar &&
useradd -mg wheel $uservar &&
clear &&
passwd $uservar &&
clear" &&
echo "Install Finished"
