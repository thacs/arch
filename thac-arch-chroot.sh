#!/bin/bash
systemctl enable dhcpcd &&
grub-install --recheck /dev/vda &&
grub-mkconfig -o /boot/grub/grub.cfg &&
echo -e "en_US.UTF-8 UTF-8\nen_US ISO-8859-1" > /etc/locale.gen &&
locale-gen &&
echo "LANG=en_US.UTF-8" >> /etc/locale.conf &&
echo "KEYMAP=fi" >> /etc/vconsole.conf &&
ln -sf /usr/share/zoneinfo/Europe/Helsinki /etc/localtime &&
echo -e "%wheel ALL=(ALL) ALL\nDefaults rootpw" > /etc/sudoers.d/99_wheel &&
#xfce install
pacman -S --noconfirm xorg-xinit xorg-server pipewire pipewire-pulse pipewire-alsa pipewire-jack xfce4 xfce4-whiskermenu-plugin xfce4-pulseaudio-plugin pavucontrol feh mpv qbittorrent firefox gvfs xarchiver unzip git wget xfce4-screenshooter sddm &&
