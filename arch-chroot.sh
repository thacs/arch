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
ln -sf /usr/share/zoneinfo/Europe/Helsinki /etc/localtime &&
sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf &&
echo "arch" >> /etc/hostname &&
pacman -Sy --noconfirm networkmanager xorg xterm reflector noto-fonts-cjk noto-fonts-emoji noto-fonts gvfs pipewire wireplumber pipewire-pulse pipewire-alsa pipewire-jack pavucontrol firefox feh mpv &&
systemctl enable NetworkManager &&
echo -e 'Section "InputClass"\n	Identifier "keyboard-all"\n	Driver "evdev"\n	MatchIsKeyboard "on"\n	Option "XkbLayout" "fi"\n	Option "XkbModel" "pc105"\nEndSection' >> /etc/X11/xorg.conf.d/00-keyboard.conf &&
echo -e "--save /etc/pacman.d/mirrorlist\n--country Finland,Sweden,\n--protocol https\n--latest 5" >> /etc/xdg/reflector/reflector.conf &&
echo -e 'Section "InputClass"\n    Identifier "My Mouse"\n    Driver "libinput"\n    MatchIsPointer "yes"\n    Option "AccelProfile" "flat"\n    Option "AccelSpeed" "0"\nEndSection' >> /etc/X11/xorg.conf.d/50-mouse-acceleration.conf &&
systemctl enable reflector &&
clear
