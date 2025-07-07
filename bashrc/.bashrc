#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Colors
alias ls='ls --color=auto'
alias grep='grep --color=auto'
# My Alias
alias gitatt="git commit -a -m \"att\" && git push"
alias ff="fastfetch"
alias pacmanclearcache="sudo pacman -Scc"
alias archsshdstart="sudo systemctl start sshd"
alias yt-dlp-mp4-720p='yt-dlp -f "bestvideo[height<=720][ext=mp4]+bestaudio[ext=m4a]/mp4" --merge-output-format mp4'
alias yt-dlp-mp4='yt-dlp -f "bestvideo[ext=mp4]+bestaudio[ext=m4a]/mp4" --merge-output-format mp4'
alias yt-dlp-mp3='yt-dlp -x --audio-format mp3 --audio-quality 0'
alias codef='code . && exit'
alias mineserver='bash ~/.bashmenu/MINEJRS/run.sh'
# My Bash
#PS1='[\u@\h \W]\$ '
PS1='[\w]\$ '
