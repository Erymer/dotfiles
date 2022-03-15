alias sudo='sudo ' # Recomended in https://wiki.archlinux.org/title/Sudo#Tips_and_tricks
alias magg='sudo '
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias fdisk='sudo fdisk'
alias sgdisk='sudo sgdisk'
alias sfdisk='sudo sfdisk'
alias losetup='sudo losetup'
alias mkfs.vfat='sudo mkfs.vfat'
alias mkfs.ext4='sudo mkfs.ext4'
alias lynx='lynx -vikeys -scrollbar -accept_all_cookies duckduckgo.com'
alias org='nvim -R +:Goyo +:%foldopen! -u ~/.magBin/org -'
alias scrot='scrot --quality 100 --select'
alias printscreen='scrot --quality 100 --select'
alias printscr='scrot --quality 100 --select'
alias pk='pkill'
alias v='nvim'
alias nv='nvim'
alias emacs='emacs --no-window-system'
alias rss="newsboat --refresh-on-start"
alias fastboot="sudo fastboot"
alias blk='lsblk --output name,label,path,size,mountpoint,fstype'
alias jctl='journalctl -p 3 -xb'
alias vmmount='sudo mount -t ext4 -o rw,noatime,noexec,loop,offset=2129408 ~/androidvm/android/android.vdi ~/androidvm/vmmount'
alias vmumount='sudo umount /dev/loop0'
alias fontsls='fc-list | less'
alias traducir='trans :es -brief'
alias y='yay'
alias mkarchiso='sudo mkarchiso'
alias docker='sudo docker'
alias please='sudo bash -c "$(fc -ln -1)"'
alias pls='sudo bash -c "$(fc -ln -1)"'
alias pager='bash -c "$(fc -ln -1)" | bat'
alias pg='bash -c "$(fc -ln -1)" | bat'
alias todolinux='todo new -l linux'

rpg () {
  rpg-cli "$@"
  cd "$(rpg-cli pwd)"
}

searchfile(){
  # Search file name that contains that word
  sudo find / -type f -iname "*$1*" 2> /dev/null
}

searchdir(){
  # Search directory name that contains that word
  sudo find / -type d -iname "*$1*" 2> /dev/null
}

searchname(){
  # Search exact name of file or directory
  sudo find / -iname "$1" 2> /dev/null
}

searchdir(){
  sudo find / -type d -iname "*$1*" 2> /dev/null
}

zerodisk(){
  sudo sgdisk --zap-all /dev/$1
  sudo wipefs --all --force /dev/$1
  sudo dd status=progress bs=8192 if=/dev/zero of=/dev/$1
}

randomdisk(){
  # source https://www.linuxglobal.com/quickly-fill-a-disk-with-random-bits-without-dev-urandom/
  local password=$(sudo dd if=/dev/urandom bs=1 count=60)
  local blk_device="/dev/${1}"
  local blk_device_size
  local choice

  lsblk --output name,label,path,size "${blk_device}"
  echo "[ERASING PARTITIONS]"
  sudo sgdisk --zap-all "${blk_device}" > /dev/null
  echo "[DELETING FILESYSTEM]"
  sudo wipefs --all --force "${blk_device}" > /dev/null

  echo "[CREATING NEW PARTITION]"
  sudo partprobe
  sudo sgdisk --set-alignment 2048 --clear "${blk_device}" > /dev/null
  sudo partprobe
  sudo sgdisk --new 0:0:0 "${blk_device}" > /dev/null

  echo "[ENCRYPTING PARTITION]"
  local blk_device_partition=$(lsblk -o path "${blk_device}" | grep --extended-regexp "${blk_device}"p\?1) 

  sudo cryptsetup close random &> /dev/null
  echo "$password" | sudo cryptsetup luksFormat "${blk_device_partition}" > /dev/null || exit
  echo "$password" | sudo cryptsetup open --type luks "${blk_device_partition}" random > /dev/null || exit

  echo "[FILLING PARTITIONS WITH ZERO'S]"
  blk_device_size=$(sudo blockdev --getsz /dev/mapper/random) > /dev/null
  sudo dd status=progress bs=8192 count=$((${blk_device_size} / 16)) if=/dev/zero of=/dev/mapper/random

  echo "[ERASING LUKS HEADER]"
  sudo cryptsetup close random > /dev/null
  sudo cryptsetup --batch-mode erase "${blk_device_partition}" > /dev/null

  echo "[CLEANING]"
  sudo partprobe
  sudo sgdisk --zap-all "${blk_device}" > /dev/null
  sudo partprobe
  sudo wipefs --all --force "${blk_device}" > /dev/null
}

