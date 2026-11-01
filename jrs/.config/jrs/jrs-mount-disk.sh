#!/bin/bash

mount_disk() {
	DATANOW=$(date "+[%d-%m-%Y][%H-%M]")
	my_disk_dir="/media/"
	# somente leitura pode ser o modo de energia do windows em dualboot (modo de reinicialização rapida)
	echo "Mount Disk?
Options: [1]Yes, [2]No"
	read resp
	case $resp in
	1)
		sudo fdisk -l
		echo "Digite o caminho do disco Ex.: /dev/sdb1"
		read DEVSD
		sudo cp /etc/fstab /etc/fstab$DATANOW.bkp
		sudo mkdir -p $my_disk_dir$(sudo blkid -s UUID -o value $DEVSD)
		#id -u
		#id -g
		echo "Type Disk
Options: [1]ext4 [2]ntfs"
		read resp
		case $resp in
		1)
			sudo tee -a /etc/fstab <<<'# '$DEVSD' 
UUID='$(sudo blkid -s UUID -o value $DEVSD)' '$my_disk_dir$(sudo blkid -s UUID -o value $DEVSD)' ext4 rw,exec,nosuid,nodev,nofail,x-gvfs-show 0 0'
			sudo chown -R $USER:$USER $my_disk_dir$(sudo blkid -s UUID -o value $DEVSD)
			;;
		2)
			sudo tee -a /etc/fstab <<<'# '$DEVSD' 
UUID='$(sudo blkid -s UUID -o value $DEVSD)' '$my_disk_dir$(sudo blkid -s UUID -o value $DEVSD)' ntfs uid='$(id -u)',gid='$(id -g)',rw,user,exec,nofail,umask=000 0 0'
			;;
		*) ;;
		esac
		cat /etc/fstab
		sleep 5

		#rm -r ~/.steam/steam/steamapps/compatdata
		#mkdir -p ~/.steam/steam/steamapps/compatdata
		#ln -s ~/.steam/steam/steamapps/compatdata /media/gamedisk/Steam/steamapps/
		;;
	*) ;;
	esac
}