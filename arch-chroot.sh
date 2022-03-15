#!/bin/bash
echo -e "%wheel ALL=(ALL) ALL" > /etc/sudoers.d/99_wheel &&
echo -e "en_US.UTF-8 UTF-8\nen_US ISO-8859-1" > /etc/locale.gen &&
locale-gen &&
echo "LANG=en_US.UTF-8" >> /etc/locale.conf &&
echo "KEYMAP=fi" >> /etc/vconsole.conf &&
ln -sf /usr/share/zoneinfo/Europe/Helsinki /etc/localtime &&
grub-mkconfig -o /boot/grub/grub.cfg &&
systemctl enable dhcpcd &&
echo -e "--save /etc/pacman.d/mirrorlist\n--country Finland,Sweden,\n--protocol https\n--latest 5" > /etc/xdg/reflector/reflector.conf &&
systemctl enable reflector
#pacman -S --noconfirm xorg pipewire pipewire-pulse pipewire-alsa pipewire-jack xfce4 xfce4-whiskermenu-plugin xfce4-pulseaudio-plugin pavucontrol feh mpv firefox gvfs xarchiver unzip git wget xfce4-screenshooter noto-fonts-cjk noto-fonts-emoji noto-fonts sddm &&
#systemctl enable sddm
clear &&
read -p "username: " uservar &&
useradd -mg wheel $uservar &&
clear &&
passwd $uservar &&
clear