yesdisk(){
  # source https://www.linuxglobal.com/quickly-fill-a-disk-with-random-bits-without-dev-urandom/
  local password=$(sudo dd if=/dev/urandom bs=1 count=60)
  local blk_device="/dev/${1}"
  local blk_device_size
  local choice

  lsblk --output name,label,path,size "${blk_device}"

  echo "[ERASING PARTITIONS]"
  sudo sgdisk --zap-all "${blk_device}" > /dev/null

  echo "[DELETING FILESYSTEM]"
  sudo wipefs --all --force "${blk_device}" > /dev/null

  echo "[CREATING NEW PARTITION]"
  sudo partprobe
  sudo sgdisk --set-alignment 2048 --clear "${blk_device}" > /dev/null
  sudo partprobe
  sudo sgdisk --new 0:0:0 "${blk_device}" > /dev/null

  echo "[ENCRYPTING PARTITION]"
  sudo cryptsetup close random &> /dev/null
  echo "$password" | sudo cryptsetup luksFormat "${blk_device}1" > /dev/null
  echo "$password" | sudo cryptsetup open --type luks "${blk_device}1" random > /dev/null

  echo "[CREATING FILESYSTEM]"
  sudo mkfs.ext4 -q /dev/mapper/random > /dev/null

  echo "[MOUNTING PARTITION]"
  local temp_dir=$(mktemp --directory)
  sudo mount /dev/mapper/random "${temp_dir}" > /dev/null
  sleep 5

  echo "[FILLING PARTITIONS WITH ZERO'S]"
  sudo yes 0 > "${temp_dir}/zero"

  echo "[UNMOUNTING PARTITION]"
  sudo umount /dev/mapper/random > /dev/null

  echo "[ERASING LUKS HEADER]"
  sudo cryptsetup close random > /dev/null
  sudo cryptsetup --batch-mode erase "${blk_device}1" > /dev/null
  
  echo "[CLEANING]"
  rmdir "${temp_dir}" > /dev/null
  sudo partprobe
  sudo sgdisk --zap-all "${blk_device}" > /dev/null
  sudo partprobe
  sudo wipefs --all --force "${blk_device}" > /dev/null
}

t(){
  tmux new-session \; \
        split-window -h \; \
        split-window -v \; \
        new-window \; \
        select-window -t 0 \; \
        select-pane -t 0 \; \
        attach
}


# Notepads
# via https://github.com/melloc/dotfiles/blob/master/zsh/zshrc
qn(){
  local file_path
  if [ -z "$1" ]; then
      file_path="quick-note-$(date +%d-%m).org"
  else
      file_path="${1}.org"
  fi
  nvim +:Goyo +startinsert "$HOME"/Documents/Notes/"${file_path}"
}

# alias sp="vim +set\ buftype=nofile +startinsert" ## A quick scratchpad from the shell
alias sp="nvim +:Goyo + /tmp/scratchpad.md"

acento() {
  tuxi $1 lleva acento
}

searchstring() {
  # $1 = String
  # $2 = Location

  grep --recursive --files-with-matches --word-regexp "$1" $2
}

py() {
  touch $1.py && chmod +x $1.py
}
alias wallpaper='feh --bg-fill'

# Package Manager
alias pacinstall='sudo pacman -S'
alias pacrm='sudo pacman -Rs'

# Homelab
alias amberjack='ping -c 2 192.168.100.93 && ssh amberjack'

# dd
alias dd='sudo dd status=progress' # Show progress during operation. 
# bs parameter optimized to know optimal parameter grep  BUFSIZ /usr/include/*.h
# Source https://www.linuxquestions.org/questions/linux-newbie-8/how-can-i-determine-bs-parameter-in-dd-command-4175587089/ https://wiki.archlinux.org/index.php/Dd#Create_disk_image
alias ddusba='sudo dd status=progress if=/dev/sda of=/home/mag/usba.dd bs=8M'
alias ddusbb='sudo dd status=progress if=/dev/sdb of=/home/mag/usbb.dd bs=8M'

#Tar
ctar() {
  file=$1
  tarball="$1.tgz"
  tar -zvcf ${tarball} ${file}
}

alias untar="tar -zxvf" # Unpack tarball
alias lstar="tar -tvf" # List tarball files

cenctar() {
  file=$1
  tarball="$1.tgz"

  tar -zvcf ${tarball} ${file} &&\
  gpg --recipient Marcelo --encrypt ${tarball} &&\
  rm ${tarball}
}

# Net
alias wifiscan='nmcli device wifi list'

# Config files shotcuts
alias alcf="nvim $HOME/.config/alias"
#Functions

# Comandos para recordar
# pacman -Qi programa = Lista dependencias opcionales. Puede servir para listar como instalar una funcion extra de algun programa

# Download audio from youtube
alias mp3="youtube-dl -f 140"
alias ytls="youtube-dl -F"

alias dotfiles="git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
