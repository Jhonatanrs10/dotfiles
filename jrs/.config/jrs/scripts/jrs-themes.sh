#!/bin/bash

source $HOME/.config/jrs/lib/jrs-functions.sh

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
theme_AnimeVibe[main]="008da9"
theme_AnimeVibe[bar]="333333"
theme_AnimeVibe[text]="ffffff"
theme_AnimeVibe[unfocused]="7d7d7d"
theme_AnimeVibe[bad]="900000"
theme_AnimeVibe[degraded]="a08000"
theme_AnimeVibe[white]="ffffff"
theme_AnimeVibe[black]="000000"
theme_AnimeVibe[wallpaper]="w8.png"

declare -A theme_SasamiGreen
theme_SasamiGreen[main]="329940"
theme_SasamiGreen[bar]="333333"
theme_SasamiGreen[text]="ffffff"
theme_SasamiGreen[unfocused]="7d7d7d"
theme_SasamiGreen[bad]="900000"
theme_SasamiGreen[degraded]="a08000"
theme_SasamiGreen[white]="ffffff"
theme_SasamiGreen[black]="000000"
theme_SasamiGreen[wallpaper]="w9.png"

# Rofi Theme
rofiTheme(){
    
    # 1. Definição Simplificada e ORDENADA:
    # Formato: "Nome Amigável | Nome_do_Arquivo"
    # Adicione ou remova linhas aqui na ordem exata que você deseja.
    local theme_list=$(cat <<EOF
Archlinux      |    theme_Archlinux
Sakura Tree    |    theme_Sakura
Sasami Green   |    theme_SasamiGreen
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
    
    menu_cmd="rofi -dmenu -i -p Themes"

    # 4. Mostrar menu e obter seleção do usuário (Nome Amigável)
    local chosen_name=$(echo -e "$options" | $menu_cmd)

    # 5. Mapear o Nome Amigável de volta para o Nome do Arquivo
    if [ -n "$chosen_name" ]; then

        varNomeTema=$(echo "$chosen_name")
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


###########################################################################################


# Hyprpaper setup
echo "reload = ~/.config/wallpapers/$JRS_WALLPAPER
wallpaper = , ~/.config/wallpapers/$JRS_WALLPAPER" > ~/.config/hypr/hyprpaper.conf

echo "hyprctl hyprpaper preload ~/.config/wallpapers/$JRS_WALLPAPER
hyprctl hyprpaper wallpaper , ~/.config/wallpapers/$JRS_WALLPAPER" > ~/.config/hypr/hyprpaper.sh

# Hyprland colors setup
echo '$wallpaper = '$JRS_WALLPAPER'
$color1 = '$JRS_MAIN_COLOR'
$color2 = '$JRS_BAR_COLOR'
$color3 = '$JRS_TEXT_COLOR'
$color4 = '$JRS_UNFOCUSED_COLOR'
$color5 = '$JRS_BLACK_COLOR'
$color6 = '$JRS_BLACK_COLOR'
$color7 = '$JRS_BLACK_COLOR'' > ~/.config/hypr/colors.conf

# Wofi colors setup
echo "@define-color base00 #$JRS_MAIN_COLOR;
@define-color base01 #$JRS_BAR_COLOR;
@define-color base02 #$JRS_TEXT_COLOR;
@define-color base03 #$JRS_UNFOCUSED_COLOR;
@define-color base04 #$JRS_BAD_COLOR;
@define-color base05 #$JRS_DEGRADED_COLOR;
@define-color base06 #$JRS_WHITE_COLOR;
@define-color base07 #$JRS_BLACK_COLOR;" > ~/.config/wofi/colors.css

# Waybar colors setup
echo "@define-color base00 #$JRS_MAIN_COLOR;
@define-color base01 #$JRS_BAR_COLOR;
@define-color base02 #$JRS_TEXT_COLOR;
@define-color base03 #$JRS_UNFOCUSED_COLOR;
@define-color base04 #$JRS_BAD_COLOR;
@define-color base05 #$JRS_DEGRADED_COLOR;
@define-color base06 #$JRS_WHITE_COLOR;
@define-color base07 #$JRS_BLACK_COLOR;" > ~/.config/waybar/colors.css

# Polybar colors setup
echo "[colors]
base00 = #$JRS_MAIN_COLOR
base01 = #99$JRS_BAR_COLOR
base02 = #$JRS_TEXT_COLOR
base03 = #$JRS_UNFOCUSED_COLOR
base04 = #$JRS_BAD_COLOR
base05 = #$JRS_DEGRADED_COLOR
base06 = #$JRS_WHITE_COLOR
base07 = #$JRS_BLACK_COLOR" > ~/.config/polybar/colors.ini

# Rofi colors setup
echo "* {
    base00: #$JRS_MAIN_COLOR;
    base01: #$JRS_BAR_COLOR;
    base02: #$JRS_TEXT_COLOR;
    base03: #$JRS_UNFOCUSED_COLOR;
    base04: #$JRS_BAD_COLOR;
    base05: #$JRS_DEGRADED_COLOR;
    base06: #$JRS_WHITE_COLOR;
    base07: #$JRS_BLACK_COLOR;
}" > ~/.config/rofi/colors.rasi

# i3wm colors setup
echo 'exec_always --no-startup-id feh --bg-fill ~/.config/wallpapers/'$JRS_WALLPAPER'
set $color1 #'$JRS_MAIN_COLOR'
set $color2 #'$JRS_BAR_COLOR'
set $color3 #'$JRS_TEXT_COLOR'
set $color4 #'$JRS_UNFOCUSED_COLOR'
set $color5 #'$JRS_BLACK_COLOR'
set $color6 #'$JRS_BLACK_COLOR'
set $color7 #'$JRS_BLACK_COLOR'

#class                  borda       background  texto         indicator   child_border
client.focused          $color1 $color1 $color3 $color1 $color1
client.focused_inactive $color1 $color4 $color2 $color4 $color4
client.unfocused        $color4 $color4 $color2 $color4 $color4
client.urgent           $color7 $color5 $color3 $color5 $color5
client.placeholder      $color6 $color6 $color3 $color6 $color6
client.background       $color3
' > ~/.config/i3/colors

# Bspwm colors setup
echo 'wallpaper="'$JRS_WALLPAPER'"
base00="#'$JRS_MAIN_COLOR'"
base01="#'$JRS_BAR_COLOR'"
base02="#'$JRS_TEXT_COLOR'"
base03="#'$JRS_UNFOCUSED_COLOR'"
base04="#'$JRS_BAD_COLOR'"
base05="#'$JRS_DEGRADED_COLOR'"
base06="#'$JRS_WHITE_COLOR'"
base07="#'$JRS_BLACK_COLOR'"' > $HOME/.config/bspwm/colors.sh

# NVIM colors setup
echo '-- Função auxiliar para definir destaques
local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
end

-- Limpa os destaques padrão
vim.cmd("hi clear")
if vim.fn.exists("syntax_on") then
    vim.cmd("syntax reset")
end

vim.o.background = "dark"

-- Implementação dos destaques
hi("Normal", { bg = "#'$JRS_BAR_COLOR'" })
hi("NormalNC", { bg = "#'$JRS_BAR_COLOR'" })
hi("EndOfBuffer", { bg = "#'$JRS_BAR_COLOR'" })
hi("TabLine", { fg = "#'$JRS_TEXT_COLOR'", bg = "#'$JRS_BAR_COLOR'", ctermfg = 244, ctermbg = 236 })
hi("TabLineSel", { fg = "#'$JRS_BAR_COLOR'", bg = "#'$JRS_TEXT_COLOR'", ctermfg = 231, ctermbg = 240, bold = true })
hi("TabLineFill", { fg = "NONE", bg = "#'$JRS_BAR_COLOR'", ctermfg = "NONE", ctermbg = 235 })
hi("CursorLine", { bg = "#222222" })
hi("VertSplit", { fg = "#'$JRS_TEXT_COLOR'", bg = "#'$JRS_BAR_COLOR'" })
hi("StatusLine", { fg = "#'$JRS_BAR_COLOR'", bg = "#'$JRS_TEXT_COLOR'", bold = true })
hi("StatusLineNC", { fg = "#'$JRS_BAR_COLOR'", bg = "#'$JRS_TEXT_COLOR'" })
hi("Comment", { fg = "#57a64a", italic = true })
hi("String", { fg = "#CE9178" })
hi("Keyword", { fg = "#C586C0", bold = true })' > $HOME/.config/nvim/colors/colors.lua

# Kitty colors setup
echo "background #$JRS_BAR_COLOR
foreground #$JRS_TEXT_COLOR
selection_foreground #000000
selection_background #cccccc
background_opacity 0.90" > $HOME/.config/kitty/colors.conf

# Alacritty colors setup
echo "[colors]
    draw_bold_text_with_bright_colors = true
[colors.primary]
    background = '#$JRS_BAR_COLOR'
    foreground = '#$JRS_TEXT_COLOR'" > $HOME/.config/alacritty/colors.toml

# Dunst colors setup
echo '#!/bin/bash
[global]
    frame_color = "#'$JRS_MAIN_COLOR'"
[urgency_low]
    background = "#'$JRS_BAR_COLOR'aa"
    foreground = "#'$JRS_TEXT_COLOR'"
[urgency_normal]
    background = "#'$JRS_BAR_COLOR'aa"
    foreground = "#'$JRS_TEXT_COLOR'"
[urgency_critical]
    background = "#'$JRS_BAR_COLOR'aa"
    foreground = "#'$JRS_TEXT_COLOR'"
    frame_color = "#'$JRS_BAD_COLOR'"' > $HOME/.config/dunst/dunstrc.d/colors.conf

reload-all-wm

#dunstify -t 1000 --hints int:transient:1 "Theme" "$varNomeTema" --icon=preferences-desktop-theme

