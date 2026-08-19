#!/usr/bin/env bash

# Carrega os temas em dicionários
source "$HOME/.config/jrs/jrs-scripts-themes.sh"

the_look_light() {
    local THEME="adw-gtk3"
    local ICONS="Papirus-Light"
    local SCHEME="prefer-light"
    local SCHEME_NUM="0"

    mkdir -p "$HOME/.local/share/nwg-look/"

    cat <<EOF >"$HOME/.local/share/nwg-look/gsettings"
gtk-theme=$THEME
icon-theme=$ICONS
font-name=CaskaydiaMono Nerd Font 11
cursor-theme=Adwaita
cursor-size=24
toolbar-style=both-horiz
toolbar-icons-size=large
font-hinting=slight
font-antialiasing=grayscale
font-rgba-order=rgb
text-scaling-factor=1.0
color-scheme=$SCHEME
event-sounds=true
input-feedback-sounds=true
EOF

    mkdir -p "$HOME/.config/xsettingsd"
    cat <<EOF >"$HOME/.config/xsettingsd/xsettingsd.conf"
Net/ThemeName "$THEME"
Net/IconThemeName "$ICONS"
Gtk/CursorThemeName "Adwaita"
Net/EnableEventSounds 1
EnableInputFeedbackSounds 1
Xft/Antialias 1
Xft/Hinting 1
Xft/HintStyle "hintslight"
Xft/RGBA "rgb"
EOF

    cat <<EOF >"$HOME/.config/gtk-3.0/settings.ini"
[Settings]
gtk-theme-name=$THEME
gtk-icon-theme-name=$ICONS
gtk-font-name=CaskaydiaMono Nerd Font 11
gtk-cursor-theme-name=Adwaita
gtk-cursor-theme-size=24
gtk-toolbar-style=GTK_TOOLBAR_ICONS
gtk-toolbar-icon-size=GTK_ICON_SIZE_LARGE_TOOLBAR
gtk-button-images=1
gtk-menu-images=1
gtk-enable-event-sounds=1
gtk-enable-input-feedback-sounds=1
gtk-xft-antialias=1
gtk-xft-hinting=1
gtk-xft-hintstyle=hintslight
gtk-xft-rgba=rgb
gtk-application-prefer-dark-theme=$SCHEME_NUM
gtk-modules=gail:atk-bridge
EOF

    cat <<EOF >"$HOME/.config/gtk-4.0/settings.ini"
[Settings]
gtk-theme-name=$THEME
gtk-icon-theme-name=$ICONS
gtk-font-name=CaskaydiaMono Nerd Font 11
gtk-cursor-theme-name=Adwaita
gtk-cursor-theme-size=24
gtk-application-prefer-dark-theme=$SCHEME_NUM
EOF
    sleep 1
    code_light
    gsettings set org.gnome.desktop.interface gtk-theme "$THEME"
    gsettings set org.gnome.desktop.interface icon-theme "$ICONS"
    gsettings set org.gnome.desktop.interface color-scheme "$SCHEME"

    export GTK_THEME=$THEME
    if pgrep -x "xsettingsd" >/dev/null; then
        killall -HUP xsettingsd
    else
        xsettingsd &
    fi

    nwg-look -a
    echo "Ambiente Light aplicado com sucesso!"
}

