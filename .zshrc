if [[ `hostname` = "esekilxv7127" ]]; then
  source ~/.zshrc.ericsson
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
if [[ `hostname` = "ArchBerbert" ]]; then
  export ZSH=/home/melker/.oh-my-zsh
fi

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="random"
#ZSH_THEME="robbyrussell"
if [[ `hostname` = "ArchBerbert" ]]; then
  ZSH_THEME="agnoster"
fi

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=1

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

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

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
if [[ `hostname` = "esekilxv7127" ]]; then
  plugins=(git pip colorize colored-man-pages extract)
elif [[ -d ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting ]]; then
  plugins=(git pip colorize colored-man-pages extract zsh-output-highlighting zsh-syntax-highlighting) # zsh-syntax-highlighting must be the last plugin
fi

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"


#echo 255 | sudo tee /sys/devices/platform/i8042/serio1/serio2/speed
#echo 255 | sudo tee /sys/devices/platform/i8042/serio1/serio2/sensitivity
#sudo chmod -R a+rw /sys/devices/platform/i8042/serio1/serio2/

#För att ta bort (+i) skrivrättigheter fran en fil, resp lagga till (-i)
#chattr +i filename.ext
#chattr -i filename.ext

export VISUAL=vim
export EDITOR=$VISUAL

alias settings='gvim ~/.zshrc'
alias vimrc='gvim ~/.vimrc'
alias ..='cd .. && ls'
alias ...='cd ../.. && ls'
alias ....='cd ../../.. && ls'
alias plugg='cd ~/Plugg'
#alias --='cd -'
alias grep='grep -Iin --color=always'
alias grepr='grep -r'
alias mdi='cd ~/plugg/mdi-wp/'
alias s='search'
alias search='find . -iname'
alias vimrc-save='cp ~/.vimrc ~/Dropbox/Software/.vimrc'
alias settings-save='cp ~/.zshrc /run/media/melker/Windows\ 7/Users/Melker/Dropbox/Software/.zshrc'
alias mouse-speed='echo 255 | sudo tee /sys/devices/platform/i8042/serio1/serio2/speed && echo 255 | sudo tee /sys/devices/platform/i8042/serio1/serio2/sensitivity'
alias uu='cd ~/burgers/'
alias countfiles='du -a | cut -d/ -f2 | sort | uniq -c | sort -nr'
alias listfiles='find . -type f -iname "*"'
alias xs='xargs -I % sh -c'

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
alias src='source ~/.zshrc'
alias installed='pacman -Qqettm'
alias zshrc='gvim ~/.zshrc'
alias src='source ~/.zshrc'
alias gu='git diff HEAD@{1} HEAD'
alias gly='git log --since="yesterday"'

#Powerline
if [[ -r /usr/lib/python3.6/site-packages/powerline/bindings/zsh/powerline.zsh ]]; then
    source /usr/lib/python3.6/site-packages/powerline/bindings/zsh/powerline.zsh
fi


# prompt_context () { }
#DEFAULT_USER="melker"

#Syntax highligting in less:
#export LESSOPEN="| /usr/local/bin/src-hilite-lesspipe.sh %s"
#export LESS=" -R "

alias less='less -m -N -g -i -J --underline-special --SILENT'
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias dot='dotfiles'
alias dots='dot status'


#Ericsson
alias xclip='xclip -selection c'
alias ls='ls -F --color'
alias lsa='ls -Fa --color'
alias m='make'
alias tree='tree -C'
