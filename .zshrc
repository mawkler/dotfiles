ZSH_THEME="agnoster" # Backup theme (gets overwritten by Powerline theme if available)
DISABLE_AUTO_UPDATE="true"

# ------------- Antigen -------------

source /usr/share/zsh/share/antigen.zsh

autoload -Uz compinit && compinit

antigen use oh-my-zsh # Load the oh-my-zsh's library.
antigen bundles << EOBUNDLES
  git
  pip
  npm
  lein
  command-not-found
  colorize
  colored-man-pages
  extract
  vi-mode
  zsh-users/zsh-autosuggestions
  zsh-users/zsh-syntax-highlighting
  zsh-users/zsh-history-substring-search
  l4u/zsh-output-highlighting
  Melkster/zsh-bd
  hlissner/zsh-autopair
  unixorn/autoupdate-antigen.zshplugin
  Aloxaf/fzf-tab
  olets/zsh-abbr
EOBUNDLES

antigen theme $ZSH_THEME
antigen apply # Tell Antigen that you're done.

# -----------------------------------

HYPHEN_INSENSITIVE="true"            # Use hyphen-insensitive completion
ENABLE_CORRECTION="true"             # Enables command auto-correction
COMPLETION_WAITING_DOTS="true"       # Displays red dots whilst waiting for completion
DISABLE_UNTRACKED_FILES_DIRTY="true" # Speeds up VCS status check in large repositories
KEYTIMEOUT=1                         # Speeds up mode switching
unsetopt autocd                      # Don't CD when typing the name of dirs

# Powerline theme (has to come after sourcing oh-my-zsh)
if [[ -r `python3 -m site --user-site 2> /dev/null`/powerline/bindings/zsh/powerline.zsh ]]; then
  export POWERLINE_SOURCE=`python3 -m site --user-site`/powerline
  source $POWERLINE_SOURCE/bindings/zsh/powerline.zsh
fi

if type nvim &> /dev/null; then
  export VISUAL=nvim
else
  export VISUAL=vim
fi
export EDITOR=$VISUAL
export NVIM_MINIMAL=1 # Load Neovim with less plugins when called from zsh

if [[ -r ~/.zshrc.private ]]; then
  source ~/.zshrc.private
fi

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

# Keybindings
# For list of keybindings run `man zshzle`, `zle -al` or `bindkey`
bindkey -s '^[l'   '^Qls^J'    # Alt-L clears text before running `ls`
bindkey -s '^[L'   '^Qls -a^J' # Alt-Shift-L also shows hidden files
bindkey -s '^[[2~' '^X^E'      # `Insert` key opens $EDITOR
bindkey -s '¤'     '$'         # `¤` means `$`

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
bindkey -M vicmd 'v'      visual-mode       # Use v for visual mode and V to
bindkey -M vicmd 'V'      edit-command-line # open current line in $VISUAL

# Fzf
export FZF_DEFAULT_OPTS="
  --history=$HOME/.fzf_history
  --history-size=10000
  --height 50%
  --pointer='▶'

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

# bat config  is in `~/.config/bat/config`

export FZF_CTRL_T_OPTS="--preview 'bat --style=numbers --color=always --line-range :100 {}'"
export FZF_CTRL_T_COMMAND='ag --hidden --ignore .git -g ""'
export FZF_ALT_C_COMMAND='fd --type directory -H --ignore-file ~/.agignore'
[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
[ -f /usr/share/fzf/completion.zsh   ] && source /usr/share/fzf/completion.zsh

# Create a new directory and enter it
mkcd() {
  mkdir -p $@ && cd $@
}

# Count the total number of files in directory
countfiles() {
  tree $@ | tail -n 1
}

# Count the number of files in each immediate subdirectory
countallfiles() {
  ls -d */ | xargs -d $'\n' sh -c 'for arg do echo $arg `tree $arg | tail -n 1`; done' _ | column -t | sort -Vr -k 4n | tac
}

alias zshrc='nvim ~/.zshrc'
alias vimrc='nvim ~/.vimrc'
alias src='exec zsh'
alias grep='grep -Iin --color=always'
alias listfiles='find . -type f -iname "*"'
alias xs='xargs -I % sh -c'
alias less='less -m -N -g -i -J --underline-special --SILENT'
alias xclip='xclip -selection c'
alias c='xclip -selection clipboard'
alias v='xclip -o'
alias ls='lsd'
alias m='make'
alias Tree='tree -C | less -Fn'
alias installed='yay -Qqe | bat'
alias remove-non-dependencies='sudo pacman -Rns $(pacman -Qtdq)'
alias open='xdg-open &>/dev/null'
alias errorlogs='journalctl --since=today'
alias screenkey='screenkey -t 1.5 -s small'
alias wifi='nmcli'
alias n='nmcli device wifi connect'
alias Bat='bat --pager="less -mgi --underline-special --SILENT"'
alias myip='hostname -i'
alias yaz='yay -Slq | fzf -m --preview "yay -Si {1}"| xargs -ro yay -S --noconfirm'
alias yaz-remove='yay -Qeq | fzf -m --preview "yay -Qi {1}" | xargs -ro yay -Rs'
alias mv='mv -i'
alias pdf_clip='curl -Ls `xclip -o` | (zathura - &)'
alias ag="ag --hidden --pager='less -R'"
alias dump-dconf='dconf dump /org/gnome/shell/extensions/ > .dotfiles/gnome-extensions.dconf'

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

# Delta
export DELTA_PAGER='less -mgi --underline-special --SILENT'

_master_branch() {
  if git rev-parse --quiet --verify master > /dev/null; then
    echo 'master'
  else
    echo 'main';
  fi
}

gcomr() {
  echo '==> git stash'
  git stash
  echo '==> git checkout `_master_branch`'
  git checkout `_master_branch`
  echo '==> git pull'
  git pull
  echo '==> git checkout -'
  git checkout -
  echo '==> git rebase `_master_branch`'
  git rebase `_master_branch`
  echo '==> git stash pop'
  git stash pop
}

alias gco='git checkout'
alias gcom='git checkout `_master_branch`'
alias gmm='git merge master'
alias gp='git pull --autostash'
alias gb='git branch'
alias gw='git whatchanged'
alias gcm='git commit -mv'
alias gcam='git commit -avm'
alias gca='git commit -av'
alias gu='git diff HEAD@{1} HEAD'
alias gly='git log --since="yesterday"'
alias gr='git rebase'
alias grc='git rebase --continue'
alias grm='git rebase `_master_branch`'

# Dotfiles
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias dot='dotfiles'
alias dots='dot status'

# Temporary fix to man pages not showing up
unset MANPATH
