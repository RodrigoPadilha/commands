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

# Compartilhamento da tela
    #https://wiki.archlinux.org/index.php/PipeWire
    #http://jgrulich.cz/2018/07/04/how-to-enable-and-use-screen-sharing-on-wayland/
    
# Conexão com VPN (fortclient)
    # pacman -S --noconfirm ppp

# Skype
    # git clone https://aur.archlinux.org/skypeforlinux-stable-bin.git
    # makepkg -si

# Discord
    # pacman -S discord

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
    # Docker 
    # pacman -S docker
    # systemctl start docker.service        # immediately starts the Docker daemon
    # systemctl enable docker.service       # ensures that the daemon will start automatically on bootup.
    # groupadd docker                       # creates a new group called docker
    # sudo gpasswd -a rodrigo docker        # adds a user to the group

    # Docker-Compose 
    # sudo curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    # sudo chmod +x /usr/local/bin/docker-compose

    # git clone https://aur.archlinux.org/visual-studio-code-bin.git
    # makepkg -si    
    
    # git clone https://aur.archlinux.org/android-studio.git
    # makepkg -si

    # https://aur.archlinux.org/insomnia.git
    # makepkg -si

    # Azure DataStudio
    # https://aur.archlinux.org/azuredatastudio.git 

    # NVM - Olhar a vesão do NVM no github "https://github.com/nvm-sh/nvm"
    # curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/VERSAO_NVM/install.sh | bash
        # Exemplo: curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
    
    # NodeJs - Olhar vrsão do NodeJs LTS no site
    # nvm install vXX.XX.XX
        # Exemplo nvm install v12.18.3

    # Python
    # pacman -S python-pip python-setuptools
    # sudo pacman -S unixodbc
    # sudo pacman -S gcc
    # sudo pacman -S libffi
    # sudo pacman -S python

    # Android studio
        # AndroidStudio
        # export PATH="$PATH:/home/rodrigo/Android/Sdk/platform-tools:/home/rodrigo/Android/Sdk/tools"


