###################
#       GRUB      #
###################
echo "Instalando e configurando o GRUB"
pacman -S --noconfirm grub-efi-x86_64 efibootmgr

grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=arch_grub --recheck
cp /usr/share/locale/en\@quot/LC_MESSAGES/grub.mo /boot/grub/locale/en.mo
grub-mkconfig -o /boot/grub/grub.cfg

echo "Instalação concluída. Reinicie o computador (exit e reboot)"
#exit 
#reboot
