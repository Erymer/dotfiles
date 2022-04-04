alias usb='cd /run/media/mag/'
alias cp="cp --interactive"  # Confirm before overwriting something
alias copy="rsync -avi --info=progress1"  # Confirm before overwriting something
alias df='df --human-readable'
alias du='du -h'
alias du1='du --human-readable --max-depth=1 --all | sort -hr 2> /dev/null | less'
alias rm='rm -I'  # Prevents epic mistakes
alias free='free -m'  # Show sizes in MB
alias l='exa --icons'
alias ls='exa --icons'
# alias la='exa --long --all --icons --no-permissions --no-user'
# alias ll='exa --long --icons --no-permissions --no-user'
alias la='exa --long --all --icons'
alias ll='exa --long --icons'
alias ex="chmod +x"

# btrfs
alias snaproot="sudo btrfs subvolume snapshot / /.snapshots/$(date +%d-%b-%g-%H:%M)"
alias snaphome="sudo btrfs subvolume snapshot /home /home/.snapshots/$(date +%d-%b-%g-%H:%M)"
