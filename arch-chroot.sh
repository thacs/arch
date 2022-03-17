#!/bin/bash
echo -e "%wheel ALL=(ALL) ALL" > /etc/sudoers.d/99_wheel &&
echo -e "en_US.UTF-8 UTF-8\nen_US ISO-8859-1" > /etc/locale.gen &&
locale-gen &&
echo "LANG=en_US.UTF-8" >> /etc/locale.conf &&
echo "KEYMAP=fi" >> /etc/vconsole.conf &&
grub-mkconfig -o /boot/grub/grub.cfg &&
systemctl enable dhcpcd &&
ln -sf /usr/share/zoneinfo/Europe/Helsinki /etc/localtime &&
sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf &&
pacman -Sy --noconfirm xorg pipewire pipewire-pulse pipewire-alsa pipewire-jack xfce4 xfce4-goodies sddm feh mpv firefox gvfs xarchiver unzip git wget noto-fonts-cjk noto-fonts-emoji noto-fonts helvum qbittorrent audacity gnome-calculator gnome-keyring discord gimp obs-studio steam reflector p7zip &&
systemctl enable sddm &&
clear &&
read -p "username: " uservar &&
useradd -mg wheel $uservar &&
clear &&
passwd $uservar &&
clear
