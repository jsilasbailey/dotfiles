# ensure dotfiles bin directory is loaded first
PATH="$HOME/.bin:/usr/local/sbin:$PATH"

if command -v mise &> /dev/null; then
  eval "$(mise activate zsh)"
fi

if [[ -d ${GOPATH:-$HOME/go}/bin ]]; then
  export PATH=$PATH:${GOPATH:-$HOME/go}/bin
fi

# mkdir .git/safe in the root of repositories you trust
PATH=".git/safe/../../bin:$PATH"

export -U PATH
