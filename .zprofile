#!/bin/sh

export XDG_CONFIG_HOME="$HOME"/.config
export XDG_DATA_HOME="$HOME"/.local/share
export XDG_STATE_HOME="$HOME"/.local/state
export XDG_CACHE_HOME="$HOME"/.cache

export MANPATH="/usr/local/man:$MANPATH"
export VISUAL=nvim
export EDITOR=nvim
export EDITORCMD=$EDITOR
export STARSHIP_CONFIG=${XDG_CONFIG_HOME}/starship/starship.toml
export NNN_PLUG='f:finder;o:fzopen;p:mocplay;d:diffs;t:nmount;v:imgviu'

export RSTUDIO_CHROMIUM_ARGUMENTS="--no-sandbox" 

export ARCH=x86_64

export BEMENU_BACKEND="x11"
# export BEMENU_BACKEND="wayland"

if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
	exec startx
	# exec sway
fi
