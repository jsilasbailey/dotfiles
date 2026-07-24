# load our own completion functions
fpath=(~/.zsh/completion $fpath)

# https://formulae.brew.sh/formula/zsh-completions
_brew_prefix=${HOMEBREW_PREFIX:-/opt/homebrew}
if [[ -d $_brew_prefix ]]; then
  FPATH=$_brew_prefix/share/zsh-completions:$_brew_prefix/share/zsh/site-functions:$FPATH
fi
unset _brew_prefix

# scala-cli completions (macOS install location)
if [[ $OSTYPE == darwin* ]]; then
  _scalacli_comp="$HOME/Library/Application Support/ScalaCli/completions/zsh"
  [[ -d $_scalacli_comp ]] && fpath=($_scalacli_comp $fpath)
  unset _scalacli_comp
fi

# completion; use cache if updated within 24h
autoload -Uz compinit

_zcompdump_stale=($HOME/.zcompdump(#qN.mh+24))
if (( $#_zcompdump_stale )); then
  compinit -d $HOME/.zcompdump
else
  compinit -C -d $HOME/.zcompdump
fi
unset _zcompdump_stale

# disable zsh bundled function mtools command mcd
# which causes a conflict.
compdef -d mcd
