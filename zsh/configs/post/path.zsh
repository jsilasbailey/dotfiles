# ensure dotfiles bin directory is loaded first
PATH="$HOME/.bin:/usr/local/sbin:$PATH"

# Try loading ASDF from the regular home dir location
if [ -f "$HOME/.asdf/asdf.sh" ]; then
  . "$HOME/.asdf/asdf.sh"
# Othwerwise we might have it via brew
elif command -v brew &> /dev/null &&
  BREW_ASDF_DIR="$(brew --prefix asdf)" &&
  [ -f "$BREW_ASDF_DIR/libexec/asdf.sh" ]; then
  . "$BREW_ASDF_DIR/libexec/asdf.sh"
fi

# Add the global yarn bin to $PATH
if command -v yarn &> /dev/null
then
  export PATH="$(yarn global bin):$PATH"
fi

# mkdir .git/safe in the root of repositories you trust
PATH=".git/safe/../../bin:$PATH"

export -U PATH
