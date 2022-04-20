timedatectl set-ntp true &&
timedatectl set-timezone Europe/Helsinki &&
echo -e "--save /etc/pacman.d/mirrorlist\n--country Finland,Sweden,\n--protocol https\n--latest 5" >> /etc/xdg/reflector/reflector.conf &&
systemctl enable --now reflector &&
sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf &&
pacman -Sy --noconfirm xorg xorg-xinit xterm reflector noto-fonts-cjk noto-fonts-emoji noto-fonts pipewire wireplumber pipewire-pulse pipewire-alsa pipewire-jack pavucontrol firefox &&
echo -e 'Section "InputClass"\n	Identifier "keyboard-all"\n	Driver "evdev"\n	MatchIsKeyboard "on"\n	Option "XkbLayout" "fi"\nEndSection' >> /etc/X11/xorg.conf.d/00-keyboard.conf &&
echo -e 'Section "InputClass"\n    Identifier "My Mouse"\n    Driver "libinput"\n    MatchIsPointer "yes"\n    Option "AccelProfile" "flat"\n    Option "AccelSpeed" "0"\nEndSection' >> /etc/X11/xorg.conf.d/50-mouse-acceleration.conf &&
clear &&
echo "Finished"
