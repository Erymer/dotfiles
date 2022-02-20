WIFI=$(nmcli device | grep 'wifi' | cut --delimiter " " --fields 1 2> /dev/null)
ETHERNET=$(nmcli device | grep 'ethernet' | cut --delimiter " " --fields 1 2> /dev/null)
HDMI=$(xrandr | grep --ignore-case "hdmi" | cut --delimiter=" " --fields 1 2> /dev/null) 
ALIAS_DIRECTORY=$HOME/.config/alias
USB=/run/media/$USER
