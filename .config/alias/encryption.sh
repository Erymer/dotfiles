# Alias related with  enyryption

# GPG
aenc() {
  gpg --recipient "${2}" --encrypt "${1}"
}

aaenc() {
  gpg --armor --recipient "${2}" --encrypt "${1}"
}


# Symetric encryption
alias senc="gpg --symmetric --cipher-algo AES256"
alias asenc="gpg --armor --symmetric --cipher-algo AES256"


decrypt() {
  input="${1}"
  output=$(echo "$1" | sed 's/\.\(asc\|gpg\)//g')
  realpath --canonicalize-existing "${1}" &&\
  gpg --output "${output}" --decrypt "${input}"
}


# Encripted FS
cryptfs() {
  # Create an encripted fs
  sudo cryptsetup -y -v luksFormat "${1}" &&
  sudo cryptsetup open "${1}" cryptmag &&
  sudo mkfs.ext4 /dev/mapper/cryptmag &&
  sudo cryptsetup close cryptmag
}


cryptmount() {
  sudo mkdir -p /run/media/mag/cryptmag &&
  sudo cryptsetup open "${1}" cryptmag &&
  sudo mount /dev/mapper/cryptmag /run/media/mag/cryptmag
}


cryptumount() {
  sudo umount /run/media/mag/cryptmag
  sudo cryptsetup close cryptmag &&
  sudo rmdir /run/media/mag/cryptmag
}
