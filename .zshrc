ZSH_THEME="agnoster" # Backup theme (gets overwritten by Powerline theme if available)
DISABLE_AUTO_UPDATE="true"

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
Melkster/zsh-bd
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

ENABLE_CORRECTION="true" # Enables command auto-correction.

COMPLETION_WAITING_DOTS="true" # Displays red dots whilst waiting for completion.

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# autoload predict-on && predict-on # Always shows completions and suggestions

# Powerline theme (has to come after `source $ZSH/oh-my-zsh.sh`)
if [[ -r `python3 -m site --user-site 2> /dev/null`/powerline/bindings/zsh/powerline.zsh ]]; then
  export POWERLINE_SOURCE=`python3 -m site --user-site`/powerline
  source $POWERLINE_SOURCE/bindings/zsh/powerline.zsh
fi

if type nvim &> /dev/null; then
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

# Changes color of the matching string when completing
zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)(?)*==90=01}:${(s.:.)LS_COLORS}")'

LISTMAX=0
unsetopt LIST_AMBIGUOUS MENU_COMPLETE COMPLETE_IN_WORD
setopt AUTO_MENU AUTO_LIST LIST_PACKED

function expand-or-complete-or-cd() {
  if [[ $#BUFFER == 0 ]]; then
    BUFFER="cd "
    CURSOR=3
    # zle list-choices
    setopt MENU_COMPLETE # Always insert first tab completion after pressing `<Tab>`
    zle expand-or-complete
    unsetopt MENU_COMPLETE
  else
    echo -n "\e[31m...\e[0m"
    # avoid opening the list on the first expand
    unsetopt AUTO_LIST
    zle expand-or-complete
    setopt AUTO_LIST
    zle magic-space
    zle backward-delete-char
    zle expand-or-complete
    zle redisplay
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

bindkey -M vicmd -s '^[l' 'A^Qls^J'
bindkey -M vicmd -s '^[L' 'A^Qls -a^J'
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

# cd to selected directory using FZF using Alt-T
cdz() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
  zle reset-prompt
}
zle -N cdz{,}
bindkey '^[t' cdz

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
alias ls='exa -F'
alias m='make'
alias tree='tree -C'
alias installed='yay -Qqe | bat'
alias remove-non-dependencies='sudo pacman -Rns $(pacman -Qtdq)'
alias b='bd 1'
alias open='xdg-open &>/dev/null'
alias errorlogs='journalctl --since=today'
alias screenkey='screenkey -t 1.5 -s small'
alias wifi='nmcli'
alias bats='bat --pager="less -mgi --underline-special --SILENT"'
alias myip='hostname -i'
alias yaz='yay -Slq | fzf -m --preview "yay -Si {1}"| xargs -ro yay -S --noconfirm'
alias yaz-remove='yay -Qeq | fzf -m --preview "yay -Qi {1}" | xargs -ro yay -Rs'
alias mv='mv -i'
alias pdf_clip='curl -Ls `xclip -o` | (zathura - &)'
alias ag="ag --pager='less -R'"
alias dump-dconf="dconf dump /org/gnome/shell/extensions/ > .dotfiles/gnome-extensions.dconf"

# Git:
alias g='git'
alias gs='git status'
alias gl='git log --decorate'

# Like git diff, but ignores package-lock.json and yarn.lock in any subdirectory
function gd() {
  if  [[ -n "$1" ]]; then
    git diff "$1" -- ':!**/package-lock.json' ':!**/yarn.lock'
  else
    git diff -- ':!**/package-lock.json' ':!**/yarn.lock'
  fi
}

alias gco='git checkout'
alias gcom='git checkout master'
alias gmm='git merge master'
alias gp='git pull'
alias gb='git branch'
alias gw='git whatchanged'
alias gcm='git commit -m'
alias gcam='git commit -am'
alias gca='git commit -a'
alias gu='git diff HEAD@{1} HEAD'
alias gly='git log --since="yesterday"'

# Dotfiles
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias dot='dotfiles'
alias dots='dot status'

# bat config in ~/.config/bat/config

# Fzf
export FZF_DEFAULT_OPTS="
  --bind ctrl-j:accept,alt-k:up,alt-j:down
  --history=$HOME/.fzf_history
  --height 50%

  --color=fg:-1
  --color=fg+:#61afef
  --color=bg:-1
  --color=bg+:#444957
  --color=hl:#E06C75
  --color=hl+:#E06C75
  --color=gutter:-1
  --color=pointer:#61afef
  --color=marker:#98C379
  --color=header:#61afef
  --color=info:#98C379
  --color=spinner:#61afef
  --color=prompt:#c678dd
"

export FZF_CTRL_T_OPTS="--preview 'bat --style=numbers --color=always --line-range :100 {}'"
export FZF_CTRL_T_COMMAND='ag --hidden --ignore .git -g ""'
[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
[ -f /usr/share/fzf/completion.zsh   ] && source /usr/share/fzf/completion.zsh
