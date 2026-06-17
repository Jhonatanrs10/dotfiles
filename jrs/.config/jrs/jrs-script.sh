#!/bin/bash

# Cores ANSI
RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
CYAN="\033[36m"
RESET="\033[0m"

# Define o caminho completo (o Bash expande o ~ automaticamente)
FUNCTIONS_PATH="$HOME/.dotfiles/jrs/.config/jrs/jrs-scripts*"

# Ativa o nullglob para não dar erro se a pasta estiver vazia
shopt -s nullglob

for file in $FUNCTIONS_PATH; do
	if [ -f "$file" ]; then
		source "$file"
		#echo "Carregado: $file"
		#sleep 3
	fi
done

shopt -u nullglob

dependencies() {
    local link_name="jrs"
    local link_path="/usr/bin/$link_name"

    if [ ! -f "$link_path" ]; then
        echo "Criando o executável direto em $link_path..."

        # Cria o arquivo direto na pasta /usr/bin usando sudo e tee
        sudo tee "$link_path" > /dev/null <<EOF
#!/bin/bash
cd "$HOME/.dotfiles/jrs/.config/jrs"
bash "jrs-script.sh"
EOF

        # Torna o arquivo em /usr/bin executável
        sudo chmod +x "$link_path"
        echo "Atalho '$link_name' instalado com sucesso!"
    else
        echo "Atalho '$link_name' já existe."
    fi
}

dependencies

# Lista de opções (texto e função correspondente)
opcoes=(
	"Pos Install::myBasePosInstall"
	"Apps Install::installApps"
	"Montar Disco::myBaseMountDisk"
	"Stow Dotfiles::stowSetup"
	"Configuração Git::gitconfig"
	"Servidor Rede Virtual::installRedeVirtual"
	"Servidor User::serversLinuxUser"
	"Servidor Minecraft::installMinecraftServer"
	"Servidor FiveM::installFivem"
	"Servidor Unturned::installUnturnedServer"
	"Servidor Project Zomboid::installProjectZomboidServer"
	"Steamcmd Servers::steamcmd_servers"
	"Servidor SA-MP::sampServer"
	"Servidor Terraria::terrariaServer"
	"Node LTS::nodejslts"
	"Java Install/Version::installJava"
	"Gamepads Virtuais::virtualGamepads"
	"Atalho Desktop::criaAtalhoDesktop"
	"Atalho Desktop Retroarch (Arch)::criaAtalhoDesktopRetroarchArch"
	"Criar Arq Exec Dir::criaArqRunDiretorioInstall"
	"Atalho Terminal::AtalhoTerminalBin"
	"Setup AppImage::setupAppimage"
	"Reparar Pacman::repairPM"
	"User Locked::faillock_user"
	"SteamOSMode::steamos-setup"
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
