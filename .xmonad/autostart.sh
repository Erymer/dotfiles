#!/usr/bin/env bash

# Change permissions so it can be executed without beign root

export XSECURELOCK_PASSWORD_PROMPT=kaomoji

# The value of this constant must be output of the following command when the
# monitor you want to use as dock is connected to the HDMI port
# `md5sum /sys/class/drm/card*-HDMI-A-1/edid | cut -f 1 -d " "`
DOCK_MON_MD5HASH="8ce2f2999715042dbc42bc4bc9cf35ab"

setWallpaper(){
  feh --bg-fill "${@}" 
}

randomWallpaper(){
  # Randomize wallpaper from directory
  feh --bg-fill --randomize "${1}"
}

# PICOM
# picom must be runned with --backend glx flag so that xsecurelock can work correctly
# otherwhise shows an error saying that the compositor doesn't work.
# If there is any problem with the compositor there are more possible solutions in: 
# https://github.com/google/xsecurelock/issues/97
# For example you con also set env variable so that xsecurelock doesn't use
# composite obscurer.
# export XSECURELOCK_COMPOSITE_OBSCURER=0
# or deactivate compositor only for xsecurelock:
# export XSECURELOCK_NO_COMPOSITE=1
# If there's any issue you can take any of this actions.
[ "$(pgrep "picom")" ] || picom --backend glx & 
[ "$(pgrep "dunst")" ] || dunst &
[ "$(pgrep "gpg-agent")" ] || gpg-agent &

# Autolock
# https://github.com/google/xsecurelock
xset s 300 5 &
xss-lock -n /usr/lib/xsecurelock/dimmer -l -- xsecurelock &

# In some ocations unclutter can create problems with the mouse.
# If this happens use "unclutter -grab" or install unclutter-xfixes-git
# source: https://wiki.archlinux.org/index.php/unclutter
[ "$(pgrep "unclutter")" ] || unclutter & # Hides mouse if is not beign used

# Weird fix that prevents everything to look GIGANTIC
xrandr --dpi 96

setWallpaper ~/20_Areas/29_Images/wallhaven-zywgxy_1920x1080.png

if [ "$HOSTNAME" = "Nostromo" ]; then
  polybar Nostromo &
  numlockx & # Turns on Num Lk
elif [ "$HOSTNAME" = "Serenity" ]; then
  polybar Serenity &
fi

if [ "$(md5sum /sys/class/drm/card*-HDMI-A-1/edid | cut -d " " -f 1)" = "$DOCK_MON_MD5HASH" ]; then
  dock &
  sleep 2
  setWallpaper ~/20_Areas/29_Images/wallhaven-zywgxy_2560x1080.png ~/20_Areas/29_Images/wallhaven-zywgxy_1920x1080.png 
fi

setxkbmap -layout mag # For some reason plover needs this to work properly.

nextcloud &

conky &
