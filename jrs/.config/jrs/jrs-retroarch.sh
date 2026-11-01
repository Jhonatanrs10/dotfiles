#!/bin/bash

retroarch_roms() {
	# Diretório padrão onde o Arch Linux armazena as bibliotecas libretro
	DEFAULT_CORE_DIR="/usr/lib/libretro"
	# Diretório padrão de ROMs
	DEFAULT_ROM_DIR="$HOME/.config/retroarch/roms"

	clear
	echo "=== LANÇADOR INTERATIVO DO RETROARCH ==="
	echo

	# Se o usuário apenas pressionar Enter (entrada vazia), usa o padrão
	ROM_BASE_DIR="${DEFAULT_ROM_DIR}"

	if [ ! -d "$ROM_BASE_DIR" ]; then
		echo "Erro: O diretório '$ROM_BASE_DIR' não existe."
		exit 1
	fi

	# 2. Lista as subpastas (plataformas)
	echo "Plataformas encontradas em $ROM_BASE_DIR:"
	subpastas=($(find "$ROM_BASE_DIR" -mindepth 1 -maxdepth 1 -type d -exec basename {} \;))

	if [ ${#subpastas[@]} -eq 0 ]; then
		echo "Nenhuma subpasta encontrada no diretório de ROMs."
		exit 1
	fi

	for i in "${!subpastas[@]}"; do
		echo "  [$((i + 1))] ${subpastas[$i]}"
	done

	echo
	read -p "Escolha o número da plataforma: " escolha_pasta

	if ! [[ "$escolha_pasta" =~ ^[0-9]+$ ]] || [ "$escolha_pasta" -lt 1 ] || [ "$escolha_pasta" -gt "${#subpastas[@]}" ]; then
		echo "Opção inválida."
		return 1
	fi

	PLATAFORMA="${subpastas[$((escolha_pasta - 1))]}"
	DIRETORIO_ROMS="$ROM_BASE_DIR/$PLATAFORMA"

	# 3. Mapeamento para os seus cores específicos
	case "${PLATAFORMA,,}" in
	snes | super-nintendo | supernintendo)
		CORE_LIB="$DEFAULT_CORE_DIR/snes9x_libretro.so"
		;;
	n64 | nintendo64)
		CORE_LIB="$DEFAULT_CORE_DIR/mupen64plus_next_libretro.so"
		;;
	psx | ps1 | playstation)
		CORE_LIB="$DEFAULT_CORE_DIR/mednafen_psx_libretro.so"
		;;
	gba | gameboy-advance)
		CORE_LIB="$DEFAULT_CORE_DIR/mgba_libretro.so"
		;;
	*)
		echo "Core não configurado automaticamente para '$PLATAFORMA'."
		read -p "Digite o nome exato do arquivo .so (ex: snes9x_libretro.so): " core_manual
		CORE_LIB="$DEFAULT_CORE_DIR/$core_manual"
		;;
	esac

	if [ ! -f "$CORE_LIB" ]; then
		echo "Erro: Core não encontrado em: $CORE_LIB"
		exit 1
	fi

	# 4. Lista as ROMs (suportando arquivos soltos ou organizados em subpastas por jogo)
	clear
	echo "=== ROMs disponíveis em: ${PLATAFORMA^^} ==="
	echo "Core selecionado: $(basename "$CORE_LIB")"
	echo

	# Procura arquivos principais (.cue, .chd, .m3u, etc.) tanto na raiz quanto dentro de pastas de cada jogo
	mapfile -t roms < <(find "$DIRETORIO_ROMS" -type f \( -name "*.zip" -o -name "*.sfc" -o -name "*.smc" -o -name "*.z64" -o -name "*.n64" -o -name "*.cue" -o -name "*.chd" -o -name "*.m3u" -o -name "*.gba" -o -name "*.bin" \) | sort)

	if [ ${#roms[@]} -eq 0 ]; then
		echo "Nenhuma ROM encontrada em '$DIRETORIO_ROMS'."
		exit 1
	fi

	for i in "${!roms[@]}"; do
		# Se o arquivo estiver dentro de uma subpasta (ex: PSX/Crash/Crash.cue), 
		# mostra o nome da pasta do jogo ou do arquivo para facilitar a leitura.
		caminho_relativo="${roms[$i]#$DIRETORIO_ROMS/}"
		echo "  [$((i + 1))] $caminho_relativo"
	done

	echo
	read -p "Escolha o número da ROM que deseja jogar: " escolha_rom

	if ! [[ "$escolha_rom" =~ ^[0-9]+$ ]] || [ "$escolha_rom" -lt 1 ] || [ "$escolha_rom" -gt "${#roms[@]}" ]; then
		echo "Opção inválida."
		return 1
	fi

	ROM_SELECIONADA="${roms[$((escolha_rom - 1))]}"

	# 5. Execução do RetroArch
	echo
	echo "Executando: retroarch -f -L $CORE_LIB \"$ROM_SELECIONADA\""
	retroarch -f -L "$CORE_LIB" "$ROM_SELECIONADA" > /dev/null 2>&1
	exit 1
}