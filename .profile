# Texlive
export PATH="/opt/texlive/2020/bin/x86_64-linux:$PATH"
export MANPATH="/opt/texlive/2020/texmf-dist/doc/man:$MANPATH"
export INFOPATH="/opt/texlive/2020/texmf-dist/doc/info:$INFOPATH"

export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

export DROPBOX="$HOME/Dropbox/"
export MARKDOWNS="$HOME/Dropbox/Dokument/Markdowns/"

if [[ $XDG_SESSION_TYPE == X11 ]]; then
	# Hide the mouse cursor on inactivity (only works on X)
	unclutter --timeout 1 --fork
fi

if [[ -x $HOME/.config/broot/launcher/bash/br ]]; then
	$HOME/.config/broot/launcher/bash/br
fi

export DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=1 # Fixes issue with `func` commands not working
export FUNCTIONS_CORE_TOOLS_TELEMETRY_OPTOUT=1 # Opt out of telemetry
export SAM_CLI_TELEMETRY=0                     # Opt out of SAM telemetry

export NEOVIDE_MULTIGRID="true" # Enable multigrid (smooth scrolling) for Neovide

# Work config
if [[ -r $HOME/.config/work.sh ]]; then
	source $HOME/.config/work.sh
fi

# Zk
export ZK_NOTEBOOK_DIR=$MARKDOWNS

# Go
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"

# Neovide
export NEOVIDE_FORK=true # Launch Neovide in a fork
