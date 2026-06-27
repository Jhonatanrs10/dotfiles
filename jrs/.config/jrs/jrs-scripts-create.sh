#!/bin/bash

criaDiretorioInstall() {
	export diretorioInstall="$1"
	mkdir -p $diretorioInstall
	cd $diretorioInstall
}

criaDiretorio() {
	export $1="$2"
	mkdir -p $2
}

criarArq() {
	echo "$1" >$2
}
