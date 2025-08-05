#!/bin/bash

# --- Configurações ---
# O arquivo onde o script salva o nome do último tema usado
THEME_STATE_FILE="$HOME/.cache/theme_state"

# --- Definição dos Temas ---

# Tema Default
declare -A default_theme
default_theme[main]="1793d1"
default_theme[bar]="333333"
default_theme[text]="ffffff"
default_theme[unfocused]="7d7d7d"
default_theme[bad]="900000"
default_theme[degraded]="a08000"
default_theme[white]="ffffff"
default_theme[black]="000000"

# Tema Sakura
declare -A theme01 
theme01[main]="D37CAF"
theme01[bar]="0A0F2D"
theme01[text]="FEEBEE"
theme01[unfocused]="FCD6E2"
theme01[bad]="900000"
theme01[degraded]="a08000"
theme01[white]="ffffff"
theme01[black]="000000"

# Tema Root
declare -A theme02 
theme02[main]="97FF4B"
theme02[bar]="192028"
theme02[text]="C5C6CA"
theme02[unfocused]="4F575A"
theme02[bad]="900000"
theme02[degraded]="a08000"
theme02[white]="ffffff"
theme02[black]="000000"


# --- Lógica de Alternância ---

# Lista todos os temas disponíveis, na ordem em que devem ser alternados
themes=("default_theme" "theme01" "theme02")

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

