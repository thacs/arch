#!/bin/bash
clear &&
read -p "username: " uservar &&
useradd -mg wheel $uservar &&
clear &&
passwd $uservar &&
clear
echo -e "%wheel ALL=(ALL) ALL" > /etc/sudoers.d/99_wheel &&
echo -e "en_US.UTF-8 UTF-8\nen_US ISO-8859-1" > /etc/locale.gen &&
locale-gen &&
echo "LANG=en_US.UTF-8" >> /etc/locale.conf &&
echo "KEYMAP=fi" >> /etc/vconsole.conf &&
echo "arch" >> /etc/hostname &&
sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf &&
pacman -Sy --noconfirm networkmanager reflector xorg pipewire pipewire-pulse pipewire-alsa pipewire-jack xterm &&
echo -e 'Section "InputClass"\n	Identifier "keyboard-all"\n	Driver "evdev"\n	MatchIsKeyboard "on"\n	Option "XkbLayout" "fi"\nEndSection' >> /etc/X11/xorg.conf.d/00-keyboard.conf &&
echo -e 'Section "InputClass"\n    Identifier "My Mouse"\n    Driver "libinput"\n    MatchIsPointer "yes"\n    Option "AccelProfile" "flat"\n    Option "AccelSpeed" "0"\nEndSection' >> /etc/X11/xorg.conf.d/50-mouse-acceleration.conf &&
echo -e "--save /etc/pacman.d/mirrorlist\n--country Finland,Sweden,\n--protocol https\n--latest 5" >> /etc/xdg/reflector/reflector.conf &&
grub-mkconfig -o /boot/grub/grub.cfg &&
ln -sf /usr/share/zoneinfo/Europe/Helsinki /etc/localtime
systemctl enable reflector &&
systemctl enable NetworkManager &&
sleep 1 &&
clear
