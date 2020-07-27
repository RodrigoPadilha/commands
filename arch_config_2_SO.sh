##########################
#  Config SO Instalado   #
##########################
echo "Ajute de TimeZone"
ls -sf /usr/share/zoneinfo/America/Sao_Paulo >> /etc/localtime

echo "Ajute do clock"
hwclock --systohc

echo "Config Idioma"
echo pt_BR.UTF-8 UTF-8 >> /etc/locale.gen
locale-gen

echo "Config Variavel de Linguagem"
echo LANG=pt_BR.UTF-8 >> /etc/locale.conf

echo "Config Teclado ABNT2"
echo KEYMAP=br-abnt2 >> /etc/vconsole.conf

echo "Config Hostname nome do computador"
echo sirius >> /etc/hostname

echo "Config Hosts"
echo 127.0.0.1 localhost.localdomain localhost >> /etc/hosts
echo ::1 localhost.localdomain localhost >> /etc/hosts
echo 127.1.1 sirius.localdomain sirius >> /etc/hosts

pass="Kepler"
echo "Alterar senha root para $pass"
echo -e "${pass}\n${pass}" | passwd

echo "Instalando pacotes de interface e compatibilidade"
pacman -S --noconfirm dosfstools os-prober mtools network-manager-applet networkmanager wpa_supplicant wireless_tools dialog sudo

echo "Criando usuário rodrigo..."
useradd -m -g users -G wheel rodrigo
echo rodrigo ALL=(ALL)ALL >> /etc/sudoers
echo -e "${pass}\n${pass}" | passwd rodrigo