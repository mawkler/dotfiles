# Launch tmux if there's no tmux session already running
if [[ ! $(tmux list-sessions 2> /dev/null) ]]; then exec tmux; fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

ZSH_THEME="agnoster" # Backup theme
DISABLE_AUTO_UPDATE="true"
export ANTIGEN_CACHE=false # Fixes issue with completion for azure-cli not working

# ------------- Antigen -------------

source /usr/share/zsh/share/antigen.zsh

autoload -Uz compinit && compinit

antigen use oh-my-zsh # Load the oh-my-zsh's library.
antigen bundles << EOBUNDLES
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
  zsh-users/zsh-completions
  l4u/zsh-output-highlighting
  mawkler/zsh-bd
  hlissner/zsh-autopair
  unixorn/autoupdate-antigen.zshplugin
  Aloxaf/fzf-tab
  olets/zsh-abbr@main
  lukechilds/zsh-better-npm-completion
EOBUNDLES

antigen theme romkatv/powerlevel10k
antigen apply # Tell Antigen that you're done.

# -----------------------------------

HYPHEN_INSENSITIVE="true"            # Use hyphen-insensitive completion
ENABLE_CORRECTION="true"             # Enables command auto-correction
COMPLETION_WAITING_DOTS="true"       # Displays red dots whilst waiting for completion
DISABLE_UNTRACKED_FILES_DIRTY="true" # Speeds up VCS status check in large repositories
KEYTIMEOUT=1                         # Speeds up mode switching
unsetopt autocd                      # Don't CD when typing the name of dirs

if type nvim &> /dev/null; then
  export VISUAL=nvim
else
  export VISUAL=vim
fi
export EDITOR=$VISUAL
export NVIM_MINIMAL=1 # Load Neovim with less plugins when called from zsh

# Work config
if [[ -r $HOME/.zsh/work.zsh ]]; then
  source $HOME/.zsh/work.zsh
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
FZF_COLORS="
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
  --color=border:#798294
"

export FZF_DEFAULT_OPTS="
  --history=$HOME/.fzf_history
  --history-size=10000
  --height 50%
  --pointer='▶'
  $FZF_COLORS
"

EXA_DIR_PREVIEW="exa \
  --color=always -T \
  --level=2 \
  --icons \
  --git-ignore \
  --git \
  --ignore-glob=.git \
"

# bat config is in `~/.config/bat/config`

export FZF_CTRL_T_OPTS="--preview 'bat --style=numbers --color=always --line-range :100 {}'"
export FZF_CTRL_T_COMMAND="rg --hidden --files --no-messages"
export FZF_ALT_C_COMMAND="fd --type directory -H --ignore-file ~/.ignore"
export FZF_ALT_C_OPTS="--preview=\"$EXA_DIR_PREVIEW {}\""

[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
[ -f /usr/share/fzf/completion.zsh   ] && source /usr/share/fzf/completion.zsh

# Alt-T: Like Fzf's Ctrl-T, but lets you select directories instead of files
fzf_select_directories() {
  local selected_dirs=$(fd --type directory --exclude .git \
    2> /dev/null \
    | fzf --multi --reverse --preview="$EXA_DIR_PREVIEW {}"
  )
  LBUFFER+=$(echo $selected_dirs | xargs)
  zle redisplay
}

zle     -N             fzf_select_directories
bindkey          '\et' fzf_select_directories
bindkey -M vicmd '\et' fzf_select_directories

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
  fd -t d --hidden --max-depth=1 | xargs -d $'\n' sh -c 'for arg do echo $arg `tree $arg | tail -n 1`; done' _ | column -t | sort -Vr -k 4n | tac
}

tree-pager() {
  exa --icons --color always --tree $@ | less -Fn
}

