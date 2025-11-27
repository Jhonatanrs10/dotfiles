#!/bin/bash

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

declare -A theme_Mountain 
theme_Mountain[main]="6F8AA5"
theme_Mountain[bar]="151A21"
theme_Mountain[text]="DFDFDF"
theme_Mountain[unfocused]="2E4760"
theme_Mountain[bad]="900000"
theme_Mountain[degraded]="a08000"
theme_Mountain[white]="ffffff"
theme_Mountain[black]="000000"
theme_Mountain[wallpaper]="w3.png"

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
theme_Red[main]="c10b0b"
theme_Red[bar]="333333"
theme_Red[text]="ffffff"
theme_Red[unfocused]="7d7d7d"
theme_Red[bad]="900000"
theme_Red[degraded]="a08000"
theme_Red[white]="ffffff"
theme_Red[black]="000000"
theme_Red[wallpaper]="w6.png"

declare -A theme_RedBerserk
theme_RedBerserk[main]="c10b0b"
theme_RedBerserk[bar]="333333"
theme_RedBerserk[text]="ffffff"
theme_RedBerserk[unfocused]="7d7d7d"
theme_RedBerserk[bad]="900000"
theme_RedBerserk[degraded]="a08000"
theme_RedBerserk[white]="ffffff"
theme_RedBerserk[black]="000000"
theme_RedBerserk[wallpaper]="w7.png"

declare -A theme_AnimeVibe
theme_AnimeVibe[main]="1793d1"
theme_AnimeVibe[bar]="333333"
theme_AnimeVibe[text]="ffffff"
theme_AnimeVibe[unfocused]="7d7d7d"
theme_AnimeVibe[bad]="900000"
theme_AnimeVibe[degraded]="a08000"
theme_AnimeVibe[white]="ffffff"
theme_AnimeVibe[black]="000000"
theme_AnimeVibe[wallpaper]="w8.png"

# Rofi Theme
rofiTheme(){
    
    # 1. Definição Simplificada e ORDENADA:
    # Formato: "Nome Amigável | Nome_do_Arquivo"
    # Adicione ou remova linhas aqui na ordem exata que você deseja.
    local theme_list=$(cat <<EOF
Archlinux      |    theme_Archlinux
Sakura Tree    |    theme_Sakura
Gento Anime    |    theme_Gentoo
Mountain       |    theme_Mountain
Halloween      |    theme_HalloweenBoy
Green Place    |    theme_GreenPlace
Luffy Red      |    theme_Red
Berserk Red    |    theme_RedBerserk
Old Anime      |    theme_AnimeVibe
EOF
)

    # 2. Gerar a string de opções (apenas o Nome Amigável)
    local options=$(echo "$theme_list" | cut -d'|' -f1)

    # 3. Detectar sessão e escolher o menu
    local menu_cmd=""
    if [ "$XDG_SESSION_TYPE" = "x11" ] && command -v rofi &>/dev/null; then
        menu_cmd="rofi -dmenu -i -p Themes"
    elif [ "$XDG_SESSION_TYPE" = "wayland" ] && command -v rofi &>/dev/null; then
        menu_cmd="rofi -dmenu -i -p Themes"
    else
        echo "ERRO: Nenhuma ferramenta de menu adequada encontrada." >&2
        exit 1
    fi

    # 4. Mostrar menu e obter seleção do usuário (Nome Amigável)
    local chosen_name=$(echo -e "$options" | $menu_cmd)

    # 5. Mapear o Nome Amigável de volta para o Nome do Arquivo
    if [ -n "$chosen_name" ]; then
        # Encontra a linha completa usando o nome escolhido
        local full_line=$(echo "$theme_list" | grep -F "$chosen_name" | head -n 1)
        
        # Extrai o Nome do Arquivo (segundo campo após o separador '|')
        # Usamos 'tr' para remover espaços em branco extras antes de atribuir
        varTema=$(echo "$full_line" | cut -d'|' -f2 | tr -d '[:space:]')
        
    else
        varTema=""
        exit 1
    fi
    
}

rofiTheme

declare -n chosen_theme="$varTema"

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
