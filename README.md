# My Dotfiles

Repository for my dotfiles, contains configurations for:

- zsh + p10k
- nvim
- git

## Installation

Steps to install dotfiles on a new machine.

### Ubuntu / Debian

```bash
apt update
apt install tmux git zsh stow
git clone https://github.com/acastle/dotfiles.git --recurse-submodules ~/.dotfiles \ 
  && pushd ~/.dotfiles \
  && ./install.sh \
  && popd
```
