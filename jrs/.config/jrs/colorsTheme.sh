#!/bin/bash

# --- Configurações ---
# O arquivo onde o script salva o nome do último tema usado
THEME_STATE_FILE="$HOME/.cache/theme_state"

# --- Definição dos Temas ---

declare -A theme_Archlinux
theme_Archlinux[main]="1793d1"
theme_Archlinux[bar]="333333"
theme_Archlinux[text]="ffffff"
theme_Archlinux[unfocused]="7d7d7d"
theme_Archlinux[bad]="900000"
theme_Archlinux[degraded]="a08000"
theme_Archlinux[white]="ffffff"
theme_Archlinux[black]="000000"
theme_Archlinux[wallpaper]="w.png"

declare -A theme_Sakura 
theme_Sakura[main]="D37CAF"
theme_Sakura[bar]="0A0F2D"
theme_Sakura[text]="FEEBEE"
theme_Sakura[unfocused]="FCD6E2"
theme_Sakura[bad]="900000"
theme_Sakura[degraded]="a08000"
theme_Sakura[white]="ffffff"
theme_Sakura[black]="000000"
theme_Sakura[wallpaper]="w1.png"

declare -A theme_Gentoo 
theme_Gentoo[main]="6E56AF"
theme_Gentoo[bar]="3B3F57"
theme_Gentoo[text]="F7F8FC"
theme_Gentoo[unfocused]="604878"
theme_Gentoo[bad]="900000"
theme_Gentoo[degraded]="a08000"
theme_Gentoo[white]="ffffff"
theme_Gentoo[black]="000000"
theme_Gentoo[wallpaper]="w2.png"

declare -A theme_Window11Gray 
theme_Window11Gray[main]="6F8AA5"
theme_Window11Gray[bar]="151A21"
theme_Window11Gray[text]="DFDFDF"
theme_Window11Gray[unfocused]="2E4760"
theme_Window11Gray[bad]="900000"
theme_Window11Gray[degraded]="a08000"
theme_Window11Gray[white]="ffffff"
theme_Window11Gray[black]="000000"
theme_Window11Gray[wallpaper]="w3.png"

declare -A theme_DSlayer
theme_DSlayer[main]="eba825"
theme_DSlayer[bar]="010409"
theme_DSlayer[text]="DFDFDF"
theme_DSlayer[unfocused]="1361c2"
theme_DSlayer[bad]="900000"
theme_DSlayer[degraded]="a08000"
theme_DSlayer[white]="ffffff"
theme_DSlayer[black]="000000"
theme_DSlayer[wallpaper]="w4.png"

# --- Lógica de Alternância ---

# Lista todos os temas disponíveis, na ordem em que devem ser alternados
themes=("theme_Archlinux" "theme_Sakura" "theme_Gentoo" "theme_Window11Gray" "theme_DSlayer")

# Lógica para encontrar o próximo tema
# Se o arquivo de estado existe, pega o nome do último tema
if [[ -f "$THEME_STATE_FILE" ]]; then
    current_theme_name=$(cat "$THEME_STATE_FILE")
else
    # Caso contrário, começa com o primeiro tema da lista
    current_theme_name="${themes[0]}"
fi

# Encontra o índice do tema atual na lista
current_index=-1
for i in "${!themes[@]}"; do
   if [[ "${themes[$i]}" == "$current_theme_name" ]]; then
       current_index=$i
       break
   fi
done

# Calcula o índice do próximo tema no ciclo
# Se o tema atual não for encontrado, usa 0
next_index=$(( (current_index + 1) % ${#themes[@]} ))
next_theme_name="${themes[$next_index]}"

# Salva o nome do próximo tema no arquivo de estado para a próxima vez
echo "$next_theme_name" > "$THEME_STATE_FILE"

# --- Aplicação das Variáveis ---

# Cria uma referência para o tema que será aplicado
declare -n chosen_theme="$next_theme_name"

# Atribui os valores do tema escolhido às variáveis JRS_*
JRS_MAIN_COLOR="${chosen_theme[main]}"
JRS_BAR_COLOR="${chosen_theme[bar]}"
JRS_TEXT_COLOR="${chosen_theme[text]}"
JRS_UNFOCUSED_COLOR="${chosen_theme[unfocused]}"
JRS_BAD_COLOR="${chosen_theme[bad]}"
JRS_DEGRADED_COLOR="${chosen_theme[degraded]}"
JRS_WHITE_COLOR="${chosen_theme[white]}"
JRS_BLACK_COLOR="${chosen_theme[black]}"
JRS_WALLPAPER="${chosen_theme[wallpaper]}"
