loadkeys br-abnt2

fdisk -l

######################
#  Config Partições  #
######################
echo "Particionando Disco..."
echo "Informe o disco que será instalado o Arch? Exemplo: /dev/sda"
read disco
$ sed -e 's/\s*\([\+0-9a-zA-Z]*\).*/\1/' << FDISK_CMDS  | sudo fdisk $disco
g      # create new GPT partition
n      # add new partition
1      # partition number
       # default - first sector 
+500M  # partition size
n      # add new partition
2      # partition number
       # default - first sector 
+60G   # partition size   
n      # add new partition
3      # partition number
       # default - first sector 
+161G  # partition size   
n      # add new partition
4      # partition number
       # default - first sector 
       # default - last sector 
t      # change partition type
1      # partition number
70     # Multi-Boot Disk (BIOS Boot???)
t      # change partition type
2      # partition number
83     # Linux filesystem
t      # change partition type
3      # partition number
83     # Linux filesystem
t      # change partition type
4      # partition number
82     # Linux Swap
w      # write partition table and exit
FDISK_CMDS


echo "Defina o type Bios Boot na partiçaõ /boot!"
read ok
cfdisk $disco


echo "Formatando Partições..."
bootPartition=${disco}1
systemPartition=${disco}2
homePartition=${disco}3
swapPartition=${disco}4

mkfs.fat -F32 $bootPartition
mkfs.ext4 $systemPartition
mkfs.ext4 $homePartition
mkswap $swapPartition


echo "Montando Partições..."
mount $systemPartition /mnt
mkdir /mnt/boot
mkdir /mnt/boot/efi
mkdir /mnt/home

mount $bootPartition /mnt/boot/efi
mount $homePartition /mnt/home
swapon $swapPartition


echo "Push dos pacotes do Arch Linux"
pacstrap /mnt base base-devel linux linux-firmware


echo "Gerando arquivo FSTAB..."
genfstab -U -p /mnt >> /mnt/etc/fstab
cat /mnt/etc/fstab
echo "O arquivo FSTAB foi gerado corretamente?"
read ok


echo "Alterado para SO da máquina"
arch-chroot /mnt
