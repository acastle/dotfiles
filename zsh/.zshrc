export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
export ZSH_CUSTOM="$HOME/.oh-my-zsh-custom"
export GPG_TTY=$(tty)

plugins=(git)
source $ZSH/oh-my-zsh.sh

for f in $HOME/.shell_config/*; do source $f; done
[[ -d "$HOME/.shell_config_local/" ]] && for f in $HOME/.shell_config_local/*; do source $f; done

[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
fpath=(~/.zsh/completion $fpath)
autoload -Uz compinit
compinit

