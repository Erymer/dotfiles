alias usb='cd /run/media/mag/'
alias cp="cp --interactive"  # Confirm before overwriting something
alias copy="rsync -avi --info=progress1" 
alias df='df --human-readable'
alias duh='du -h'
alias du1='du --human-readable --max-depth=1 --all | sort -hr 2> /dev/null | less'
alias rm='rm -I'  # Prevents epic mistakes
alias free='free -m'  # Show sizes in MB
alias l='eza --icons'
alias la='eza --long --all --icons'
alias ll='eza --long --icons'
alias ex="chmod +x"

alias copy="rsync -avi --info=progress1" 

if hash rsync 2>/dev/null; then
  # alias cpv="rsync -ah --info=progress2"
  alias cpv="rsync -ah --info=progress2 --no-inc-recursive --stats"    # progress bar
  alias rcopy="rsync -av --progress -h"
  alias rmove="rsync -av --progress -h --remove-source-files"
  alias rupdate="rsync -avu --progress -h"
  alias rsynchronize="rsync -avu --delete --progress -h"
fi
