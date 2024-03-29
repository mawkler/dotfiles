# Texlive
export PATH="/opt/texlive/2020/bin/x86_64-linux:$PATH"
export MANPATH="/opt/texlive/2020/texmf-dist/doc/man:$MANPATH"
export INFOPATH="/opt/texlive/2020/texmf-dist/doc/info:$INFOPATH"

export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

export DROPBOX="$HOME/Dropbox/"
export MARKDOWNS="$HOME/Dropbox/Dokument/Markdowns/"

# Unclutter (hides the mouse cursor)
unclutter --timeout 1 --fork

source /home/melker/.config/broot/launcher/bash/br

export NEOVIDE_MULTIGRID="true" # Enable multigrid (smooth scrolling) for Neovide

# Work config
if [[ -r $HOME/.config/work.sh ]]; then
	source $HOME/.config/work.sh
fi

# Zk
export ZK_NOTEBOOK_DIR=$MARKDOWNS
