export ZSH="$HOME/.oh-my-zsh"
export ZSH_CUSTOM="$HOME/.oh-my-zsh-custom"
export GPG_TTY=$(tty)

plugins=(git)
source $ZSH/oh-my-zsh.sh

for f in $HOME/.shell_config/*; do source $f; done
[[ -d "$HOME/.shell_config_local/" ]] && for f in $HOME/.shell_config_local/*; do source $f; done

fpath=(~/.zsh/completion $fpath)
autoload -Uz compinit 
if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
	compinit;
else
	compinit -C;
fi;
