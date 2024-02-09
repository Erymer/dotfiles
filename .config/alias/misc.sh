alias sudo='sudo ' # Recomended in https://wiki.archlinux.org/title/Sudo#Tips_and_tricks
alias magg='sudo '
alias mag='sudo '
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias lynx='lynx -vikeys -scrollbar -accept_all_cookies duckduckgo.com'
alias printscreen='scrot --quality 100 --select'
alias printscr='scrot --quality 100 --select'
alias pk='pkill'
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
alias please='sudo bash -c "$(fc -ln -1)"'
alias pls='sudo bash -c "$(fc -ln -1)"'
alias pager='bash -c "$(fc -ln -1)" | bat'
alias pg='bash -c "$(fc -ln -1)" | bat'
alias open='xdg-open'
alias o='xdg-open'
alias b='bat'
alias q='exit'
alias dmesg='sudo dmesg -Tw'
alias otp='pass otp'
alias trls='transmission-remote -l'
alias tradd='transmission-remote -a'
alias trrm='transmission-remote -r -t'
alias trdel='transmission-remote -rad -t'

cdj() {
  number=${1}
  padded_number=$(printf "%02d.%02d" $((number / 100)) $((number % 100)))

  pushd ~/*/*/"${padded_number}"* || return

  eza --icons
}
 

v(){
  if [[ -z "${1}" ]]; then
    file=$(pwd)
  else
    file="${1}"
  fi

  nvim "${file}" 
}


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

zerodisk(){
  sudo sgdisk --zap-all "$1"
  sudo wipefs --all --force "$1"
  sudo dd status=progress bs=8192 if=/dev/zero of="$1"
}

searchstring() {
  # $1 = String
  # $2 = Location

  grep --recursive --files-with-matches --word-regexp "$1" "$2" 2> /dev/null

}

randomdisk(){
  # source https://www.linuxglobal.com/quickly-fill-a-disk-with-random-bits-without-dev-urandom/
  local password=$(sudo dd if=/dev/urandom bs=1 count=60)
  local blk_device="${1}"
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


# Notepads
# via https://github.com/melloc/dotfiles/blob/master/zsh/zshrc
qn(){
  local file_path
  if [ -z "$1" ]; then
      file_path="quick-note-$(date +%d-%m).md"
  else
      file_path="${1}.md"
  fi
  nvim +:Goyo +startinsert "${HOME}/10_Documents/11_Notes/${file_path}"
}

# alias sp="vim +set\ buftype=nofile +startinsert" ## A quick scratchpad from the shell
# alias sp="nvim +:Goyo +$ +startinsert + /tmp/scratchpad.md"
alias sp='nvim -c "normal G" +:Goyo +startinsert! /tmp/scratchpad.md'

alias wallpaper='feh --bg-fill'

# Package Manager
alias pacinstall='sudo pacman --noconfirm --needed -S'
alias pacrm='sudo pacman -Rs'
alias cacherm='sudo pacman -Scc; yay -Scc'

# dd
alias dd='sudo dd status=progress' # Show progress during operation. 
# bs parameter optimized to know optimal parameter grep  BUFSIZ /usr/include/*.h
# Source https://www.linuxquestions.org/questions/linux-newbie-8/how-can-i-determine-bs-parameter-in-dd-command-4175587089/ https://wiki.archlinux.org/index.php/Dd#Create_disk_image
alias ddusba='sudo dd status=progress if=/dev/sda of=/home/mag/usba.dd bs=8M'
alias ddusbb='sudo dd status=progress if=/dev/sdb of=/home/mag/usbb.dd bs=8M'

#Tar
ctar() {
  local file
  local tarball
  file=$1
  tarball="$1.tgz"
  # tar -vcf "${tarball}" "${file}" && gzip -9 "${tarball}"
  tar -zvcf "${tarball}" "${file}"
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

web() {
  local query
  query=$(echo $1 | tr " " "+")

  if command -v w3m &> /dev/null; then
    w3m "duckduckgo.com/?q=${query}"
  else
    echo "w3m not installed"
  fi
}

jpg(){
  # Transforms file to jpg
  local input_file output_file

  input_file="${1}" 
  output_file="${2}" 

  ffmpeg -i "${input_file}" "${output_file}".jpg
}

dserver(){
  local root_dir

  root_dir=$(git rev-parse --show-toplevel)

  python "${root_dir}"/manage.py runserver 
}


n ()
{
    # Block nesting of nnn in subshells
    [ "${NNNLVL:-0}" -eq 0 ] || {
        echo "nnn is already running"
        return
    }

    # The behaviour is set to cd on quit (nnn checks if NNN_TMPFILE is set)
    # If NNN_TMPFILE is set to a custom path, it must be exported for nnn to
    # see. To cd on quit only on ^G, remove the "export" and make sure not to
    # use a custom path, i.e. set NNN_TMPFILE *exactly* as follows:
    #      NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
    export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

    # Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
    # stty start undef
    # stty stop undef
    # stty lwrap undef
    # stty lnext undef

    # The command builtin allows one to alias nnn to n, if desired, without
    # making an infinitely recursive alias
    command nnn "$@"

    [ ! -f "$NNN_TMPFILE" ] || {
        . "$NNN_TMPFILE"
        rm -f "$NNN_TMPFILE" > /dev/null
    }
}
