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
#criaDiretorioInstall "$HOME/.diretorio"
#criaDiretorio "nomedavariavel" "$HOME/.diretorio"

criaLinkSym() {
	ln -s $1 $2
}
#criaLinkSym "diretorio" "diretorioLinkSym"

criaPastaBaixaExtrai() {
	criaDiretorio "bac" "$1"
	baixaArq "diretorioNome" "$2" "$1/$3"
	extrairArq "$bac"
}
#criaPastaBaixaExtrai "$HOME/.diretorio" "Link" "mod.jar"

criarArq() {
	echo "$1" >$2
}
nomeDoArquivo() {
	cd $1
	return $(ls *$2*)
}
addNoArq() {
	echo "$1" >>$2
}

criarArqv2() {
	cat <<REALEND >$2
$1
REALEND
}
#nomeDoArquivo "diretorio" "caracter que possui ex .jar"
#criarArq "seu texto aqui" "nomedoarquivo.txt"
#addNoArq "seu texto aqui" "nomedoarquivo.txt"
#criarArqv2 "seu texto aqui" "diretorio/nomedoarquivo.txt"
