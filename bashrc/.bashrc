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
alias flatpakremoveall="flatpak remove --all"
alias archsshdstart="sudo systemctl start sshd"
alias discordX='ELECTRON_OZONE_PLATFORM_HINT= discord --no-sandbox && exit'
# MangoHud
alias mangovktest="mangohud vkcube"
alias mangogltest="mangohud glxgears"
# Steam
alias steamdecklike="exec $HOME/.config/jrs/steamdecklike.sh"
# Yt-dlp
alias yt-dlp-mp4-720p='yt-dlp -f "bestvideo[height<=720][ext=mp4]+bestaudio[ext=m4a]/mp4" --merge-output-format mp4'
alias yt-dlp-mp4='yt-dlp -f "bestvideo[ext=mp4]+bestaudio[ext=m4a]/mp4" --merge-output-format mp4'
alias yt-dlp-mp3='yt-dlp -x --audio-format mp3 --audio-quality 0'
# Mpv
alias mpv720p60='mpv --profile=720p60'
alias mpv1080p30='mpv --profile=1080p30'
alias mpv1080p60="mpv --profile=1080p60"
# Servers
alias mineserver='bash ~/.bashmenu/MINEJRS/run.sh'
alias palserver='bash ~/.bashmenu/PalServer/run.sh'
# Code
alias codehere='code . && exit'
alias codedotfiles="code ~/.dotfiles && exit"
# Git Status
alias mydotfiles='
  cd ~/.dotfiles && git pull && git status
  read -p "Deseja atualizar seu repositório de dotfiles? (y/N) " confirm &&
  if [[ "$confirm" == [yY] ]]; then
     git add . && git commit -m "att" && git push
  fi
'
# My Bash
#PS1='[\u@\h \W]\$ '
PS1='[\w]\$ '
