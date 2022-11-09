
alias B='cd ~/.magBin && exa --icons'

alias D='cd ~/Documents && exa --icons'
alias n='cd ~/Documents/Notes && exa --icons'
alias N='cd ~/Documents/Notebooks && exa --icons'

alias C='cd ~/.config && exa --icons --all'
alias S='cd ~/Scripts && exa --icons'

alias P='cd ~/Projects && exa --icons'
alias Ps='cd ~/Projects/ShellScript && exa --icons'
alias Pp='cd ~/Projects/Python && exa --icons'

alias Z='cd ~/Documents/Zettel && exa --icons'

alias wifiscan='nmcli device wifi list'

push(){
  pushd "$@" && exa --icons
}

pop(){
  popd "$@" && exa --icons
}
