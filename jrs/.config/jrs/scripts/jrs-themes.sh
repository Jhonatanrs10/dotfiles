#!/bin/bash

# --- Definição dos Temas ---

declare -A theme_archlinux
theme_archlinux[main]="1793d1"
theme_archlinux[bar]="333333"
theme_archlinux[bar_opacity]="0.60"
theme_archlinux[text]="ffffff"
theme_archlinux[unfocused]="7d7d7d"
theme_archlinux[bad]="900000"
theme_archlinux[degraded]="a08000"
theme_archlinux[white]="ffffff"
theme_archlinux[black]="000000"
theme_archlinux[wallpaper]="archlinux.png"

declare -A theme_focus
theme_focus[main]="7d7d7d"
theme_focus[bar]="1E1E1E"
theme_focus[bar_opacity]="0"
theme_focus[text]="ffffff"
theme_focus[unfocused]="313131"
theme_focus[bad]="900000"
theme_focus[degraded]="a08000"
theme_focus[white]="ffffff"
theme_focus[black]="000000"
theme_focus[wallpaper]="focus.png"

declare -A theme_red
theme_red[main]="c10b0b"
theme_red[bar]="333333"
theme_red[bar_opacity]="0.60"
theme_red[text]="ffffff"
theme_red[unfocused]="7d7d7d"
theme_red[bad]="900000"
theme_red[degraded]="a08000"
theme_red[white]="ffffff"
theme_red[black]="000000"
theme_red[wallpaper]="red.png"

declare -A theme_green
theme_green[main]="329940"
theme_green[bar]="333333"
theme_green[bar_opacity]="0.60"
theme_green[text]="ffffff"
theme_green[unfocused]="7d7d7d"
theme_green[bad]="900000"
theme_green[degraded]="a08000"
theme_green[white]="ffffff"
theme_green[black]="000000"
theme_green[wallpaper]="green.png"

declare -A theme_pink
theme_pink[main]="D37CAF"
theme_pink[bar]="0A0F2D"
theme_pink[bar_opacity]="0.60"
theme_pink[text]="FEEBEE"
theme_pink[unfocused]="FCD6E2"
theme_pink[bad]="900000"
theme_pink[degraded]="a08000"
theme_pink[white]="ffffff"
theme_pink[black]="000000"
theme_pink[wallpaper]="pink.png"

declare -A theme_rgb
theme_rgb[main]="0BE0F7"
theme_rgb[bar]="333333"
theme_rgb[bar_opacity]="0.60"
theme_rgb[text]="ffffff"
theme_rgb[unfocused]="7d7d7d"
theme_rgb[bad]="900000"
theme_rgb[degraded]="a08000"
theme_rgb[white]="ffffff"
theme_rgb[black]="000000"
theme_rgb[wallpaper]="rgb.png"

declare -A theme_gentoo
theme_gentoo[main]="6E56AF"
theme_gentoo[bar]="3B3F57"
theme_gentoo[bar_opacity]="0.60"
theme_gentoo[text]="F7F8FC"
theme_gentoo[unfocused]="604878"
theme_gentoo[bad]="900000"
theme_gentoo[degraded]="a08000"
theme_gentoo[white]="ffffff"
theme_gentoo[black]="000000"
theme_gentoo[wallpaper]="gentoo.png"

declare -A theme_mountain
theme_mountain[main]="6F8AA5"
theme_mountain[bar]="151A21"
theme_mountain[bar_opacity]="0.60"
theme_mountain[text]="DFDFDF"
theme_mountain[unfocused]="2E4760"
theme_mountain[bad]="900000"
theme_mountain[degraded]="a08000"
theme_mountain[white]="ffffff"
theme_mountain[black]="000000"
theme_mountain[wallpaper]="mountain.png"

