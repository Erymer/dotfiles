alias amount='udisksctl mount -b /dev/sda1 && cd /run/media/mag'
alias aumount='cd "$HOME" && udisksctl unmount -b /dev/sda1'
alias bmount='udisksctl mount -b /dev/sdb1 && cd /run/media/mag'
alias bumount='cd "$HOME" && udisksctl unmount -b /dev/sdb1'
alias cmount='udisksctl mount -b /dev/sdc1 && cd /run/media/mag'
alias cumount='cd "$HOME" && udisksctl unmount -b /dev/sdc1'

alias udm="udisksctl mount -b"
alias udu="udisksctl unmount -b"
alias mount='sudo mount'
alias umount='sudo umount'


mntamberjack() {
    realpath -q --canonicalize-existing ~/amberjack 2>&1 /dev/null
    if [ $? -eq 1 ]; then
        mkdir -p ~/amberjack
    fi
    sshfs amberjack:/ ~/amberjack
}

umntamberjack() {
    fusermount3 -u ~/amberjack && rmdir ~/amberjack
}

