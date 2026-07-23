# ensure dotfiles bin directory is loaded first
PATH="$HOME/.bin:/usr/local/sbin:$PATH"

if command -v mise &> /dev/null; then
  eval "$(mise activate zsh)"
fi

if command -v go &> /dev/null; then
  export PATH=$PATH:$(go env GOPATH)/bin
fi

# mkdir .git/safe in the root of repositories you trust
PATH=".git/safe/../../bin:$PATH"

export -U PATH
