# FZF config
# Use ~~ as the trigger sequence instead of the default **
export FZF_COMPLETION_TRIGGER='**'

# Options to fzf command
export FZF_COMPLETION_OPTS='--border --info=inline'

_fe() {
  IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
}


# alias fd='cd $HOME && cd $(find * -type d | fzf) && exa --icons'
_fd() {
  cd "$HOME"
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir" && eza --icons
}

_fuzzy_dirs(){
  local dir
  dir=$(find "${HOME}" -maxdepth 3 -type d -not -name '.*' | fzf)

  cd "$dir" && eza --icons
}


_tmux_sessionizer() {
  local cmd_name="tmux-sessionizer"
  if hash "$cmd_name" 2>/dev/null; then
    "$cmd_name"
  else
    echo "Command not found: $cmd_name"
  fi
}


# zle -N _tmux_sessionizer_widget _tmux_sessionizer
# bindkey '^f' _tmux_sessionizer_widget

bindkey -s '^f' "ts\n"


# vim:ft=zsh
