#!/bin/bash
echo -e "%wheel ALL=(ALL) ALL" > /etc/sudoers.d/99_wheel &&
echo -e "en_US.UTF-8 UTF-8\nen_US ISO-8859-1" > /etc/locale.gen &&
locale-gen &&
echo "LANG=en_US.UTF-8" >> /etc/locale.conf &&
echo "KEYMAP=fi" >> /etc/vconsole.conf &&
grub-mkconfig -o /boot/grub/grub.cfg &&
ln -sf /usr/share/zoneinfo/Europe/Helsinki /etc/localtime &&
sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf &&
echo "arch" >> /etc/hostname &&
pacman -Sy --noconfirm networkmanager xorg xterm reflector
systemctl enable NetworkManager &&
echo -e 'Section "InputClass"\nIdentifier "keyboard-all"\nDriver "evdev"\nMatchIsKeyboard "on"\nOption "XkbLayout" "fi"\nOption "XkbModel" "pc105"\nEndSection' >> /etc/X11/xorg.conf.d/00-keyboard.conf &&
echo -e "--save /etc/pacman.d/mirrorlist\n--country Finland,Sweden,\n--protocol https\n--latest 5" >> /etc/xdg/reflector/reflector.conf &&
systemctl enable reflector &&
clear &&
read -p "username: " uservar &&
useradd -mg wheel $uservar &&
clear &&
passwd $uservar &&
clear
