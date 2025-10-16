#!/bin/bash

# --- Configurações ---
# O arquivo onde o script salva o nome do último tema usado
THEME_STATE_FILE="$HOME/.cache/theme_state"

# --- Definição dos Temas ---

declare -A theme_teste
theme_teste[main]="1793d1"
theme_teste[bar]="333333"
theme_teste[text]="ffffff"
theme_teste[unfocused]="7d7d7d"
theme_teste[bad]="900000"
theme_teste[degraded]="a08000"
theme_teste[white]="ffffff"
theme_teste[black]="000000"
theme_teste[wallpaper]="teste.png"

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

declare -A theme_Windows11Gray 
theme_Windows11Gray[main]="6F8AA5"
theme_Windows11Gray[bar]="151A21"
theme_Windows11Gray[text]="DFDFDF"
theme_Windows11Gray[unfocused]="2E4760"
theme_Windows11Gray[bad]="900000"
theme_Windows11Gray[degraded]="a08000"
theme_Windows11Gray[white]="ffffff"
theme_Windows11Gray[black]="000000"
theme_Windows11Gray[wallpaper]="w3.png"

declare -A theme_HalloweenBoy
theme_HalloweenBoy[main]="DA7038"
theme_HalloweenBoy[bar]="333333"
theme_HalloweenBoy[text]="ffffff"
theme_HalloweenBoy[unfocused]="7d7d7d"
theme_HalloweenBoy[bad]="900000"
theme_HalloweenBoy[degraded]="a08000"
theme_HalloweenBoy[white]="ffffff"
theme_HalloweenBoy[black]="000000"
theme_HalloweenBoy[wallpaper]="w4.png"

declare -A theme_GreenPlace
theme_GreenPlace[main]="599E71"
theme_GreenPlace[bar]="333333"
theme_GreenPlace[text]="ffffff"
theme_GreenPlace[unfocused]="7d7d7d"
theme_GreenPlace[bad]="900000"
theme_GreenPlace[degraded]="a08000"
theme_GreenPlace[white]="ffffff"
theme_GreenPlace[black]="000000"
theme_GreenPlace[wallpaper]="w5.png"

declare -A theme_Red
theme_Red[main]="ffffff"
theme_Red[bar]="000000"
theme_Red[text]="ffffff"
theme_Red[unfocused]="7d7d7d"
theme_Red[bad]="900000"
theme_Red[degraded]="a08000"
theme_Red[white]="ffffff"
theme_Red[black]="000000"
theme_Red[wallpaper]="w6.png"

# --- Lógica de Alternância ---

# Lista todos os temas disponíveis, na ordem em que devem ser alternados
themes=("theme_Archlinux" "theme_Sakura" "theme_Gentoo" "theme_Windows11Gray" "theme_HalloweenBoy" "theme_GreenPlace" "theme_Red")

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
