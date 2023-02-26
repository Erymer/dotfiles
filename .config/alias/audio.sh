# Audio control
# Este comando lista las tarjetas y perfiles que tiene cada tarjeta para poder editar comando 'audiotoanalog' y 'audiotohdmi'. 
# Index senala el número que ira en set-card-profile
# output y off indica opciones posibles para formatos de salida o para apagar esa salida
# active profile: indica que profile esta activo en esa tarjeta
# Para que esta salida salga en pavucontrol es necesario que tenga activo un profile
alias audiols='pacmd list-cards | grep "index:\|output:\|off:\|active profile:"'

# Dreadnought
# Esta solo tiene una tarjeta que envia audio por salida analoga y hdmi. Por eso no es necesario apagar las demás
if [ $HOST = "Dreadnought" ]; then
    alias ath='pactl set-card-profile 0 output:hdmi-stereo'
    alias ata='pactl set-card-profile 0 output:analog-stereo'

# Nostromo
# Tiene varias tarjetas por donde puede salir el audio y se puede hacer que
# tenga varias salidas al mismo tiempo. Para evitar esta complicacion se apagan
# las demás tarjetas y solo se deja activada una.
elif [ $HOST = "Nostromo" ]; then
    # Headphones
    alias atp='pactl set-card-profile 0 off &&\
                pactl set-card-profile 1 off &&\
                pactl set-card-profile 2 output:analog-stereo+input:analog-stereo &&\
                pactl set-card-profile 3 off'
    # HDMI
    alias ath='pactl set-card-profile 0 off &&\
                pactl set-card-profile 1 output:hdmi-stereo &&\
                pactl set-card-profile 2 off &&\
                pactl set-card-profile 3 off'

    # Laptop Speakers
    alias ata='pactl set-card-profile 0 off &&\
                pactl set-card-profile 1 off &&\
                pactl set-card-profile 2 off &&\
                pactl set-card-profile 3 output:analog-stereo'

    # Este comando activa todas las salidas para poder controlarlas con pavucontrol
    alias audioall='pactl set-card-profile 0 output:hdmi-stereo &&\
                    pactl set-card-profile 1 output:hdmi-stereo &&\
                    pactl set-card-profile 2 output:analog-stereo &&\
                    pactl set-card-profile 3 output:analog-stereo'
fi

alias mute='pamixer --mute'
alias unmute='pamixer --unmute'
alias mx='pulsemixer'

spotify() {
    if [ ! $(pgrep "spotifyd") ]; then
        spotifyd
    fi

    spt
}

