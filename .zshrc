if [[ -r .zshrc.private ]]; then
  source ~/.zshrc.private
fi

# Path to oh-my-zsh installation
if [[ `hostname` = "ArchBerbert" ]]; then
  export ZSH=/home/melker/.oh-my-zsh
fi

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
if [[ `hostname` = "ArchBerbert" ]]; then
  ZSH_THEME="agnoster"
fi

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
 HYPHEN_INSENSITIVE="true"

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=1

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
 DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/

plugins=(
  git
  pip
  colorize colored-man-pages
  extract
  bd
  autoupdate
  zsh-autopair
  zsh-autosuggestions
  zsh-output-highlighting
  zsh-syntax-highlighting # zsh-syntax-highlighting must be the last plugin
)

source $ZSH/oh-my-zsh.sh

#echo 255 | sudo tee /sys/devices/platform/i8042/serio1/serio2/speed
#echo 255 | sudo tee /sys/devices/platform/i8042/serio1/serio2/sensitivity
#sudo chmod -R a+rw /sys/devices/platform/i8042/serio1/serio2/

#För att ta bort (+i) skrivrättigheter fran en fil, resp lagga till (-i)
#chattr +i filename.ext
#chattr -i filename.ext

export VISUAL=vim
export EDITOR=$VISUAL

alias zshrc='gvim ~/.zshrc'
alias vimrc='gvim ~/.vimrc'
alias src='source ~/.zshrc'
alias ..='cd .. && ls'
alias ...='cd ../.. && ls'
alias ....='cd ../../.. && ls'
alias grep='grep -Iin --color=always'
alias grepr='grep -r'
alias s='search'
alias search='find . -iname'
alias countfiles='du -a | cut -d/ -f2 | sort | uniq -c | sort -nr'
alias listfiles='find . -type f -iname "*"'
alias xs='xargs -I % sh -c'
alias mouse-speed='echo 80 | sudo tee /sys/devices/platform/i8042/serio1/serio2/speed && echo 180 | sudo tee /sys/devices/platform/i8042/serio1/serio2/sensitivity'
alias less='less -m -N -g -i -J --underline-special --SILENT'
alias xclip='xclip -selection c'
alias ls='ls -F --color'
alias lsa='ls -Fa --color'
alias m='make'
alias tree='tree -C'
alias installed='yaourt -Qqe'
alias b='bd 1'
alias open='xdg-open'
alias errorlogs='journalctl --since=today'

#Git:
alias g='git'
alias gs='git status'
alias gl='git log --decorate'
alias gd='git diff'
alias gco='git checkout'
alias gp='git pull'
alias gb='git branch'
alias gw='git whatchanged'
alias gcm='git commit -m'
alias gcam='git commit -am'
alias gu='git diff HEAD@{1} HEAD'
alias gly='git log --since="yesterday"'

#Dotfiles
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias dot='dotfiles'
alias dots='dot status'

#Powerline
if [[ -r /usr/lib/python3.6/site-packages/powerline/bindings/zsh/powerline.zsh ]]; then
    source /usr/lib/python3.6/site-packages/powerline/bindings/zsh/powerline.zsh
fi

# prompt_context () { }
#DEFAULT_USER="melker"

#Syntax highligting in less:
export LESSOPEN="| /bin/src-hilite-lesspipe.sh %s"
export LESS=" -R "

#Swap behaviour of <Up>/<Down> keys and Ctrl + P/N
bindkey '^P'  up-line-or-search
bindkey '^N'  down-line-or-search
bindkey '^[[A' up-line-or-history
bindkey '^[[B' down-line-or-history
#last two don't seem to work though


neofetch # Os information as start page
