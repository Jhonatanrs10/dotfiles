#!/usr/bin/env bash

# Cores ANSI
RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
CYAN="\033[36m"
RESET="\033[0m"

sourceFolder() {
  for src in $(ls $1); do
    source $1/$src
    #echo "$1/$src"
  done
  #sleep 10
}
sourceFolder "./lib"
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
  "Pós-Rede::appPosNetwork"
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
