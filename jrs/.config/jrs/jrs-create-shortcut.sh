#!/bin/bash

create_shortcut_bin() {
	varCreateShortcutBin="n"
	echo "Criar AtalhoBin? ($2) [s/n]"
	read varCreateShortcutBin
	if [ "$varCreateShortcutBin" = "s" ]; then
		chmod +x $1
		chmod 777 $1
		sudo ln -s $1 /usr/bin/jrs-$2
	fi
}

create_shortcut_desktop() {
	mkdir -p $HOME/.local/share/applications/jrs
	echo -e "[Desktop Entry]
Version=1.0
Type=Application
Name=$1
GenericName=jrs
Categories=jrs;
Comment=$2
Exec=$3
Icon=$7
Path=$4
StartupNotify=true
Terminal=$5" >$HOME/.local/share/applications/jrs/jrs-$6.desktop
}

create_shortcut_desktop_steps() {
	echo "DIGITE O NOME DO ATALHO (tudo junto sem caracteres)"
	read atalhoName
	echo "DIGITE A DESCRICAO"
	read atalhoDescricao
	echo "DIGITE O DIRETORIO DO ARQUIVO"
	read atalhoDiretorio
	echo "DIGITE O COMANDO"
	read atalhoComando
	echo "DIGITE O DIRETORIO DO ICONE"
	read atalhoIcone
	echo "TERMINAL true OU false"
	read atalhoTerminalTrueOuFalse
	create_shortcut_desktop "$atalhoName" "$atalhoDescricao" "$atalhoComando" "$atalhoDiretorio" "$atalhoTerminalTrueOuFalse" "$atalhoName" "$atalhoIcone"
}

create_shortcut_desktop_retroarch() {
	source $HOME/.dotfiles/jrs/.config/jrs/jrs-others.sh
	remove_shortcut_desktop "Retroarch"
	RetroArchCores="/usr/lib/libretro"
	RetroArchDiretorioGames="$HOME/Documents/Roms"
	echo "Colar Diretorio das Roms:"
	read RetroArchDiretorioGames
	echo "ESCOLHA A BIOS/CORE PRA A ROM:"
	options_list "$RetroArchCores" "RetroArchCore"
	options_list "$RetroArchDiretorioGames" "RetroArchGameName"
	create_shortcut_desktop "${RetroArchGameName%.*}" "Retroarch Game" "retroarch -f -L $RetroArchCores/$RetroArchCore $RetroArchDiretorioGames/$RetroArchGameName" "" "false" "Retroarch-${RetroArchGameName%.*}" "retroarch"
}

