PATH=$PATH:~/.gem/ruby/2.5.0/bin

if [[ -r ~/.zshrc.private ]]; then
  source ~/.zshrc.private
fi

# Path to oh-my-zsh installation
# if [[ -d /home/melker/.oh-my-zsh ]]; then
#   export ZSH=/home/melker/.oh-my-zsh
# else echo "Oh-my-zsh not installed"
# fi

# -- Antigen --

source ~/.zsh/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundles << EOBUNDLES
git
pip
lein
command-not-found
colorize
colored-man-pages
extract
Tarrasch/zsh-bd
TamCore/autoupdate-oh-my-zsh-plugins
hlissner/zsh-autopair
l4u/zsh-output-highlighting
zsh-users/zsh-autosuggestions
zsh-users/zsh-syntax-highlighting

EOBUNDLES

# Tell Antigen that you're done.
antigen apply

# ------------

ZSH_THEME="agnoster" # Default theme (should be overwritten by Powerline theme)

HYPHEN_INSENSITIVE="true" # Use hyphen-insensitive completion.

export UPDATE_ZSH_DAYS=1 # How often to auto-update (in days).

ENABLE_CORRECTION="true" # Enables command auto-correction.

COMPLETION_WAITING_DOTS="true" # Displays red dots whilst waiting for completion.

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# plugins=(
#   git
#   pip
#   colorize colored-man-pages
#   extract
#   bd
#   autoupdate
#   zsh-autopair
#   zsh-autosuggestions
#   zsh-output-highlighting
#   zsh-syntax-highlighting # zsh-syntax-highlighting must be the last plugin
# )

# source $ZSH/oh-my-zsh.sh

#Powerline theme (has to come after `source $ZSH/oh-my-zsh.sh`)
if [[ -r `python -m site --user-site`/powerline/bindings/zsh/powerline.zsh ]]; then
  source `python -m site --user-site`/powerline/bindings/zsh/powerline.zsh
else
  echo "Powerline theme doesn't exists, using default theme \"$ZSH_THEME\""
fi

#För att ta bort (+i) skrivrättigheter fran en fil, resp lagga till (-i)
#chattr +i filename.ext
#chattr -i filename.ext

export VISUAL=vim
export EDITOR=$VISUAL

alias zshrc='nvim ~/.zshrc'
alias vimrc='nvim ~/.vimrc'
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
alias c='xclip -selection clipboard'
alias v='xclip -o'
alias ls='ls -F --color'
alias lsa='ls -Fa --color'
alias m='make'
alias tree='tree -C'
alias installed='yaourt -Qqe'
alias b='bd 1'
alias open='xdg-open &>/dev/null'
alias errorlogs='journalctl --since=today'
alias screenkey='screenkey -t 1.5 -s small'

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

# Create a new directory and enter it
function mkcd() {
  mkdir -p "$@" && cd "$@"
}


# neofetch # Os information as start page