declare -A theme_halloween_boy
theme_halloween_boy[main]="DA7038"
theme_halloween_boy[bar]="333333"
theme_halloween_boy[bar_opacity]="0.60"
theme_halloween_boy[text]="ffffff"
theme_halloween_boy[unfocused]="7d7d7d"
theme_halloween_boy[bad]="900000"
theme_halloween_boy[degraded]="a08000"
theme_halloween_boy[white]="ffffff"
theme_halloween_boy[black]="000000"
theme_halloween_boy[wallpaper]="halloween-boy.png"

declare -A theme_minimalist_green
theme_minimalist_green[main]="599E71"
theme_minimalist_green[bar]="333333"
theme_minimalist_green[bar_opacity]="0.60"
theme_minimalist_green[text]="ffffff"
theme_minimalist_green[unfocused]="7d7d7d"
theme_minimalist_green[bad]="900000"
theme_minimalist_green[degraded]="a08000"
theme_minimalist_green[white]="ffffff"
theme_minimalist_green[black]="000000"
theme_minimalist_green[wallpaper]="minimalist-green.png"

declare -A theme_old_anime
theme_old_anime[main]="008da9"
theme_old_anime[bar]="333333"
theme_old_anime[bar_opacity]="0.60"
theme_old_anime[text]="ffffff"
theme_old_anime[unfocused]="7d7d7d"
theme_old_anime[bad]="900000"
theme_old_anime[degraded]="a08000"
theme_old_anime[white]="ffffff"
theme_old_anime[black]="000000"
theme_old_anime[wallpaper]="old-anime.png"

declare -A theme_vinland_saga
theme_vinland_saga[main]="3D2823"
theme_vinland_saga[bar]="333333"
theme_vinland_saga[bar_opacity]="0.60"
theme_vinland_saga[text]="ffffff"
theme_vinland_saga[unfocused]="7d7d7d"
theme_vinland_saga[bad]="900000"
theme_vinland_saga[degraded]="a08000"
theme_vinland_saga[white]="ffffff"
theme_vinland_saga[black]="000000"
theme_vinland_saga[wallpaper]="vinland-saga.png"

declare -A theme_gray
theme_gray[main]="7d7d7d"
theme_gray[bar]="1E1E1E"
theme_gray[bar_opacity]="0.60"
theme_gray[text]="ffffff"
theme_gray[unfocused]="313131"
theme_gray[bad]="900000"
theme_gray[degraded]="a08000"
theme_gray[white]="ffffff"
theme_gray[black]="000000"
theme_gray[wallpaper]="gray.png"

# Rofi Theme
rofiTheme() {

	# 1. Definição Simplificada e ORDENADA:
	# Formato: "Nome Amigável | Nome_do_Arquivo"
	# Adicione ou remova linhas aqui na ordem exata que você deseja.
	local theme_list=$(
		cat <<EOF
Archlinux           |    theme_archlinux
Focus               |    theme_focus
Red                 |    theme_red
Green               |    theme_green
Pink                |    theme_pink
RGB                 |    theme_rgb
Gento Anime         |    theme_gentoo
Mountain            |    theme_mountain
Halloween Boy       |    theme_halloween_boy
Minimalist Green    |    theme_minimalist_green
Old Anime           |    theme_old_anime
Vinland Saga        |    theme_vinland_saga
Minimalist Gray     |    theme_gray
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
#declare -n chosen_theme="theme_archlinux"

# Atribui os valores do tema escolhido às variáveis JRS_*
JRS_MAIN_COLOR="${chosen_theme[main]}"
JRS_BAR_COLOR="${chosen_theme[bar]}"
JRS_BAR_OPACITY="${chosen_theme[bar_opacity]}"
JRS_TEXT_COLOR="${chosen_theme[text]}"
JRS_UNFOCUSED_COLOR="${chosen_theme[unfocused]}"
JRS_BAD_COLOR="${chosen_theme[bad]}"
JRS_DEGRADED_COLOR="${chosen_theme[degraded]}"
JRS_WHITE_COLOR="${chosen_theme[white]}"
JRS_BLACK_COLOR="${chosen_theme[black]}"
JRS_WALLPAPER="${chosen_theme[wallpaper]}"

case $JRS_BAR_OPACITY in
"0")
	JRS_WAYBAR_OPACITY="0.0"
	JRS_POLYBAR_OPACITY="00"
	;;
"1")
	JRS_WAYBAR_OPACITY="1.0"
	JRS_POLYBAR_OPACITY="FF"
	;;
