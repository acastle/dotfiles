# My Dotfiles

Repository for my dotfiles, contains configurations for:

- zsh + p10k
- nvim
- git

## Installation

Steps to install dotfiles on a new machine.

### Ubuntu / Debian

```bash
add-apt-repository ppa:neovim-ppa/stable
apt update
apt install tmux git zsh stow curl neovim
git clone https://github.com/acastle/dotfiles.git --recurse-submodules ~/.dotfiles && \ 
  pushd ~/.dotfiles && \
  ./install.sh && \
  popd
```
