
alias B='cd ~/.magBin && eza --icons'

alias D='cd ~/10_Documents/ && eza --icons'

alias C='cd ~/.config && eza --icons --all'
alias S='cd ~/Scripts && eza --icons'

alias P='cd ~/20_Projects && eza --icons'

alias Z='cd ~/40_Notebooks/Zettel && eza --icons'

alias wifiscan='nmcli device wifi list'

push(){
  pushd "$@" && eza --icons
}

pop(){
  popd "$@" && eza --icons
}
