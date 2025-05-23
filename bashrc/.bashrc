#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# My Default Theme
export GTK_THEME=Breeze-Dark
export GTK_ICON_THEME=Papirus-Dark
export XCURSOR_THEME=capitaine-cursors
export XCURSOR_SIZE=24
# Colors
alias ls='ls --color=auto'
alias grep='grep --color=auto'
# My Alias
alias gitatt="git commit -a -m \"att\" && git push"
alias ff="fastfetch"
alias pacmanclearcache="sudo pacman -Scc"
alias dirdotfiles="cd ~/.dotfiles"
alias dirbashmenu="cd ~/Documents/GitHub/BashMenu"
alias dirgithub="cd ~/Documents/GitHub"
alias archsshdstart="sudo systemctl start sshd"
# My Bash
#PS1='[\u@\h \W]\$ '
PS1='[\w]\$ '
