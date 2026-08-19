#!/usr/bin/env bash

# Carrega os dicionários de temas
source "$HOME/.config/jrs/jrs-scripts-themes.sh"

select_theme_with_rofi() {
    local theme_name display_name
    local theme_names
    readarray -t theme_names < <(declare -A | grep -oP 'declare -A \Ktheme_[^=]*' | sort)
    
    local display_names_output=""
    local display_names_and_variables=""
    
    for theme_name in "${theme_names[@]}"; do
        eval "display_name=\${${theme_name}[name]:-}"
        if [[ -z "$display_name" ]]; then
            local raw_name="${theme_name/theme_/}"
            display_name="$(echo "${raw_name^}" | tr '_' ' ')"
        fi
        display_names_output+="$display_name\n"
        display_names_and_variables+="$display_name|$theme_name\n"
    done

    # Remove o último \n extra
    display_names_output=$(echo -e -n "$display_names_output")

    local menu_cmd="rofi -dmenu -i -p Themes"
    local chosen_name
    chosen_name=$(echo -e "$display_names_output" | $menu_cmd)

    if [ -n "$chosen_name" ]; then
        if echo -e "$display_names_output" | grep -F -x -q "$chosen_name"; then
            echo "✅ '$chosen_name' é uma opção válida."
            selected_theme=$(echo -e "$display_names_and_variables" | grep -F "$chosen_name" | head -n 1 | cut -d'|' -f2 | tr -d '[:space:]')
        else
            echo "❌ '$chosen_name' não é uma opção válida. Usando tema padrão."
            selected_theme="theme_0_dark"
        fi
    else
        echo "❌ Seleção cancelada. Usando tema padrão."
        selected_theme="theme_0_dark"
    fi
}

# --- LÓGICA DE EXECUÇÃO ---

if [ -f "$HOME/.config/hypr/colors.conf" ]; then
    echo "COLORS EXISTE"
    select_theme_with_rofi
else
    echo "COLORS NÃO EXISTE"
    selected_theme="theme_0_dark"
fi

# Carrega o arquivo da engine com a função apply_theme
source "$HOME/.config/jrs/jrs-scripts-set-theme.sh"

# Aplica as configurações do tema selecionado
apply_theme