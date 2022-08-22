# load our own completion functions
fpath=(~/.zsh/completion $fpath)

# https://formulae.brew.sh/formula/zsh-completions
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$(brew --prefix)/share/zsh/site-functions:$FPATH
fi

# completion; use cache if updated within 24h
autoload -Uz compinit

if [[ -n $HOME/.zcompdump(#qN.mh+24) ]]; then
  compinit -d $HOME/.zcompdump;
else
  compinit -C;
fi;

# disable zsh bundled function mtools command mcd
# which causes a conflict.
compdef -d mcd
