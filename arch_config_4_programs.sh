##################################
#       Drivers e Interface      #
##################################

echo "Ativando NetworkManager"
systemctl start NetworkManager
systemctl enable NetworkManager

echo "Sincronizando base de dados"
pacman -Sy 

echo "Instalando pacotes básicos para o funcionamento de qualquer interface"
pacman -S --noconfirm xorg-server

echo "Instalando drivers de vídeo"
pacman -S --noconfirm xf86-video-intel libgl mesa


#########################
#       Interface       #
#########################
echo "Instalando Gestor de login (Gnome)"
pacman -S --noconfirm gdm
systemctl enable gdm

# Adicionar aqui outros pacotes de temas, programas, etc (chromium, icones, themes, ...) 
echo "Instalando pacotes opcionais de interface GNOME"
pacman -S --noconfirm gnome gnome-terminal nautilus gnome-tweaks gnome-control-center gnome-backgrounds

echo "Instalando temas e ícones (twix)"
pacman -S --noconfirm adwaita-icon-theme

echo "Instalando programas e aplicativos"
pacman -S --noconfirm chromium gimp inkscape

#reboot

# Configurar na Interface:
# Região e Idioma
# Data e Hora
# Resolução
# ajustar a resolução
# twix e Gnome ajustar a aparência de modo dark, habilitar opções "Places status indicator", "User Themes"