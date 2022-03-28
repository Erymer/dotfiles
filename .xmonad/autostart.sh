#!/usr/bin/bash
# Change permissions so it can be executed withot beign root

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
# [ "$(pgrep "nextcloud")" ] || nextcloud &
xss-lock --transfer-sleep-lock -- xsecurelock &

# In some ocations unclutter can create problems with the mouse.
# If this happens use "unclutter -grab" or install unclutter-xfixes-git
# source: https://wiki.archlinux.org/index.php/unclutter
[ "$(pgrep "unclutter")" ] || unclutter & # Hides mouse if is not beign used

# Wierd fix that prevents everything to look GIGANTIC
xrandr --dpi 96

# The value of this constant must be the md5 hash of the file in
# /sys/class/drm/card1-HDMI-A-1/edid when the monitor that we want to use as
# dock monitor is connected
DOCK_MON_MD5HASH="add29654d7cab036da741bee9fd391fd"

# feh --bg-fill --randomize /home/mag/Images/Wallpapers/vision/*
feh --bg-fill  "${HOME}"/Images/Wallpapers/weeb/cookie-monster.png

if [ "$(md5sum /sys/class/drm/card1-HDMI-A-1/edid | cut -d " " -f 1)" = "$DOCK_MON_MD5HASH" ]; then
  dock &
fi

if [ "$HOSTNAME" = "Nostromo" ]; then
  polybar Nostromo &
  numlockx & # Turns on Num Lk
elif [ "$HOSTNAME" = "Serenity" ]; then
  polybar Serenity &
fi

choice=$(echo "Sync nextcloud? (y/N): "| xargs -0 -I{} rofi -l 1 -dmenu -p "{}")
if [[ "${choice}" = "y" ]] || [[ "${choice}" = "Y" ]]; then
  source "$HOME/Scripts/nextcloud-sync.sh"
fi
