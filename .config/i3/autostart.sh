#!/usr/bin/bash
# Cambiar permisos del archivo para poder acceder a el sin ser root

# PICOM
# picom debe correrse con --backend glx para que funcione xsecurelock correctamente
# De lo contrario sale un error que dice que no funciona el compositor
# Si hay algún problema con el compositor hay más soluciones en:
# https://github.com/google/xsecurelock/issues/97
# Como por ejemplo también se pueden configurar env variables para que xsecurelock
# no use composite obscurer: 
# export XSECURELOCK_COMPOSITE_OBSCURER=0
# o desactivarlo para xsecurelock:
# export XSECURELOCK_NO_COMPOSITE=1
# Si hay algur problema, tomar estas acciones
[ "$(pgrep "picom")" ] || picom --backend glx & 

[ "$(pgrep "dunst")" ] || dunst & # Notification server

[ "$(pgrep "gpg-agent")" ] || gpg-agent &

# [ "$(pgrep "nextcloud")" ] || nextcloud &
# En algunas ocasiones unclutter puede provocar problemas con el mouse.
# Si es así usar "unclutter -grab" o instalar unclutter-xfixes-git
# https://wiki.archlinux.org/index.php/unclutter
[ "$(pgrep "unclutter")" ] || unclutter & # Hides mouse if is not beign used

# Arreglo raro que tuve que hacer porque hay un bug en xorg-server
xrandr --dpi 96

# En esta constante poner el resultado de md5sum
# /sys/class/drm/card0-HDMI-A-1/edid cuando este conectado el monitor que
# queramos usar como dock
DOCK_MON="add29654d7cab036da741bee9fd391fd"

sed -i 's/size: 9/size: 7/' ~/.config/alacritty/alacritty.yml

# feh --bg-fill --randomize /home/mag/Images/Wallpapers/vision/*
# feh --bg-fill --randomize /home/mag/Images/Wallpapers/formula-one/*
feh --bg-fill  $HOME/Images/Wallpapers/weeb/cookie-monster.png

if [ "$(xrandr | grep -i "hdmi" | cut -d " " -f 2)" = "connected" ]; then
  if [ "$(md5sum /sys/class/drm/card0-HDMI-A-1/edid | cut -d " " -f 1)" = "$DOCK_MON" ]; then
    dock &
  fi
fi

if [ "$HOSTNAME" = "Nostromo" ]; then
  polybar Nostromo &
elif [ "$HOSTNAME" = "Serenity" ]; then
  polybar Serenity &
fi
