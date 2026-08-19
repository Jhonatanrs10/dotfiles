#!/usr/bin/env bash

source $HOME/.config/jrs/jrs-scripts-themes.sh

# 1. Função TUI Nova
select_theme_with_tui() {
    clear
    local theme_names=()
    readarray -t theme_names < <(declare -A | grep -oP 'declare -A \Ktheme_[^=]*' | sort)

    if [ ${#theme_names[@]} -eq 0 ]; then
        echo "❌ Nenhum tema encontrado!"
        selected_theme="theme_0_dark"
        return 1
    fi

    local display_names=()
    local i=1
    for theme_var in "${theme_names[@]}"; do
        eval "local d_name=\${${theme_var}[name]:-}"
        if [[ -z "$d_name" ]]; then
            local raw_name="${theme_var/theme_/}"
            d_name="$(echo "${raw_name^}" | tr '_' ' ')"
        fi
        display_names+=("$d_name")
        echo "[$i] $d_name"
        ((i++))
    done

    read -r chosen_input

    if [[ -z "$chosen_input" ]]; then
        echo "❌ Nenhuma opção digitada. Usando tema padrão."
        selected_theme="theme_0_dark"
        return 1
    fi

    if [[ "$chosen_input" =~ ^[0-9]+$ ]] && [ "$chosen_input" -ge 1 ] && [ "$chosen_input" -le "${#theme_names[@]}" ]; then
        local idx=$((chosen_input - 1))
        selected_theme="${theme_names[$idx]}"
    else
        local found=0
        for idx in "${!display_names[@]}"; do
            if [[ "${display_names[$idx]}" == "$chosen_input" ]]; then
                selected_theme="${theme_names[$idx]}"
                found=1
                break
            fi
        done

        if [ $found -eq 0 ]; then
            echo "❌ '$chosen_input' não é uma opção válida."
            selected_theme="theme_0_dark"
            return 1
        fi
    fi
}

# 2. Sua Função TUI Antiga (Se quiser alternar)
select_theme_old_tui() {
    clear
    echo "Sua interface TUI antiga executa aqui..."
    selected_theme="theme_0_dark"
}

# --- LÓGICA PRINCIPAL DO ARQUIVO A ---

if [ -f "$HOME/.config/hypr/colors.conf" ]; then
    echo "COLORS EXISTE"
    select_theme_with_tui  # Chama a TUI para preencher a variável $selected_theme
else
    echo "COLORS NÃO EXISTE"
    selected_theme="theme_0_dark"
fi

# Carrega o arquivo da engine com a função apply_theme
source "$HOME/.config/jrs/jrs-scripts-set-theme.sh"

# Executa a aplicação do tema escolhido
apply_theme