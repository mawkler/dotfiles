PATH=$PATH:~/.gem/ruby/2.5.0/bin

ZSH_THEME="agnoster" # Backup theme (gets overwritten by Powerline theme if available)

# ------------- Antigen -------------

source ~/.zsh/antigen.zsh

antigen use oh-my-zsh # Load the oh-my-zsh's library.

antigen bundles << EOBUNDLES
git
pip
lein
command-not-found
colorize
colored-man-pages
extract
zsh-users/zsh-autosuggestions
zsh-users/zsh-syntax-highlighting
l4u/zsh-output-highlighting
Tarrasch/zsh-bd
TamCore/autoupdate-oh-my-zsh-plugins
hlissner/zsh-autopair
unixorn/autoupdate-antigen.zshplugin
zsh-users/zsh-history-substring-search
vi-mode
EOBUNDLES

# hchbaw/auto-fu.zsh

# 1) source this file.
# source ~/.antigen/bundles/hchbaw/auto-fu.zsh/auto-fu.zsh
# # 2) establish `zle-line-init' containing `auto-fu-init' something like below.
# zle-line-init () {auto-fu-init;}; zle -N zle-line-init
# # 3) use the _oldlist completer something like below.
# zstyle ':completion:*' completer _oldlist _complete
# # (If you have a lot of completer, please insert _oldlist before _complete.)
# # 4) establish `zle-keymap-select' containing `auto-fu-zle-keymap-select'.
# zle -N zle-keymap-select auto-fu-zle-keymap-select
# # (This enables the afu-vicmd keymap switching coordinates a bit.)

# *Optionally* you can use the zcompiled file for a little faster loading on
# every shell startup, if you zcompile the necessary functions.
# *1) zcompile the defined functions. (generates ~/.zsh/auto-fu.zwc)
# A=/path/to/auto-fu.zsh; (zsh -c "source $A ; auto-fu-zcompile $A ~/.zsh")
# *2) source the zcompiled file instead of this file and some tweaks.
# source ~/.zsh/auto-fu; auto-fu-install
# *3) establish `zle-line-init' and such (same as a few lines above).


# # ci"
# autoload -U select-quoted
# zle -N select-quoted
# for m in visual viopp; do
#   for c in {a,i}{\',\",\`}; do
#     bindkey -M $m $c select-quoted
#   done
# done

# # ci{, ci(
# autoload -U select-bracketed
# zle -N select-bracketed
# for m in visual viopp; do
#   for c in {a,i}${(s..)^:-'()[]{}<>bB'}; do
#     bindkey -M $m $c select-bracketed
#   done
# done

# # surround
# autoload -Uz surround
# zle -N delete-surround surround
# zle -N add-surround surround
# zle -N change-surround surround
# bindkey -a cs change-surround
# bindkey -a ds delete-surround
# bindkey -a ys add-surround
# bindkey -M visual S add-surround

antigen theme $ZSH_THEME

antigen apply # Tell Antigen that you're done.

# -----------------------------------

HYPHEN_INSENSITIVE="true" # Use hyphen-insensitive completion.

# export UPDATE_ZSH_DAYS=1 # How often to auto-update (in days). # Not needed with Antigen

ENABLE_CORRECTION="true" # Enables command auto-correction.

COMPLETION_WAITING_DOTS="true" # Displays red dots whilst waiting for completion.

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Powerline theme (has to come after `source $ZSH/oh-my-zsh.sh`)
if [[ -r `python -m site --user-site`/powerline/bindings/zsh/powerline.zsh ]]; then
  source `python -m site --user-site`/powerline/bindings/zsh/powerline.zsh
else
  echo "Powerline theme doesn't exists, using default theme \"$ZSH_THEME\""
fi

if type nvim > /dev/null; then
  export VISUAL=nvim # Use NeoVim if installed, otherwise Vim
else
  export VISUAL=vim
fi
export EDITOR=$VISUAL

