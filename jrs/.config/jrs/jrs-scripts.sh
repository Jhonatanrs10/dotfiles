#!/bin/bash

# Cores ANSI
RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
CYAN="\033[36m"
RESET="\033[0m"

# Define o caminho completo (o Bash expande o ~ automaticamente)
FUNCTIONS_PATH="$HOME/.config/jrs/jrs-functions*"

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
	local wrapper="$JRS_DIR/.jrs.sh"
	local link_name="jrs"
	local link_path="/usr/bin/$link_name"

	# Verifica se o arquivo wrapper já existe
	if [ ! -f "$wrapper" ]; then
		echo "O atalho '$link_name' não existe. Criando agora..."

		# Cria o diretório se ele não existir
		mkdir -p "$(dirname "$wrapper")"

		# Cria o arquivo wrapper
		cat <<EOF >"$wrapper"
#!/bin/bash
cd "$PWD"
bash "jrs-scripts.sh"
EOF

		# Torna o arquivo executável
		chmod +x "$wrapper"
		echo "Arquivo wrapper criado em: $wrapper"
	fi

	# Verifica se o link simbólico existe e o cria se não
	if [ ! -L "$link_path" ]; then
		echo "O link simbólico para '$link_name' não existe. Criando agora..."
		sudo ln -sf "$wrapper" "$link_path"
		echo "Atalho '$link_name' criado com sucesso!"
	else
		echo "Atalho '$link_name' já está instalado."

	fi
	sleep 0
}

dependencies

# Lista de opções (texto e função correspondente)
opcoes=(
	"Pos Install::myBasePosInstall"
	"Montar Disco::myBaseMountDisk"
	"Link Simbólico::myBaselnHome"
	"VirtManager::installVirtManager"
	"Diretório Inode Padrão::defaultInodeDirectory"
	"Configuração Git::gitconfig"
	"Bongo::bongo"
	"Pokexgames::installPokexgames"
	"Minecraft::installMinecraft"
	"Servidor Rede Virtual::installRedeVirtual"
	"Servidor User::serversLinuxUser"
	"Servidor Minecraft::installMinecraftServer"
	"Servidor FiveM::installFivem"
	"Servidor Unturned::installUnturnedServer"
	"Servidor Project Zomboid::installProjectZomboidServer"
	"Servidor Palworld::installPalworldServer"
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
	"Remover Atalhos JRS::removeDesktopJRS"
	"PulseAudio Virtual::virtualPulseAudioExec"
	"Pós-Config Manual::appPosManualConfig"
	"Pós-Fix Bluetooth::appPosBluetoothFix"
	"Pós-Teclado::appPosTecladoConfig"
	"Pós-Hora (NTP)::appPosTimeNTP"
	"Pós-Touchpad (i3)::appPosI3Touchpad"
	"Ignorar Ação da Bandeja::lidSwitchIgnore"
	"Reparar Pacman::repairPM"
	"Discord Config Hyprland::hyprlandDiscordX"
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
