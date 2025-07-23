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
alias archsshdstart="sudo systemctl start sshd"
alias discord='discord --no-sandbox'
# Yt-dlp
alias yt-dlp-mp4-720p='yt-dlp -f "bestvideo[height<=720][ext=mp4]+bestaudio[ext=m4a]/mp4" --merge-output-format mp4'
alias yt-dlp-mp4='yt-dlp -f "bestvideo[ext=mp4]+bestaudio[ext=m4a]/mp4" --merge-output-format mp4'
alias yt-dlp-mp3='yt-dlp -x --audio-format mp3 --audio-quality 0'
# Servers
alias mineserver='bash ~/.bashmenu/MINEJRS/run.sh'
alias palserver='bash ~/.bashmenu/PalServer/run.sh'
# Code
alias codehere='code . && exit'
alias codedotfiles="code ~/.dotfiles && exit"
alias codebashmenu="code ~/Documents/GitHub/BashMenu && exit"
alias codejrsapp="code ~/Documents/GitHub/JRSAPP && exit"
# Git Status
alias gitdotfiles='cd ~/.dotfiles && git pull && git status'
alias gitbashmenu='cd ~/Documents/GitHub/BashMenu && git pull && git status'
# My Bash
#PS1='[\u@\h \W]\$ '
PS1='[\w]\$ '
