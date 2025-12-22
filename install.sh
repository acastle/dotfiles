#!/usr/bin/env zsh

DOT_FILES=$HOME/.dotfiles

# Git
ln -sf $DOT_FILES/git/.gitconfig $HOME/.gitconfig
ln -sf $DOT_FILES/git/.gitignore $HOME/.gitignore

# Tmux
ln -sf $DOT_FILES/tmux/.tmux.conf $HOME/.tmux.conf

# Zsh
ln -sf $DOT_FILES/zsh/.zshrc $HOME/.zshrc
ln -sf $DOT_FILES/zsh/.p10k.zsh $HOME/.p10k.zsh
ln -sf $DOT_FILES/zsh/.oh-my-zsh $HOME/.oh-my-zsh
ln -sf $DOT_FILES/zsh/.zsh $HOME/.zsh
ln -sf $DOT_FILES/zsh/.shell_config $HOME/.shell_config

# Config directories
mkdir -p $HOME/.config
ln -sf $DOT_FILES/nvim/.config/nvim $HOME/.config/nvim
ln -sf $DOT_FILES/alacritty/.config/alacritty $HOME/.config/alacritty
ln -sf $DOT_FILES/k9s/.config/k9s $HOME/.config/k9s
ln -sf $DOT_FILES/ghostty/.config/ghostty $HOME/.config/ghostty

# Powerlevel10k theme
ZSH_CUSTOM=$HOME/.oh-my-zsh-custom
THEME_DIR=$ZSH_CUSTOM/themes
mkdir -p $THEME_DIR
ln -sf $DOT_FILES/powerlevel10k $THEME_DIR/powerlevel10k

