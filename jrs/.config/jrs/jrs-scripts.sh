#!/bin/bash

JRS_DIR="$HOME/.dir_jrs"

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
exec bash "jrs-scripts.sh"
EOF

	# Torna o arquivo em /usr/bin executável
	sudo chmod +x "$link_path"
	echo "Atalho '$link_name' instalado com sucesso!"
else
	echo "Atalho '$link_name' já existe."
fi

# Lista de opções (texto e função correspondente)
opcoes=(
	"Pos Install::$HOME/.dotfiles/jrs/.config/jrs/jrs-scripts-posinstall.sh::posinstall"
	"Stow Dotfiles::$HOME/.dotfiles/jrs/.config/jrs/jrs-scripts-posinstall.sh::setup_stow"
	"Mount Disk::$HOME/.dotfiles/jrs/.config/jrs/jrs-scripts-mount-disk.sh::mount_disk"
	"Git Config::$HOME/.dotfiles/jrs/.config/jrs/jrs-scripts-git.sh::setup_git"
	"Decicated Servers::$HOME/.dotfiles/jrs/.config/jrs/jrs-servers.sh::dedicated_servers"
	"Virtual Network::$HOME/.dotfiles/jrs/.config/jrs/jrs-scripts-network-tunneling.sh::install_rede_virtual"
)

linhas_terminal=$(tput lines)
opcoes_por_pagina=$((linhas_terminal - 7))
pagina=0
total_opcoes=${#opcoes[@]}
total_paginas=$(((total_opcoes + opcoes_por_pagina - 1) / opcoes_por_pagina))

mostrar_menu() {
	clear
	echo -e "${GREEN}  SCRIPTS - Page $((pagina + 1))/${total_paginas}${RESET}"
	echo ""

	inicio=$((pagina * opcoes_por_pagina))
	fim=$((inicio + opcoes_por_pagina))
	if [ $fim -gt $total_opcoes ]; then fim=$total_opcoes; fi

	for ((i = inicio; i < fim; i++)); do
		# Pega apenas o texto antes do primeiro '::'
		opcao_texto=$(echo "${opcoes[i]}" | cut -d':' -f1)
		printf " ${GREEN}[%02d]${RESET} %s\n" $((i + 1)) "$opcao_texto"
	done
}

executar_opcao() {
	idx=$1
	if [[ "$idx" =~ ^[0-9]+$ ]] && [ "$idx" -ge 1 ] && [ "$idx" -le "$total_opcoes" ]; then
		# Extrai os dados usando cut
		linha_completa="${opcoes[idx - 1]}"
		script_path=$(echo "$linha_completa" | cut -d':' -f3)
		funcao=$(echo "$linha_completa" | cut -d':' -f5) # cut conta os ':' vazios

		echo -e "\nExecutando: ${CYAN}$funcao${RESET}\n"

		# Faz o source do arquivo apenas se o caminho foi informado e o arquivo existir
		if [ -n "$script_path" ] && [ -f "$script_path" ]; then
			source "$script_path"
		fi

		# Executa a função
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
