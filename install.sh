#!/usr/bin/env zsh

STOW_FOLDERS="git,tmux,zsh,nvim,alacritty,k9s,starship"

DOT_FILES=$HOME/.dotfiles

pushd $DOT_FILES
for folder in $(echo $STOW_FOLDERS | sed "s/,/ /g"); do
	stow -D $folder
	stow $folder
done
popd

ZSH_CUSTOM=$HOME/.oh-my-zsh-custom
THEME_DIR=$ZSH_CUSTOM/themes
mkdir -p $THEME_DIR

