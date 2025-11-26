#!/bin/bash

source ~/.config/jrs/colorsTheme.sh

# Hyprpaper setup
echo "reload = ~/.config/wallpapers/$JRS_WALLPAPER
wallpaper = , ~/.config/wallpapers/$JRS_WALLPAPER" > ~/.config/hypr/hyprpaper.conf

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

hyprctl reload & 
killall -SIGUSR2 waybar &
killall polybar &
hyprctl hyprpaper reload ,"~/.config/wallpapers/$JRS_WALLPAPER"
pkill -USR1 -x sxhkd &
bspc wm -r &
dunstctl reload &
i3-msg restart &
i3-msg reload &
