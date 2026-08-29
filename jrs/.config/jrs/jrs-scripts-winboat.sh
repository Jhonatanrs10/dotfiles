#!/bin/bash
create_docker_group(){
	sudo groupadd docker
	sudo usermod -aG docker $USER
	echo -e "\n Log out for the changes to take effect. \n"
	sleep 5
}
enable_docker_systemd(){
	sudo systemctl start docker
}

winboat() {
	local winboat_packages="winboat-bin docker docker-compose"
	yay -S $winboat_packages
	create_docker_group
	enable_docker_systemd
}