*)
	JRS_WAYBAR_OPACITY="0.60"
	JRS_POLYBAR_OPACITY="99"
	;;
esac

###########################################################################################

# Hyprpaper setup
echo "reload = ~/.config/wallpapers/$JRS_WALLPAPER
wallpaper = , ~/.config/wallpapers/$JRS_WALLPAPER" >~/.config/hypr/hyprpaper.conf

echo "hyprctl hyprpaper preload ~/.config/wallpapers/$JRS_WALLPAPER
hyprctl hyprpaper wallpaper , ~/.config/wallpapers/$JRS_WALLPAPER" >~/.config/hypr/hyprpaper.sh

# Hyprland colors setup
echo '$wallpaper = '$JRS_WALLPAPER'
$color1 = '$JRS_MAIN_COLOR'
$color2 = '$JRS_BAR_COLOR'
$color3 = '$JRS_TEXT_COLOR'
$color4 = '$JRS_UNFOCUSED_COLOR'
$color5 = '$JRS_BLACK_COLOR'
$color6 = '$JRS_BLACK_COLOR'
$color7 = '$JRS_BLACK_COLOR'' >~/.config/hypr/colors.conf

# Wofi colors setup
echo "@define-color base00 #$JRS_MAIN_COLOR;
@define-color base01 #$JRS_BAR_COLOR;
@define-color base02 #$JRS_TEXT_COLOR;
@define-color base03 #$JRS_UNFOCUSED_COLOR;
@define-color base04 #$JRS_BAD_COLOR;
@define-color base05 #$JRS_DEGRADED_COLOR;
@define-color base06 #$JRS_WHITE_COLOR;
@define-color base07 #$JRS_BLACK_COLOR;" >~/.config/wofi/colors.css

# Waybar colors setup
echo "@define-color base00 #$JRS_MAIN_COLOR;
@define-color base01 #$JRS_BAR_COLOR;
@define-color base02 #$JRS_TEXT_COLOR;
@define-color base03 #$JRS_UNFOCUSED_COLOR;
@define-color base04 #$JRS_BAD_COLOR;
@define-color base05 #$JRS_DEGRADED_COLOR;
@define-color base06 #$JRS_WHITE_COLOR;
@define-color base07 #$JRS_BLACK_COLOR;

window#waybar:first-child > box {
    background-color: alpha(@base01, $JRS_WAYBAR_OPACITY);
}" >~/.config/waybar/colors.css

# Polybar colors setup
echo "[colors]
base00 = #$JRS_MAIN_COLOR
base01 = #$JRS_POLYBAR_OPACITY$JRS_BAR_COLOR
base02 = #$JRS_TEXT_COLOR
base03 = #$JRS_UNFOCUSED_COLOR
base04 = #$JRS_BAD_COLOR
base05 = #$JRS_DEGRADED_COLOR
base06 = #$JRS_WHITE_COLOR
base07 = #$JRS_BLACK_COLOR" >~/.config/polybar/colors.ini

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
}" >~/.config/rofi/colors.rasi

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
' >~/.config/i3/colors

# Bspwm colors setup
echo 'wallpaper="'$JRS_WALLPAPER'"
base00="#'$JRS_MAIN_COLOR'"
base01="#'$JRS_BAR_COLOR'"
base02="#'$JRS_TEXT_COLOR'"
base03="#'$JRS_UNFOCUSED_COLOR'"
base04="#'$JRS_BAD_COLOR'"
base05="#'$JRS_DEGRADED_COLOR'"
base06="#'$JRS_WHITE_COLOR'"
base07="#'$JRS_BLACK_COLOR'"' >$HOME/.config/bspwm/colors.sh

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
hi("Keyword", { fg = "#C586C0", bold = true })' >$HOME/.config/nvim/colors/colors.lua

