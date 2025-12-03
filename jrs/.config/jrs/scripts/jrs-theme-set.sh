#!/bin/bash

source $HOME/.config/jrs/scripts/jrs-themes.sh

select_theme_with_rofi() {

	local theme_name display_name
	local theme_names
	readarray -t theme_names < <(declare -A | grep -oP 'declare -A \Ktheme_[^=]*' | sort)
	display_names_output=""
	display_names_and_variables=""
	for theme_name in "${theme_names[@]}"; do
		eval "display_name=\${${theme_name}[name]:-}"
		if [[ -z "$display_name" ]]; then
			local raw_name="${theme_name/theme_/}"
			display_name="$(echo "${raw_name^}" | tr '_' ' ')"
		fi
		display_names_output+="$display_name\n"
		display_names_and_variables+="$display_name|$theme_name\n"
	done
	display_names_output=$(echo -e "$display_names_output")

	local options=$display_names_output

	menu_cmd="rofi -dmenu -i -p Themes"

	chosen_name=$(echo -e "$options" | $menu_cmd)

	if [ -n "$chosen_name" ]; then
		selected_theme=$(echo -e "$display_names_and_variables" | grep -F "$chosen_name" | head -n 1)
		selected_theme=$(echo "$selected_theme" | cut -d'|' -f2 | tr -d '[:space:]')
	else
		selected_theme=""
		exit 1
	fi

}

select_theme_with_rofi
declare -n chosen_theme="$selected_theme"
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

