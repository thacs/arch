#!/bin/bash
echo -e "%wheel ALL=(ALL) ALL" > /etc/sudoers.d/99_wheel &&
echo -e "en_US.UTF-8 UTF-8\nen_US ISO-8859-1" > /etc/locale.gen &&
locale-gen &&
echo "LANG=en_US.UTF-8" >> /etc/locale.conf &&
echo "KEYMAP=fi" >> /etc/vconsole.conf &&
ln -sf /usr/share/zoneinfo/Europe/Helsinki /etc/localtime &&
grub-mkconfig -o /boot/grub/grub.cfg &&
pacman -S --noconfirm dhcpcd openssh &&
systemctl enable sshd &&
systemctl enable dhcpcd
