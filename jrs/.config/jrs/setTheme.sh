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
echo "background        #$JRS_BAR_COLOR
foreground      #$JRS_TEXT_COLOR
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
    timeout = 5000
    idle_threshold = 0
    ignore_dbusclose = true
    monitor = 0
    follow = none
    geometry = "300x0+10+10"
    origin = top-right
    offset = 10x50
    notification_limit = 20
    progress_bar = true
    progress_bar_height = 10
    progress_bar_frame_width = 1
    progress_bar_min_width = 150
    progress_bar_max_width = 300
    progress_bar_corner_radius = 0
    progress_bar_corners = all
    icon_corner_radius = 0
    icon_corners = all
    indicate_hidden = yes
    transparency = 0
    separator_height = 2
    padding = 8
    horizontal_padding = 8
    text_icon_padding = 0
    frame_width = 2
    frame_color = "#'$JRS_MAIN_COLOR'"
    gap_size = 0
    separator_color = frame
    sort = yes
    font = Caskaydia Mono Nerd Font 11
    line_height = 0
    markup = full
    format = "<b>%s</b>\n%b"
    alignment = left
    vertical_alignment = center
    show_age_threshold = 60
    ellipsize = middle
    ignore_newline = no
    stack_duplicates = true
    hide_duplicate_count = false
    show_indicators = yes
    enable_recursive_icon_lookup = true
    icon_theme = "Papirus-Dark"
    icon_position = left
    min_icon_size = 32
    max_icon_size = 128
    icon_path = /usr/share/icons/Papirus/16x16/status/:/usr/share/icons/Papirus/16x16/devices/
    sticky_history = yes
    history_length = 20
    dmenu = /usr/bin/dmenu -p dunst:
    browser = /usr/bin/xdg-open
    always_run_script = true
    title = Dunst
    class = Dunst
    corner_radius = 10
    corners = all
    ignore_dbusclose = false
    force_xwayland = false
    force_xinerama = false
    mouse_left_click = close_current
    mouse_middle_click = do_action, close_current
    mouse_right_click = close_all
[experimental]
    per_monitor_dpi = false
[urgency_low]
    background = "#'$JRS_BAR_COLOR'aa"
    foreground = "#'$JRS_TEXT_COLOR'"
    timeout = 10
[urgency_normal]
    background = "#'$JRS_BAR_COLOR'aa"
    foreground = "#'$JRS_TEXT_COLOR'"
    timeout = 10
    override_pause_level = 30
[urgency_critical]
    background = "#'$JRS_BAR_COLOR'aa"
    foreground = "#'$JRS_TEXT_COLOR'"
    frame_color = "#'$JRS_BAD_COLOR'"
    timeout = 0
    override_pause_level = 60' > $HOME/.config/dunst/dunstrc

hyprctl reload & 
killall -SIGUSR2 waybar &
hyprctl hyprpaper reload ,"~/.config/wallpapers/$JRS_WALLPAPER"
pkill -USR1 -x sxhkd &
bspc wm -r &
dunstctl reload &
