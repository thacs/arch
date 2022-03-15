#!/bin/bash
read -p "/dev/nvme0n1 " diskvar &&
cfdisk $diskvar
read -p "/dev/nvme0n1p1 " fulldiskvar &&
mkfs.ext4 $fulldiskvar &&
mount $fulldiskvar /mnt &&
pacstrap /mnt base base-devel linux-zen linux-firmware linux-headers vim grub dhcpcd &&
genfstab -U /mnt >> /mnt/etc/fstab &&
read -p "username: " uservar &&
arch-chroot /mnt useradd -mg wheel $uservar &&
arch-chroot /mnt passwd $uservar &&
arch-chroot /mnt echo -e "%wheel ALL=(ALL) ALL" > /etc/sudoers.d/99_wheel &&
arch-chroot /mnt systemctl enable dhcpcd &&
arch-chroot /mnt grub-install $diskvar
arch-chroot /mnt grub-mkconfig -o /boot/grub/grub.cfg &&
arch-chroot /mnt echo -e "en_US.UTF-8 UTF-8\nen_US ISO-8859-1" > /etc/locale.gen &&
arch-chroot /mnt locale-gen &&
arch-chroot /mnt echo "LANG=en_US.UTF-8" >> /etc/locale.conf &&
arch-chroot /mnt echo "KEYMAP=fi" >> /etc/vconsole.conf &&
arch-chroot /mnt ln -sf /usr/share/zoneinfo/Europe/Helsinki /etc/localtime &&
arch-chroot /mnt pacman -S --noconfirm xorg-xinit xorg-server pipewire pipewire-pulse pipewire-alsa pipewire-jack xfce4 xfce4-whiskermenu-plugin xfce4-pulseaudio-plugin pavucontrol feh mpv qbittorrent firefox gvfs xarchiver unzip git wget xfce4-screenshooter sddm &&
arch-chroot /mnt systemctl enable sddm
echo "Install Finished"
