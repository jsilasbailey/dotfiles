# Setup fzf
# ---------
if [[ ! "$PATH" == */opt/homebrew/opt/fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/opt/homebrew/opt/fzf/bin"
fi

# Set FZF colors based on macOS system theme
if defaults read -g AppleInterfaceStyle 2>/dev/null | grep -q Dark; then
  export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
    --highlight-line \
    --info=inline-right \
    --ansi \
    --layout=reverse \
    --border=none \
    --color=bg+:#272727 \
    --color=bg:#101010 \
    --color=border:#ffffff \
    --color=fg:#b0b0b0 \
    --color=fg+:#ffffff \
    --color=gutter:#101010 \
    --color=header:#ffffff \
    --color=hl+:#d9ba73 \
    --color=hl:#d9ba73 \
    --color=info:#50585d \
    --color=marker:#ff7676 \
    --color=pointer:#ffffff \
    --color=prompt:#ffffff \
    --color=query:#b0b0b0:regular \
    --color=scrollbar:#b0b0b0 \
    --color=separator:#ffffff \
    --color=spinner:#50585d \
  "
else
  export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
    --highlight-line \
    --info=inline-right \
    --ansi \
    --layout=reverse \
    --border=none \
    --color=bg+:#ebebeb \
    --color=bg:#faf9f5 \
    --color=border:#000000 \
    --color=fg:#3d3d3d \
    --color=fg+:#000000 \
    --color=gutter:#faf9f5 \
    --color=header:#000000 \
    --color=hl+:#b07700 \
    --color=hl:#b07700 \
    --color=info:#969ba5 \
    --color=marker:#ca0043 \
    --color=pointer:#000000 \
    --color=prompt:#000000 \
    --color=query:#101010:regular \
    --color=scrollbar:#000000 \
    --color=separator:#000000 \
    --color=spinner:#969ba5 \
  "
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/opt/homebrew/opt/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/opt/homebrew/opt/fzf/shell/key-bindings.zsh"