create_shortcut_desktop_retroarch2() {
	#!/usr/bin/env bash

	# Configurações de caminhos
	CORES_DIR="/usr/lib/libretro"
	ROMS_DIR_DEFAULT="$HOME/.config/retroarch/roms"
	DESKTOP_DIR="$HOME/.local/share/applications/jrs"
	BIN_DIR="$HOME/.local/bin"

	mkdir -p "$DESKTOP_DIR" "$BIN_DIR"

	# 1. Definição do diretório de Roms
	echo "Cole o Diretório das Roms (Pressione Enter para usar: $ROMS_DIR_DEFAULT):"
	read -r input_dir
	ROMS_DIR="${input_dir:-$ROMS_DIR_DEFAULT}"

	if [ ! -d "$ROMS_DIR" ]; then
		echo "Erro: Diretório '$ROMS_DIR' não existe."
		exit 1
	fi

	# 2. Seleção da BIOS / CORE
	if [ ! -d "$CORES_DIR" ]; then
		echo "Erro: Diretório de cores '$CORES_DIR' não foi encontrado."
		exit 1
	fi

	echo -e "\n=== SELECIONE O CORE (LIBRETRO) ==="
	mapfile -t cores_list < <(find "$CORES_DIR" -maxdepth 1 -name "*.so" -type f | sort)

	if [ ${#cores_list[@]} -eq 0 ]; then
		echo "Nenhum core (.so) foi encontrado em $CORES_DIR."
		exit 1
	fi

	for i in "${!cores_list[@]}"; do
		printf "%3d) %s\n" $((i + 1)) "$(basename "${cores_list[$i]}")"
	done

	read -p "Digite o número do Core desejado: " core_choice
	if ! [[ "$core_choice" =~ ^[0-9]+$ ]] || [ "$core_choice" -lt 1 ] || [ "$core_choice" -gt "${#cores_list[@]}" ]; then
		echo "Opção inválida."
		exit 1
	fi

	SELECTED_CORE_PATH="${cores_list[$((core_choice - 1))]}"

	# 3. Seleção Recursiva da ROM
	echo -e "\n=== SELECIONE O JOGO (Buscando em subpastas...) ==="
	mapfile -d $'\0' roms_list < <(find "$ROMS_DIR" -type f -print0 | sort -z)

	if [ ${#roms_list[@]} -eq 0 ]; then
		echo "Nenhuma ROM/arquivo encontrado em $ROMS_DIR."
		exit 1
	fi

	for i in "${!roms_list[@]}"; do
		rel_path="${roms_list[$i]#$ROMS_DIR/}"
		printf "%3d) %s\n" $((i + 1)) "$rel_path"
	done

	read -p "Digite o número do Jogo desejado: " rom_choice
	if ! [[ "$rom_choice" =~ ^[0-9]+$ ]] || [ "$rom_choice" -lt 1 ] || [ "$rom_choice" -gt "${#roms_list[@]}" ]; then
		echo "Opção inválida."
		exit 1
	fi

	SELECTED_ROM_PATH="${roms_list[$((rom_choice - 1))]}"

	# 4. Extração e sanitização dos nomes
	FILENAME=$(basename "$SELECTED_ROM_PATH")
	GAME_NAME="${FILENAME%.*}"

	GAME_SLUG=$(echo "$GAME_NAME" | tr '[:upper:]' '[:lower:]' | sed -e 's/[^a-z0-9]/-/g' -e 's/--*/-/g' -e 's/^-//;s/-$//')
	DESKTOP_NAME="jrs-retroarch-$GAME_SLUG"
	DESKTOP_FILE_PATH="$DESKTOP_DIR/$DESKTOP_NAME.desktop"

	# Comando exato do RetroArch que será executado (usando variáveis expandidas corretamente)
	RETROARCH_EXEC="retroarch -f -L \"$SELECTED_CORE_PATH\" \"$SELECTED_ROM_PATH\""

	# 5. Criando o arquivo .desktop
	cat <<EOF >"$DESKTOP_FILE_PATH"
[Desktop Entry]
Version=1.0
Type=Application
Name=$GAME_NAME
Comment=RetroArch Game - $GAME_NAME
Exec=$RETROARCH_EXEC
Icon=retroarch
Terminal=false
Categories=Game;Emulator;
EOF

	chmod +x "$DESKTOP_FILE_PATH"

	# Notifica e finaliza
	echo -e "\n--------------------------------------------------"
	echo " Sucesso!"
	echo " Atalho .desktop gerado em: $DESKTOP_FILE_PATH"
	echo "--------------------------------------------------"
}

create_shortcut_desktop_chromium_web_app() {
	echo "DIGITE O NOME DO ATALHO (tudo junto sem caracteres)"
	read atalhoName
	echo "DIGITE O LINK"
	read atalhoComando
	if [[ -z "$atalhoName" || -z "$atalhoComando" ]]; then
		exit 1
	fi
	create_shortcut_desktop "$atalhoName" "Chromium Web App" "chromium --app=$atalhoComando" "" "false" "chromium-web-app-$atalhoName" "web-browser"
}

remove_shortcut_desktop() {
    # Lista todos os atalhos em um array
    local atalhos=($HOME/.local/share/applications/jrs/jrs-*)

    # Verifica se encontrou algum arquivo
    if [ ! -e "${atalhos[0]}" ]; then
        echo "Nenhum atalho encontrado."
        sleep 2
        clear
        return
    fi

    while true; do
        clear
        echo "========================================"
        echo "     SELECIONE O ATALHO PARA APAGAR     "
        echo "========================================"
        echo "0) Apagar TODOS os atalhos"
        
        # Exibe a lista numerada
        local i=1
        for atalho in "${atalhos[@]}"; do
            if [ -f "$atalho" ]; then
                echo "$i) $(basename "$atalho")"
            fi
            ((i++))
        done
        
        echo "s) Sair / Voltar"
        echo "----------------------------------------"
        read -p "Digite o número da opção desejada: " resp

        # Opção para sair
        if [ "$resp" = "s" ] || [ "$resp" = "S" ]; then
            clear
            break
        fi

        # Opção 0: Apagar todos
        if [ "$resp" = "0" ]; then
            read -p "Tem certeza que deseja apagar TODOS os atalhos? (s/n): " confirm
            if [ "$confirm" = "s" ] || [ "$confirm" = "S" ]; then
                sudo rm -f "$HOME/.local/share/applications/jrs/jrs-"*
                echo "-> Todos os atalhos foram removidos!"
                sleep 2
            fi
            clear
            break
        fi

        # Validar se digitou um número válido da lista
        if [[ "$resp" =~ ^[0-9]+$ ]] && [ "$resp" -ge 1 ] && [ "$resp" -lt "$i" ]; then
            local indice=$((resp - 1))
            local arquivo_escolhido="${atalhos[$indice]}"
            
            echo ""
            echo "Atalho selecionado: $(basename "$arquivo_escolhido")"
            read -p "Deseja realmente apagar este atalho? (s/n): " confirm
            if [ "$confirm" = "s" ] || [ "$confirm" = "S" ]; then
                sudo rm -f "$arquivo_escolhido"
                echo "-> Atalho removido com sucesso!"
                sleep 1.5
            else
                echo "-> Operação cancelada."
                sleep 1
            fi
            
            # Atualiza a lista após apagar um item
            atalhos=($HOME/.local/share/applications/jrs/jrs-*)
            if [ ! -e "${atalhos[0]}" ]; then
                echo "Não há mais atalhos."
                sleep 2
                clear
                break
            fi
        else
            echo "Opção inválida!"
            sleep 1
        fi
    done
}

create_shortcut_menu() {
	echo "[Create Shortcut Menu]
[1] Desktop
[2] Retroarch
[3] Chromium Web App
[4] Remover Shortcuts"
	read resp
	case $resp in
	1) create_shortcut_desktop_steps ;;
	2) create_shortcut_desktop_retroarch2 ;;
	3) create_shortcut_desktop_chromium_web_app ;;
	4) remove_shortcut_desktop ;;
	*) ;;
	esac
}
