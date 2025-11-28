#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Colors
alias ls='ls --color=auto'
alias grep='grep --color=auto'
# My Alias
alias gitatt="git add . && git commit -m \"att\" && git push"
alias ff="fastfetch"
alias pacmanclearcache="sudo pacman -Scc"
alias pacmanaurpackages="sudo pacman -Qm"
alias flatpakremoveall="flatpak remove --all"
alias archsshdstart="sudo systemctl start sshd"
alias shutdownnow="systemctl poweroff"
alias rebootnow="systemctl reboot"
alias archkerneleditgrub="sudo nano /etc/default/grub"
alias rhyprpaper="killall hyprpaper && hyprpaper & exit"
alias jrs-debugs="bash $HOME/.config/jrs/scripts/jrs-debugs.sh"
# MangoHud
alias mangovktest="mangohud vkcube"
alias mangogltest="mangohud glxgears"
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
alias codedotfiles="code ~/.dotfiles && exit"
alias vimdotfiles="cd ~/.dotfiles && nvim ."
# SSH
alias sshlocalserver="ssh jhonatanrs@192.168.0.134"
# Git Status
alias mydotfiles="bash $HOME/.config/jrs/scripts/jrs-mydotfiles.sh"
# My Bash
#PS1='[\u@\h \W]\$ '
PS1='[\w]\$ '