the_look_dark() {
    local THEME="adw-gtk3-dark"
    local ICONS="Papirus-Dark"
    local SCHEME="prefer-dark"
    local SCHEME_NUM="1"

    mkdir -p "$HOME/.local/share/nwg-look/"

    cat <<EOF >"$HOME/.local/share/nwg-look/gsettings"
gtk-theme=$THEME
icon-theme=$ICONS
font-name=CaskaydiaMono Nerd Font 11
cursor-theme=Adwaita
cursor-size=24
toolbar-style=both-horiz
toolbar-icons-size=large
font-hinting=slight
font-antialiasing=grayscale
font-rgba-order=rgb
text-scaling-factor=1.0
color-scheme=$SCHEME
event-sounds=true
input-feedback-sounds=true
EOF

    mkdir -p "$HOME/.config/xsettingsd"
    cat <<EOF >"$HOME/.config/xsettingsd/xsettingsd.conf"
Net/ThemeName "$THEME"
Net/IconThemeName "$ICONS"
Gtk/CursorThemeName "Adwaita"
Net/EnableEventSounds 1
EnableInputFeedbackSounds 1
Xft/Antialias 1
Xft/Hinting 1
Xft/HintStyle "hintslight"
Xft/RGBA "rgb"
EOF

    cat <<EOF >"$HOME/.config/gtk-3.0/settings.ini"
[Settings]
gtk-theme-name=$THEME
gtk-icon-theme-name=$ICONS
gtk-font-name=CaskaydiaMono Nerd Font 11
gtk-cursor-theme-name=Adwaita
gtk-cursor-theme-size=24
gtk-toolbar-style=GTK_TOOLBAR_ICONS
gtk-toolbar-icon-size=GTK_ICON_SIZE_LARGE_TOOLBAR
gtk-button-images=1
gtk-menu-images=1
gtk-enable-event-sounds=1
gtk-enable-input-feedback-sounds=1
gtk-xft-antialias=1
gtk-xft-hinting=1
gtk-xft-hintstyle=hintslight
gtk-xft-rgba=rgb
gtk-application-prefer-dark-theme=$SCHEME_NUM
gtk-modules=gail:atk-bridge
EOF

    cat <<EOF >"$HOME/.config/gtk-4.0/settings.ini"
[Settings]
gtk-theme-name=$THEME
gtk-icon-theme-name=$ICONS
gtk-font-name=CaskaydiaMono Nerd Font 11
gtk-cursor-theme-name=Adwaita
gtk-cursor-theme-size=24
gtk-application-prefer-dark-theme=$SCHEME_NUM
EOF
    sleep 1
    code_dark
    gsettings set org.gnome.desktop.interface gtk-theme "$THEME"
    gsettings set org.gnome.desktop.interface icon-theme "$ICONS"
    gsettings set org.gnome.desktop.interface color-scheme "$SCHEME"

    export GTK_THEME=$THEME
    if pgrep -x "xsettingsd" >/dev/null; then
        killall -HUP xsettingsd
    else
        xsettingsd &
    fi

    nwg-look -a
    echo "Ambiente Dark aplicado com sucesso!"
}

code_light() {
    mkdir -p "$HOME/.config/Code - OSS/User/"
    echo '{
    "workbench.colorTheme": "Default Light Modern"
}' >"$HOME/.config/Code - OSS/User/settings.json"
}

code_dark() {
    mkdir -p "$HOME/.config/Code - OSS/User/"
    echo '{
    "workbench.colorTheme": "Default Dark Modern"
}' >"$HOME/.config/Code - OSS/User/settings.json"
}

