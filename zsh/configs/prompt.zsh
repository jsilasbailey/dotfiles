# Minimal prompt:
#
# [dir] :>                                                        git-branch
#
# ":>" is green when the last command succeeded, red when it failed.

autoload -Uz add-zsh-hook
setopt prompt_subst

# Show the current git branch if set
_prompt_git_branch() {
  local ref
  ref=$(git symbolic-ref --short HEAD 2>/dev/null) \
    || ref=$(git rev-parse --short HEAD 2>/dev/null) \
    || { _prompt_git=''; return }
  _prompt_git="$ref"
}

add-zsh-hook precmd _prompt_git_branch

# Add a blank line before prompts except for the first one in a new shell
_prompt_gap=''
_prompt_gap_set() {
  [[ -n $_prompt_gap_armed ]] && _prompt_gap=$'\n'
  _prompt_gap_armed=1
}
add-zsh-hook precmd _prompt_gap_set

PROMPT='${_prompt_gap}%F{blue}[%1~]%f %(?.%F{green}.%F{red}):>%f '
RPROMPT='%F{yellow}${_prompt_git}%f'
