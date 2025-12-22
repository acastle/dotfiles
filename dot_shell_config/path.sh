go_bin=$(which go)
if [[ -x "$go_bin" ]]; then
	export PATH=$(go env GOPATH)/bin:$PATH
fi

export PATH="$HOME/.cargo/bin:$PATH"
export PATH=/usr/local/share/python:$PATH
export PATH="/usr/local/opt/openssl@3/bin:$PATH"
export PATH="${PATH}:${HOME}/.krew/bin"
