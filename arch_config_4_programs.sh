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
pacman -S --noconfirm xf86-video-intel libgl mesa pulseaudio-alsa


#########################
#       Interface       #
#########################
echo "Instalando Gestor de login (Gnome)"
pacman -S --noconfirm gdm
systemctl enable gdm

# Adicionar aqui outros pacotes de temas, programas, etc (chromium, icones, themes, ...) 
echo "Instalando pacotes opcionais de interface GNOME"
pacman -S --noconfirm gnome gnome-terminal nautilus gnome-tweaks gnome-control-center gnome-backgrounds

echo "Instalando temas, ícones e fontes (twix)"
pacman -S --noconfirm adwaita-icon-theme ttf-hack

echo "Instalando programas e aplicativos"
pacman -S --noconfirm chromium gimp inkscape git youtube-dl

#reboot

# Configurar na Interface:
# Região e Idioma
# Data e Hora
# Resolução
# ajustar a resolução
# twix e Gnome ajustar a aparência de modo dark, habilitar opções "Places status indicator", "User Themes"

# Conexão com VPN (fortclient)
    # pacman -S --noconfirm ppp

# Seguir os passos de instalação do Thema abaixo em:
    # https://www.osradar.com/install-flat-remix-theme-ubuntu/
    # https://www.gnome-look.org/p/1253385/

#baixar os icones para o diretório ~/.icons criado no passo anterior
    # https://www.osradar.com/install-flat-remix-theme-ubuntu/
    # https://www.opendesktop.org/p/1284047/

# Instalar Snap
    # git clone https://aur.archlinux.org/snapd.git
    # cd snapd
    # makepkg -si
    # sudo systemctl enable --now snapd.socket

#ambiente de desenvolvimento
    # git clone https://aur.archlinux.org/visual-studio-code-bin.git
    # makepkg -si
    
    # git clone https://aur.archlinux.org/skypeforlinux-stable-bin.git
    # makepkg -si
    
    # git clone https://aur.archlinux.org/android-studio.git
    # makepkg -si

    # NVM - Olhar a vesão do NVM no github "https://github.com/nvm-sh/nvm"
    # curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/VERSAO_NVM/install.sh | bash
        # Exemplo: curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
    
    # NodeJs - Olhar vrsão do NodeJs LTS no site
    # nvm install vXX.XX.XX
        # Exemplo nvm install v12.18.3