# Kitty colors setup
echo "background #$JRS_BAR_COLOR
foreground #$JRS_TEXT_COLOR
selection_foreground #000000
selection_background #cccccc
background_opacity 0.90" >$HOME/.config/kitty/colors.conf

# Alacritty colors setup
echo "[colors]
    draw_bold_text_with_bright_colors = true
[colors.primary]
    background = '#$JRS_BAR_COLOR'
    foreground = '#$JRS_TEXT_COLOR'" >$HOME/.config/alacritty/colors.toml

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
    frame_color = "#'$JRS_BAD_COLOR'"' >$HOME/.config/dunst/dunstrc.d/colors.conf

# Btop colors setup
echo '# Theme: colors
# By: Jhonatanrs

# Main bg
theme[main_bg]="#'$JRS_BAR_COLOR$JRS_POLYBAR_OPACITY'"

# Main text color
theme[main_fg]="#'$JRS_TEXT_COLOR'"

# Title color for boxes
theme[title]="#'$JRS_TEXT_COLOR'"

# Highlight color for keyboard shortcuts
theme[hi_fg]="#'$JRS_MAIN_COLOR'"

# Background color of selected item in processes box
theme[selected_bg]="#'$JRS_MAIN_COLOR'"

# Foreground color of selected item in processes box
theme[selected_fg]="#'$JRS_TEXT_COLOR'"

# Color of inactive/disabled text
theme[inactive_fg]="#'$JRS_UNFOCUSED_COLOR'"

# Misc colors for processes box including mini cpu graphs, details memory graph and details status text
theme[proc_misc]="#7dcfff"

# Cpu box outline color
theme[cpu_box]="#'$JRS_MAIN_COLOR'"

# Memory/disks box outline color
theme[mem_box]="#'$JRS_MAIN_COLOR'"

# Net up/down box outline color
theme[net_box]="#'$JRS_MAIN_COLOR'"

# Processes box outline color
theme[proc_box]="#'$JRS_MAIN_COLOR'"

# Box divider line and small boxes line color
theme[div_line]="#'$JRS_MAIN_COLOR'"

# Temperature graph colors
theme[temp_start]="#'$JRS_MAIN_COLOR'"
theme[temp_mid]=""
theme[temp_end]="#'$JRS_BAR_COLOR'"

# CPU graph colors
theme[cpu_start]="#'$JRS_MAIN_COLOR'"
theme[cpu_mid]=""
theme[cpu_end]="#'$JRS_BAR_COLOR'"

# Mem/Disk free meter
theme[free_start]="#'$JRS_MAIN_COLOR'"
theme[free_mid]=""
theme[free_end]="#'$JRS_BAR_COLOR'"

# Mem/Disk cached meter
theme[cached_start]="#'$JRS_MAIN_COLOR'"
theme[cached_mid]=""
theme[cached_end]="#'$JRS_BAR_COLOR'"

# Mem/Disk available meter
theme[available_start]="#'$JRS_MAIN_COLOR'"
theme[available_mid]=""
theme[available_end]="#'$JRS_BAR_COLOR'"

# Mem/Disk used meter
theme[used_start]="#'$JRS_MAIN_COLOR'"
theme[used_mid]=""
theme[used_end]="#'$JRS_BAR_COLOR'"

# Download graph colors
theme[download_start]="#'$JRS_MAIN_COLOR'"
theme[download_mid]=""
theme[download_end]="#'$JRS_BAR_COLOR'"

# Upload graph colors
theme[upload_start]="#'$JRS_MAIN_COLOR'"
theme[upload_mid]=""
theme[upload_end]="#'$JRS_BAR_COLOR'"
' >$HOME/.config/btop/themes/colors.theme

source $HOME/.config/jrs/scripts/jrs-reload-wm.sh

#dunstify -t 1500 --hints int:transient:1 "Theme" "$varNomeTema" --icon=preferences-desktop-theme