if [[ -r ~/.zshrc.private ]]; then
  source ~/.zshrc.private
fi

# Vi-mode
bindkey -v # This is also enabled by vi-mode plugin
KEYTIMEOUT=1

# Change cursor shape for different vi modes
function zle-keymap-select {
  if [[ $KEYMAP == vicmd ]] || [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ $KEYMAP == main ]] || [[ $KEYMAP == viins ]] || [[ $KEYMAP = '' ]] || [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() { zle-keymap-select 'beam'} # Start with beam shape cursor on zsh startup and after every command.

function expand-or-complete-or-cd() {
    if [[ $#BUFFER == 0 ]]; then
        BUFFER="cd "
        CURSOR=3
        # zle list-choices
        setopt MENU_COMPLETE # Always insert first tab completion after pressing `<Tab>`
        zle expand-or-complete
        unsetopt MENU_COMPLETE
    else
        zle expand-or-complete
    fi
}
zle -N expand-or-complete-or-cd
# bind to tab
bindkey '^I' expand-or-complete-or-cd

# Keybindings
# For list of keybindings run `man zshzle`, `zle -al` or `bindkey`
bindkey -s '^[l'   '^Qls^J'    # Alt-L clears text before running `ls`
bindkey -s '^[L'   '^Qls -a^J' # Alt-Shift-L also shows hidden files
bindkey -s '^[[2~' '^X^E'      # `Insert` key opens $EDITOR

bindkey '^P'     up-line-or-beginning-search
bindkey '^N'     down-line-or-beginning-search
bindkey '^[p'    history-substring-search-up
bindkey '^[n'    history-substring-search-down
bindkey '\e\C-?' backward-kill-word    # Alt-backspace
bindkey '^[[Z'   reverse-menu-complete # Shift-tab completes backwards

bindkey -M menuselect '^P' up-history
bindkey -M menuselect '^N' down-history

# Vi-mode config
bindkey '^F'  forward-char
bindkey '^[f' forward-word
bindkey '^B'  backward-char
bindkey '^[b' backward-word
bindkey '^_'  undo
bindkey '^U'  kill-whole-line
bindkey '^K'  kill-line
bindkey '^Q'  push-line # Clears the command line and restores after new command

bindkey -M vicmd -s '^[l' 'ccls^J'
bindkey -M vicmd -s '^[L' 'ccls -a^J'
bindkey -M vicmd -s '_' '^'
bindkey -M vicmd '^P'     up-line-or-beginning-search
bindkey -M vicmd '^N'     down-line-or-beginning-search
bindkey -M vicmd '^[p'    history-substring-search-up
bindkey -M vicmd '^[n'    history-substring-search-down
bindkey -M vicmd '\e\C-?' backward-kill-word

# ZSH-vimode-visual
# bindkey -M vivis 's ' vi-visual-surround-space
# bindkey -M vivis "s'" vi-visual-surround-squote
# bindkey -M vivis 's"' vi-visual-surround-dquote
# bindkey -M vivis 's(' vi-visual-surround-parenthesis
# bindkey -M vivis 's)' vi-visual-surround-parenthesis

# Create a new directory and enter it
function mkcd() {
  mkdir -p "$@" && cd "$@"
}

alias zshrc='nvim ~/.zshrc'
alias vimrc='nvim ~/.vimrc'
alias src='source ~/.zshrc'
alias ..='cd .. && ls'
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
alias m='make'
alias tree='tree -C'
alias installed='yaourt -Qqe'
alias b='bd 1'
alias open='xdg-open &>/dev/null'
alias errorlogs='journalctl --since=today'
alias screenkey='screenkey -t 1.5 -s small'
alias wifi='nmcli'
alias bats='bat --pager="less -mgi --underline-special --SILENT"'

# Git:
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

# Dotfiles
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias dot='dotfiles'
alias dots='dot status'

# Syntax highligting in less:
export LESSOPEN="| /bin/src-hilite-lesspipe.sh %s"
export LESS=" -R "