alias zshrc='nvim ~/.zshrc'
alias vimrc='nvim ~/.vimrc'
alias src='exec zsh'
alias listfiles='find . -type f -iname "*"'
alias xs='xargs -I % sh -c'
alias less='less -mgiJr --underline-special --SILENT'
alias xclip='xclip -selection c'
alias ls='exa --icons'
alias m='make'
alias tree='exa --icons --tree'
alias Tree='tree-pager'
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
alias rg="rg --hidden --smart-case"
alias fd="fd --hidden"
alias dump-dconf='dconf dump /org/gnome/shell/extensions/ > .dotfiles/gnome-extensions.dconf'
alias fix-screen='xset -dpms'
alias mvc='mullvad connect'
alias mvd='mullvad disconnect'
alias mvr='mullvad reconnect'

# Abbreviations are in ~/.config/zsh/abbreviations

# Git:
alias g='git'
alias gs='git status'
alias gl='git log --decorate'

# Like git diff, but ignores package-lock.json and yarn.lock in any subdirectory
function gd() {
  if  [[ -n "$1" ]]; then
    git diff --ignore-space-change "$1" -- ':!**/package-lock.json' ':!**/yarn.lock'
  else
    git diff --ignore-space-change -- ':!**/package-lock.json' ':!**/yarn.lock'
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

 # Pulls to master and then rebases into current branch
function grm() {
  if [[ 'git rev-parse --is-inside-work-tree 2>/dev/null' ]]; then
    echo "Rebasing onto `_master_branch`..."
    git pull --autostash origin `_master_branch`:`_master_branch`
    git rebase --autostash `_master_branch`
  else
    echo 'Not inside a git repository'
  fi
}

alias pull-all='ls -d */ | xargs -P10 -I {} sh -c "echo Pulling changes in {}... && git -C {} pull"'

alias gco='git checkout'
alias gcom='git checkout `_master_branch`'
alias gmm='git merge master'
alias gp='git pull --autostash'
alias gP='git push'
alias gb='git branch'
alias gw='git whatchanged'
alias ga='git add'
alias gcm='git commit -mv'
alias gcam='git commit -avm'
alias gca='git commit -av'
alias gcaa='git commit -av --amend'
alias gu='git diff HEAD@{1} HEAD'
alias gly='git log --since="yesterday"'
alias gr='git reset'
alias grc='git rebase --continue'
alias gra='git rebase --abort'
alias gdm='git diff `_master_branch`..HEAD'
alias gdu='diff upstream/`_master_branch`'
alias gru='git pull --rebase --autostash upstream `_master_branch`'
alias gsp='git stash pop'
alias gss='git stash show -p'
alias glm='git log `_master_branch`'
alias gldm='git log --decorate --oneline `_master_branch`..'
alias gds='git diff --staged'

# Dotfiles
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias dot='dotfiles'
alias dots='dot status'

# Completion for azure-cli
if [[ -r '/opt/az/bin/az.completion.sh' ]]; then
  source /opt/az/bin/az.completion.sh
fi

# Zoxide
eval "$(zoxide init zsh)"

# Alt-z - Zoxide with Fzf
fzf-zoxide() {
  eval "zi"
  zle accept-line
}
zle -N fzf-zoxide
bindkey '^[z' fzf-zoxide

# Zoxide's Fzf options
export _ZO_FZF_OPTS="
  --no-sort
  --keep-right
  --info=inline
  --layout=reverse
  --exit-0
  --select-1
  --bind=ctrl-z:ignore
  --preview-window=right
  --preview=\"$EXA_DIR_PREVIEW {2..} \"
  $FZF_DEFAULT_OPTS
"
alias cd=z
alias zoxide-add-directories="fd --type directory --max-depth 1 | xargs zoxide add"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# fzf-tab
# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# preview directory's content with exa when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'
# switch group using `ctr-B` and `ctrl-F`
zstyle ':fzf-tab:*' switch-group 'ctrl-B' 'ctrl-F'

# nvm
source /usr/share/nvm/init-nvm.sh
