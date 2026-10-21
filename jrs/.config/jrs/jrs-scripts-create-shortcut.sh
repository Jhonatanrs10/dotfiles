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

create_all_exec_shortcuts() {
	local scripts_dir="$HOME/.dotfiles/jrs/.config/jrs"

	# Mapeia todos os scripts em um array
	local scripts=("$scripts_dir"/jrs-exec-*.sh)
	if [ ! -e "${scripts[0]}" ]; then
		echo "Nenhum script encontrado em $scripts_dir"
		return 1
	fi

	echo "=== Gerador de Atalhos Interativo ==="
	echo "Scripts disponíveis:"

	local i=1
	declare -A script_map
	for script in "${scripts[@]}"; do
		[ -e "$script" ] || continue
		local filename=$(basename "$script")
		script_map[$i]="$script"
		echo "  [$i] $filename"
		((i++))
	done

	echo "  [a] Todos os scripts"
	echo -n "Escolha o número do script (ou 'a' para todos): "
	read -r escolha

	local selected_scripts=()
	if [[ "$escolha" =~ ^[0-9]+$ ]] && [ -n "${script_map[$escolha]}" ]; then
		selected_scripts+=("${script_map[$escolha]}")
	elif [ "$escolha" = "a" ] || [ "$escolha" = "A" ]; then
		selected_scripts=("${scripts[@]}")
	else
		echo "Opção inválida!"
		return 1
	fi

	# Processa os scripts selecionados
	for script in "${selected_scripts[@]}"; do
		[ -e "$script" ] || continue
		local filename=$(basename "$script")
		local name_raw="${filename#jrs-exec-}"
		local short_name="${name_raw%.sh}"
		local default_app_name="$(tr '[:lower:]' '[:upper:]' <<<${short_name:0:1})${short_name:1}"

		echo ""
		echo "--- Configurando atalho para: $filename ---"

		# Escolha manual do Nome
		echo -n "Nome do aplicativo [$default_app_name]: "
		read -r custom_app_name
		local app_name="${custom_app_name:-$default_app_name}"

		# Escolha manual do Ícone
		echo -n "Nome ou caminho do ícone (ex: utilities-terminal ou /path/to/icon.png) [$short_name]: "
		read -r custom_icon
		local icon_name="${custom_icon:-$short_name}"

		create_shortcut_desktop \
			"$app_name" \
			"Atalho gerado para $app_name" \
			"$script" \
			"" \
			"false" \
			"exec-$short_name" \
			"$icon_name"

		echo "Sucesso! Atalho criado para: $app_name"
	done
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
	source $HOME/.dotfiles/jrs/.config/jrs/jrs-scripts-others.sh
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
	DESKTOP_NAME="retroarch-$GAME_SLUG"
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

	# 6. Criando o executável no bin garantindo que ele repasse o comando exato com aspas
	LN_PATH="$BIN_DIR/$DESKTOP_NAME"
	rm -f "$LN_PATH"
	
	cat <<EOF >"$LN_PATH"
#!/usr/bin/env bash
$RETROARCH_EXEC
EOF
    chmod +x "$LN_PATH"

	# Notifica e finaliza
	echo -e "\n--------------------------------------------------"
	echo " Sucesso!"
	echo " Atalho .desktop gerado em: $DESKTOP_FILE_PATH"
	echo " Comando direto no terminal habilitado: $DESKTOP_NAME"
	echo "--------------------------------------------------"
}

create_shortcut_desktop_chromium_web_app() {
	echo "DIGITE O NOME DO ATALHO (tudo junto sem caracteres)"
	read atalhoName
	echo "DIGITE O LINK"
	read atalhoComando
	create_shortcut_desktop "$atalhoName" "Chromium Web App" "chromium --app=$atalhoComando" "" "false" "chromium-web-app-$atalhoName" "web-browser"
}

remove_shortcut_desktop() {
	echo "DESEJA APAGAR OS ATALHOS $1 (s/n)"
	read resp
	if [ "$resp" = "s" ]; then
		sudo rm $HOME/.local/share/applications/jrs/jrs-$1-*
	fi
	clear
}

create_shortcut_menu() {
	echo "[Create Shortcut Menu]
[1] Desktop
[2] Retroarch
[3] Chromium Web App
[4] Desktop for (jrs-exec-*) Files"
	read resp
	case $resp in
	1) create_shortcut_desktop_steps ;;
	2) create_shortcut_desktop_retroarch2 ;;
	3) create_shortcut_desktop_chromium_web_app ;;
	4) create_all_exec_shortcuts ;;
	*) ;;
	esac
}