apply_theme() {
    # Garante que selected_theme não esteja vazio
    if [[ -z "$selected_theme" ]]; then
        selected_theme="theme_0_dark"
    fi

    declare -n chosen_theme="$selected_theme"

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
    JRS_THEME_MODE="${chosen_theme[theme_mode]}"

    case $JRS_BAR_OPACITY in
        "0")   JRS_WAYBAR_OPACITY="0.0"; JRS_POLYBAR_OPACITY="00" ;;
        "10")  JRS_WAYBAR_OPACITY="0.1"; JRS_POLYBAR_OPACITY="1A" ;;
        "20")  JRS_WAYBAR_OPACITY="0.2"; JRS_POLYBAR_OPACITY="33" ;;
        "30")  JRS_WAYBAR_OPACITY="0.3"; JRS_POLYBAR_OPACITY="4D" ;;
        "40")  JRS_WAYBAR_OPACITY="0.4"; JRS_POLYBAR_OPACITY="66" ;;
        "50")  JRS_WAYBAR_OPACITY="0.5"; JRS_POLYBAR_OPACITY="80" ;;
        "60")  JRS_WAYBAR_OPACITY="0.6"; JRS_POLYBAR_OPACITY="99" ;;
        "70")  JRS_WAYBAR_OPACITY="0.7"; JRS_POLYBAR_OPACITY="B3" ;;
        "80")  JRS_WAYBAR_OPACITY="0.8"; JRS_POLYBAR_OPACITY="CC" ;;
        "90")  JRS_WAYBAR_OPACITY="0.9"; JRS_POLYBAR_OPACITY="E6" ;;
        "100") JRS_WAYBAR_OPACITY="1.0"; JRS_POLYBAR_OPACITY="FF" ;;
        *)     JRS_WAYBAR_OPACITY="1.0"; JRS_POLYBAR_OPACITY="FF" ;;
    esac

    case $JRS_THEME_MODE in
        "dark")  the_look_dark ;;
        "light") the_look_light ;;
        *)       the_look_dark ;;
    esac

    # Configuração dos arquivos no sistema
    echo "wallpaper {
        monitor = 
        path = ~/.config/wallpapers/$JRS_WALLPAPER
        fit_mode = cover
    }
    splash = false" >~/.config/hypr/hyprpaper.conf

    echo "if ! pgrep -x "hyprpaper" > /dev/null; then
        hyprpaper &
    fi
    hyprctl hyprpaper wallpaper , ~/.config/wallpapers/$JRS_WALLPAPER" >~/.config/hypr/hyprpaper.sh

    echo '$wallpaper = '$JRS_WALLPAPER'
    $color1 = '$JRS_MAIN_COLOR'
    $color2 = '$JRS_BAR_COLOR'
    $color3 = '$JRS_TEXT_COLOR'
    $color4 = '$JRS_UNFOCUSED_COLOR'
    $color5 = '$JRS_BLACK_COLOR'
    $color6 = '$JRS_BLACK_COLOR'
    $color7 = '$JRS_BLACK_COLOR'' >~/.config/hypr/colors.conf

    echo 'wallpaper = "'$JRS_WALLPAPER'"
    color1 = "#'$JRS_MAIN_COLOR'"
    color2 = "#'$JRS_BAR_COLOR'"
    color3 = "#'$JRS_TEXT_COLOR'"
    color4 = "#'$JRS_UNFOCUSED_COLOR'"
    color5 = "#'$JRS_BLACK_COLOR'"
    color6 = "#'$JRS_BLACK_COLOR'"
    color7 = "#'$JRS_BLACK_COLOR'"' >~/.config/hypr/colors.lua

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

    echo "[colors]
    base00 = #$JRS_MAIN_COLOR
    base01 = #$JRS_POLYBAR_OPACITY$JRS_BAR_COLOR
    base02 = #$JRS_TEXT_COLOR
    base03 = #$JRS_UNFOCUSED_COLOR
    base04 = #$JRS_BAD_COLOR
    base05 = #$JRS_DEGRADED_COLOR
    base06 = #$JRS_WHITE_COLOR
    base07 = #$JRS_BLACK_COLOR" >~/.config/polybar/colors.ini

    echo "* {
        base00: #$JRS_MAIN_COLOR;
        base01: #$JRS_BAR_COLOR$JRS_POLYBAR_OPACITY;
        base02: #$JRS_TEXT_COLOR;
        base03: #$JRS_UNFOCUSED_COLOR;
        base04: #$JRS_BAD_COLOR;
        base05: #$JRS_DEGRADED_COLOR;
        base06: #$JRS_WHITE_COLOR;
        base07: #$JRS_BLACK_COLOR;
    }" >~/.config/rofi/colors.rasi

    echo 'exec_always --no-startup-id feh --bg-fill ~/.config/wallpapers/'$JRS_WALLPAPER'
    set $color1 #'$JRS_MAIN_COLOR'
    set $color2 #'$JRS_BAR_COLOR'
    set $color3 #'$JRS_TEXT_COLOR'
    set $color4 #'$JRS_UNFOCUSED_COLOR'
    set $color5 #'$JRS_BLACK_COLOR'
    set $color6 #'$JRS_BLACK_COLOR'
    set $color7 #'$JRS_BLACK_COLOR'

    client.focused          $color1 $color1 $color3 $color1 $color1
    client.focused_inactive $color1 $color4 $color2 $color4 $color4
    client.unfocused        $color4 $color4 $color2 $color4 $color4
    client.urgent           $color7 $color5 $color3 $color5 $color5
    client.placeholder      $color6 $color6 $color3 $color6 $color6
    client.background       $color3
    ' >~/.config/i3/colors

    echo '-- Função auxiliar para definir destaques
    local hi = function(group, opts)
        vim.api.nvim_set_hl(0, group, opts)
    end

    vim.cmd("hi clear")
    if vim.fn.exists("syntax_on") then
        vim.cmd("syntax reset")
    end

    vim.o.background = "dark"

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
    hi("Keyword", { fg = "#C586C0", bold = true })' >$HOME/.config/nvim/bkp/colors/colors.lua

    echo 'local colors = {
              main_bg = "#'$JRS_BAR_COLOR'",
              selection_bg = "#'$JRS_MAIN_COLOR'",
              line_bg = "#2A2D2E",
              ui_fg = "#'$JRS_TEXT_COLOR'",
              comment_fg = "#6A9955",
              string = "#CE9178",
              number = "#B5CEA8",
              type = "#4EC9B0",
              function_name = "#DCDCAA",
              keyword = "#C586C0",
              variable = "#9CDCFE",
              operator = "#D4D4D4",
              error = "#F44747",
              info = "#3b82f6",
              warning = "#F9A825",
              cursor_fg = "#1E1E1E",
              cursor_bg = "#AEAFAD",
              linenr_fg = "#858585",
            }
            
    return colors' >$HOME/.config/nvim/lua/config/colors.lua

    echo "[colors]
        draw_bold_text_with_bright_colors = true
    [colors.primary]
        background = '#$JRS_BAR_COLOR'
        foreground = '#$JRS_TEXT_COLOR'
    [window]
    opacity = $JRS_WAYBAR_OPACITY" >$HOME/.config/alacritty/colors.toml

    echo '#!/bin/bash
    [global]
        frame_color = "#'$JRS_MAIN_COLOR'"
    [urgency_low]
        background = "#'$JRS_BAR_COLOR$JRS_POLYBAR_OPACITY'"
        foreground = "#'$JRS_TEXT_COLOR'"
    [urgency_normal]
        background = "#'$JRS_BAR_COLOR$JRS_POLYBAR_OPACITY'"
        foreground = "#'$JRS_TEXT_COLOR'"
    [urgency_critical]
        background = "#'$JRS_BAR_COLOR$JRS_POLYBAR_OPACITY'"
        foreground = "#'$JRS_TEXT_COLOR'"
        frame_color = "#'$JRS_BAD_COLOR'"' >$HOME/.config/dunst/dunstrc.d/colors.conf

    echo '# Theme: colors
    # By: Jhonatanrs

    theme[main_bg]="#'$JRS_BAR_COLOR$JRS_POLYBAR_OPACITY'"
    theme[main_fg]="#'$JRS_TEXT_COLOR'"
    theme[title]="#'$JRS_TEXT_COLOR'"
    theme[hi_fg]="#'$JRS_MAIN_COLOR'"
    theme[selected_bg]="#'$JRS_UNFOCUSED_COLOR'"
    theme[selected_fg]="#'$JRS_TEXT_COLOR'"
    theme[inactive_fg]="#'$JRS_UNFOCUSED_COLOR'"
    theme[proc_misc]="#7dcfff"
    theme[cpu_box]="#'$JRS_MAIN_COLOR'"
    theme[mem_box]="#'$JRS_MAIN_COLOR'"
    theme[net_box]="#'$JRS_MAIN_COLOR'"
    theme[proc_box]="#'$JRS_MAIN_COLOR'"
    theme[div_line]="#'$JRS_MAIN_COLOR'"
    theme[temp_start]="#'$JRS_MAIN_COLOR'"
    theme[temp_mid]=""
    theme[temp_end]="#'$JRS_BAR_COLOR'"
    theme[cpu_start]="#'$JRS_MAIN_COLOR'"
    theme[cpu_mid]=""
    theme[cpu_end]="#'$JRS_BAR_COLOR'"
    theme[free_start]="#'$JRS_MAIN_COLOR'"
    theme[free_mid]=""
    theme[free_end]="#'$JRS_BAR_COLOR'"
    theme[cached_start]="#'$JRS_MAIN_COLOR'"
    theme[cached_mid]=""
    theme[cached_end]="#'$JRS_BAR_COLOR'"
    theme[available_start]="#'$JRS_MAIN_COLOR'"
    theme[available_mid]=""
    theme[available_end]="#'$JRS_BAR_COLOR'"
    theme[used_start]="#'$JRS_MAIN_COLOR'"
    theme[used_mid]=""
    theme[used_end]="#'$JRS_BAR_COLOR'"
    theme[download_start]="#'$JRS_MAIN_COLOR'"
    theme[download_mid]=""
    theme[download_end]="#'$JRS_BAR_COLOR'"
    theme[upload_start]="#'$JRS_MAIN_COLOR'"
    theme[upload_mid]=""
    theme[upload_end]="#'$JRS_BAR_COLOR'"
    ' >$HOME/.config/btop/themes/colors.theme

    source $HOME/.config/jrs/jrs-exec-reload-wm.sh
}