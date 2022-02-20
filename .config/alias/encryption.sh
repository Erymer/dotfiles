# Alias related with  enyryption
# GPG
# Asymetric encrption (encripted file is bin)
aenc() {
    gpg --recipient $2 --encrypt $1;
}

alias magaenc='gpg --recipient Marcelo --encrypt'


# Armored Asymetric encryption (encripted file is text)
aaenc() {
    gpg --armor --recipient $2 --encrypt $1;
}

alias magaaenc='gpg --armor --recipient Marcelo --encrypt'

# Symetric encryption
alias senc="gpg --symmetric --cipher-algo AES256"
alias asenc="gpg --armor --symmetric --cipher-algo AES256"

decrypt() {
    input=$1
    output=$(echo $1 | sed 's/\.\(asc\|gpg\)//g')

    realpath --canonicalize-existing $1 &&\
    gpg --output ${output} --decrypt ${input}
}

passgen(){
    # Generates passphrase and stores it in pass
    passphrase=$($HOME/Scripts/Python/passmith/passmith.py --simple-mode)
    echo $passphrase | pass insert -e $1
    pass show --clip $1
}

# TAR
tardecrypt () {
    input=$1
    output=$(echo $1 | sed 's/\.\(asc\|gpg\)//g')

    realpath --canonicalize-existing ${input} &&\
    gpg --output ${output} --decrypt ${input} &&\
    tar -zxvf ${output} &&\
    rm ${input} ${output}

}

# Encripted FS
alias cryptsetup='sudo cryptsetup'
cryptfs() {
    # Create an encripted fs
    sudo cryptsetup -y -v luksFormat $1 &&
    sudo cryptsetup open $1 cryptmag &&
    sudo mkfs.ext4 /dev/mapper/cryptmag &&
    sudo cryptsetup close cryptmag
    
}

acryptmount() {
    sudo mkdir -p /run/media/mag/cryptmag &&
    sudo cryptsetup open /dev/sda"$1" cryptmag &&
    sudo mount /dev/mapper/cryptmag /run/media/mag/cryptmag
}

bcryptmount() {
    sudo mkdir -p /run/media/mag/cryptmag &&
    sudo cryptsetup open /dev/sdb$1 cryptmag &&
    sudo mount /dev/mapper/cryptmag /run/media/mag/cryptmag
}

ccryptmount() {
    sudo mkdir -p /run/media/mag/cryptmag &&
    sudo cryptsetup open /dev/sdc$1 cryptmag &&
    sudo mount /dev/mapper/cryptmag /run/media/mag/cryptmag
}

keymount(){
    sudo mkdir -p /run/media/mag/keys &&
    sudo cryptsetup open /dev/sd"$1"1 keys &&
    sudo mount /dev/mapper/keys /run/media/mag/keys

    sudo mkdir -p /run/media/mag/wallet &&
    sudo cryptsetup open /dev/sd"$1"2 wallet &&
    sudo mount /dev/mapper/wallet /run/media/mag/wallet
}

cryptumount() {
    sudo umount /run/media/mag/cryptmag
    sudo cryptsetup close cryptmag &&
    sudo rmdir /run/media/mag/cryptmag
}

keyumount() {
    sudo umount /run/media/mag/keys
    sudo cryptsetup close keys &&
    sudo rmdir /run/media/mag/keys

    sudo umount /run/media/mag/wallet
    sudo cryptsetup close wallet &&
    sudo rmdir /run/media/mag/wallet
}
