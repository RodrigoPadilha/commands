echo “Limpando Cache e Swap…”

#sudo -i

sudo echo 3 > /proc/sys/vm/drop_caches
sudo sysctl -w vm.drop_caches=3
sudo swapoff -a && swapon -a
clear
echo “Limpeza do Cache e Swap efetuada com sucesso”
