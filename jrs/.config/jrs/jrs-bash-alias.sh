# My Bash
PS1='[\w]\$ '
# Colors
alias ls='ls --color=auto'
alias grep='grep --color=auto'
# DE
alias my-hyprland="start-hyprland"
alias my-i3wm="startx ~/.config/i3/startx-i3"
alias my-cosmic="cosmic-session"
alias my-kde="dbus-run-session startplasma-wayland"
# My Alias
alias gitatt="git add . && git commit -m \"att\" && git push"
alias ff="fastfetch"
alias pacmanclearcache="sudo pacman -Scc"
alias pacmanaurpackages="sudo pacman -Qm"
alias flatpakremoveall="flatpak remove --all"
alias archsshdstart="sudo systemctl start sshd"
alias archkerneleditgrub="sudo nano /etc/default/grub"
# Image Magick
alias magick1080p="magick $1 -resize 1920x1080 $2"
# Mango Hud
alias mhvk="mangohud glxgears"
alias mhgl="mangohud vkcube"
# Yt-dlp
alias yt-dlp-mp4-720p='yt-dlp -f "bestvideo[height<=720][ext=mp4]+bestaudio[ext=m4a]/mp4" --merge-output-format mp4'
alias yt-dlp-mp4='yt-dlp -f "bestvideo[ext=mp4]+bestaudio[ext=m4a]/mp4" --merge-output-format mp4'
alias yt-dlp-mp3='yt-dlp -x --audio-format mp3 --audio-quality 0'
# Mpv
alias mpv720p60='mpv --profile=720p60'
alias mpv1080p30='mpv --profile=1080p30'
alias mpv1080p60="mpv --profile=1080p60"
# Code
alias codehere='code . && exit'
alias codedotfiles='code ~/.dotfiles && exit'
# SSH
alias sshlocalserver="ssh jhonatanrs@192.168.0.134"
# Dotfiles
alias mydotfiles="bash ~/.config/jrs/jrs-mydotfiles.sh"
# Servers
alias mineserver="cd ~/Servers/MINEJRS && bash run.sh"

