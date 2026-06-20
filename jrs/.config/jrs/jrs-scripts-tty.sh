#!/bin/bash

setupIwdWiFi() {

	iwf_main_file() {
		sudo tee "/etc/iwd/main.conf" >/dev/null <<EOF
[General]
EnableNetworkConfiguration=True
[Network]
RoutePriorityOffset=300
EnableIPv6=false
EOF
	}

	echo "Opções: [1] IWD WIFI [2] NetworkManager [3]ALL ENABLE"
	read -r resp
	case $resp in
	1)
		iwf_main_file
		sudo systemctl disable --now NetworkManager
		sudo systemctl disable --now dhcpcd
		sudo systemctl enable --now iwd
		;;
	2)
		sudo systemctl disable --now iwd
		sudo systemctl disable --now dhcpcd
		sudo systemctl enable --now NetworkManager
		;;
	3)
		iwf_main_file
		sudo systemctl enable --now NetworkManager
		sudo systemctl enable --now dhcpcd
		sudo systemctl enable --now iwd
		;;
	*)
		echo "Opção inválida. Nenhuma alteração feita."
		;;
	esac

}
