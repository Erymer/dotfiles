#!/bin/sh
# Cambiar permisos del archivo para poder acceder a el sin ser root
[ $(pgrep "nextcloud") ] || nextcloud &
[ $(pgrep "picom") ] || picom & # Instalar picom e inicializarlo para que ventanas puedan tener transparencia
[ $(pgrep "flameshot") ] || flameshot & # App para tomar capturas de pantalla
[ $(pgrep "pulseaudio") ] || pulseaudio & # Driver de audio
[ $(pgrep "plover") ] || plover &
[ $(pgrep "dunst") ] || dunst & # Notification server

