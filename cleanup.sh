#!/usr/bin/env zsh

STOW_FOLDERS="git,tmux,zsh,nvim"

DOT_FILES=$HOME/.dotfiles

pushd $DOT_FILES
for folder in $(echo $STOW_FOLDERS | sed "s/,/ /g"); do
	echo "Removing $folder"
	stow -D $folder
done
popd

rm $HOME/.oh-my-zsh-custom/custom/themes/powerlevel10k
