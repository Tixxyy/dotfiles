#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

BACKUPDIR="$DIR/BACKUP"
if [ ! -d $BACKUPDIR ]; then mkdir $BACKUPDIR; fi

declare -A MAPPINGS
MAPPINGS=( # Assumes that the parent folders already exist
	[".nvimrc"]="$HOME/.config/nvim/init.vim"
	["vscode.settings.json"]="$HOME/.config/Code/User/settings.json"
)
SOURCEFILES=(.nvimrc vscode.settings.json .vimrc .zshrc .tmux.conf)

for i in ${SOURCEFILES[@]}; do
	if [ ! -f "$DIR/$i" ]; then break; fi # not found in dotfiles

	if [ ${MAPPINGS[$i]} ]; then # specify the endpoint. By default the home dir
		endpoint="${MAPPINGS[$i]}"
	else 
		endpoint="$HOME/$i"
	fi

	if [ -e "$endpoint" ] && [ ! -L "$endpoint" ]; then # if a non sym link exists, back it up
		mv $endpoint $BACKUPDIR/
	fi

	ln -fs $DIR/$i $endpoint
done
