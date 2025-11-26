#!/bin/bash

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

# Rofi Theme
rofiTheme(){
    
    options="Archlinux
Sakura Tree
Gento Anime
Mountain
Halloween
Green Place
One Piece Red
Teste"

    # Detect session type and choose appropriate menu
    if [ "$XDG_SESSION_TYPE" = "x11" ] && command -v rofi &>/dev/null; then
    menu_cmd="rofi -dmenu -i -p Themes"
    elif [ "$XDG_SESSION_TYPE" = "wayland" ] && command -v wofi &>/dev/null; then
    #menu_cmd="wofi --dmenu --prompt=Options"
    menu_cmd="rofi -dmenu -i -p Themes"
    else
    echo "ERROR: No suitable menu found" >&2
    exit 1
    fi

    # Show menu and get user selection
    chosen=$(echo -e "$options" | $menu_cmd)

    # Execute chosen action
    case "$chosen" in
    "Archlinux")varTema="theme_Archlinux";;
    "Sakura Tree")varTema="theme_Sakura";;
    "Gento Anime")varTema="theme_Gentoo";;
    "Mountain")varTema="theme_Mountain";;
    "Halloween")varTema="theme_HalloweenBoy";;
    "Green Place")varTema="theme_GreenPlace";;
    "One Piece Red")varTema="theme_Red";;
    "Teste")varTema="theme_teste";;
    *) exit 1 ;;
    esac
    
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
