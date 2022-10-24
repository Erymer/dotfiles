#!/usr/bin/bash
# Change permissions so it can be executed withot beign root

# The value of this constant must be output of the following command when the
# monitor you want to use as dock is connected to the HDMI port
# md5sum /sys/class/drm/card*-HDMI-A-1/edid | cut -f 1 -d " "
DOCK_MON_MD5HASH="8ce2f2999715042dbc42bc4bc9cf35ab"
WallpaperDirectory="${HOME}/Images/Wallpapers"

wallpaper(){
  feh --bg-fill "${WallpaperDirectory}/${1}"
}

randomWallpaper(){
  # Randomize wallpaper from directory
  feh --bg-fill --randomize "${WallpaperDirectory}/${1}/*"
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
xss-lock --transfer-sleep-lock -- xsecurelock &

# In some ocations unclutter can create problems with the mouse.
# If this happens use "unclutter -grab" or install unclutter-xfixes-git
# source: https://wiki.archlinux.org/index.php/unclutter
[ "$(pgrep "unclutter")" ] || unclutter & # Hides mouse if is not beign used

# Weird fix that prevents everything to look GIGANTIC
xrandr --dpi 96

wallpaper weeb/minimalist-hollow-1.png

if [ "$(md5sum /sys/class/drm/card*-HDMI-A-1/edid | cut -d " " -f 1)" = "$DOCK_MON_MD5HASH" ]; then
  dock &
fi

if [ "$HOSTNAME" = "Nostromo" ]; then
  polybar Nostromo &
  numlockx & # Turns on Num Lk
elif [ "$HOSTNAME" = "Serenity" ]; then
  polybar Serenity &
fi

# Only sync files if we are connected to a trusted network
sleep 2
currentNetwork=$(nmcli device | grep connected | awk '{print$4}')
acceptedNetworks=$(cat << EOF
Tenda_2CB810
Tenda_2CB810_5G
EOF
)

echo "${acceptedNetworks}" | grep -q "${currentNetwork}"

if [ $? -eq 0 ]; then
  notify-send "Valid sync network"
  source "${HOME}/Scripts/nextcloud-sync.sh" &
else
  notify-send "invalid network"
fi

# choice=$(echo "Sync nextcloud? (y/N): "| xargs -0 -I{} rofi -l 1 -dmenu -p "{}")
# if [[ "${choice}" = "y" ]] || [[ "${choice}" = "Y" ]]; then
#   source "$HOME/Scripts/nextcloud-sync.sh" &
# fi

conky &
