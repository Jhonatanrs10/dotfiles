#!/bin/bash

JRS_DIR="$HOME/.dir_jrs"

source $HOME/.dotfiles/jrs/.config/jrs/jrs-scripts-posinstall.sh
source $HOME/.dotfiles/jrs/.config/jrs/jrs-scripts-mount-disk.sh
source $HOME/.dotfiles/jrs/.config/jrs/jrs-scripts-git.sh
source $HOME/.dotfiles/jrs/.config/jrs/jrs-servers.sh

# Cores ANSI
RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
CYAN="\033[36m"
RESET="\033[0m"

link_name="jrs"
link_path="/usr/bin/$link_name"

if [ ! -f "$link_path" ]; then
	echo "Criando o executável direto em $link_path..."

	# Cria o arquivo direto na pasta /usr/bin usando sudo e tee
	sudo tee "$link_path" >/dev/null <<EOF
#!/bin/bash
cd "$HOME/.dotfiles/jrs/.config/jrs"
exec bash "jrs-script.sh"
EOF

	# Torna o arquivo em /usr/bin executável
	sudo chmod +x "$link_path"
	echo "Atalho '$link_name' instalado com sucesso!"
else
	echo "Atalho '$link_name' já existe."
fi

# Lista de opções (texto e função correspondente)
opcoes=(
	"Pos Install::posinstall"
	"Stow Dotfiles::setup_stow"
	"Mount Disk::mount_disk"
	"Git Config::setup_git"
	"Decicated Servers::dedicated_servers"
)

linhas_terminal=$(tput lines)
opcoes_por_pagina=$((linhas_terminal - 7))
pagina=0
total_opcoes=${#opcoes[@]}
total_paginas=$(((total_opcoes + opcoes_por_pagina - 1) / opcoes_por_pagina))

mostrar_menu() {
	clear
	echo -e "${CYAN}${RESET}"
	echo -e "${GREEN}  SCRIPTS - Page $((pagina + 1))/${total_paginas}${RESET}"
	echo -e "${CYAN}${RESET}"

	inicio=$((pagina * opcoes_por_pagina))
	fim=$((inicio + opcoes_por_pagina))
	if [ $fim -gt $total_opcoes ]; then fim=$total_opcoes; fi

	for ((i = inicio; i < fim; i++)); do
		opcao_texto="${opcoes[i]%%::*}"
		printf " ${GREEN}[%02d]${RESET} %s\n" $((i + 1)) "$opcao_texto"
	done
}

executar_opcao() {
	idx=$1
	if [[ "$idx" =~ ^[0-9]+$ ]] && [ "$idx" -ge 1 ] && [ "$idx" -le "$total_opcoes" ]; then
		funcao="${opcoes[idx - 1]##*::}"
		echo -e "\nExecutando: ${CYAN}$funcao${RESET}\n"
		#$dir_jrs/$funcao
		$funcao
		echo -e "\n${YELLOW}Press Enter to return to the menu...${RESET}"
		read
	else
		echo -e "${RED}Invalid option!${RESET}"
		sleep 1
	fi
}

while true; do
	mostrar_menu

	echo -e "\n${YELLOW}Use ↑ ↓ to navigate${RESET}\n"
	echo -ne "${CYAN}Enter the option number or 'q' to exit:${RESET} "
	read -rsn1 input

	# Verifica se é seta
	if [[ $input == $'\x1b' ]]; then
		read -rsn2 -t 0.1 input2
		input+="$input2"
	fi

	case "$input" in
	$'\x1b[A') # seta para cima
		if [ $pagina -gt 0 ]; then ((pagina--)); fi
		;;
	$'\x1b[B') # seta para baixo
		if [ $pagina -lt $((total_paginas - 1)) ]; then ((pagina++)); fi
		;;
	q)
		clear
		echo -e "${RED}Exiting the menu. See you later!${RESET}"
		exit 0
		;;
	"")
		continue
		;;
	*)
		# Permitir digitar número de opção (completando com o resto)
		echo -n "$input"
		read -r restante
		executar_opcao "$input$restante"
		;;
	esac
done
