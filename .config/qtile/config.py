# Crear siguiente shellscript en ~/.config/qtile/autostart.sh
#!/bin/sh
# ~/.dropbox-dist/dropboxd &
# picom & # Instalar picom e inicializarlo para que ventanas puedan tener transparencia
# flameshot & #App para tomar capturas de pantalla
# # Cambiar los permisos de este archivo para que puedas acceder a el sin ser root

# Instalar font 'Fira Mono' version OTF usando pacman.

from libqtile.config import Key, Screen, Group, Drag, Click
from libqtile.lazy import lazy
from libqtile import layout, bar, widget, hook
import os, subprocess # Librerias necesarias para ejecutar hook de autostart
from typing import List  # noqa: F401

# Asignacion de variables de colores
black = '#282828'
red = '#CC241D'
green = '#98971A'
yellow = '#D79921'
blue = '#458588'
purple = '#B16286'
aqua = '#689D6A'
gray = '#A89984'
orange = '#D65D0E'
white = '#EBDBB2'

mod = "mod4"

@hook.subscribe.startup
def autostart():
    home = os.path.expanduser('~/.config/qtile/autostart.sh')
    subprocess.call([home])

keys = [
    # Switch between windows in current stack pane
    Key([mod], "j", lazy.layout.down()),
    Key([mod], "k", lazy.layout.up()),
    Key([mod], "h", lazy.layout.left()),
    Key([mod], "l", lazy.layout.right()),

    # Move windows up or down in current stack
    Key([mod, "control"], "j", lazy.layout.shuffle_down()),
    Key([mod, "control"], "k", lazy.layout.shuffle_up()),
    Key([mod, "control"], "h", lazy.layout.shuffle_left()),
    Key([mod, "control"], "l", lazy.layout.shuffle_right()),

    # Switch window focus to other pane(s) of stack
    Key([mod], "space", lazy.layout.next()),

    # Swap panes of split stack
    Key([mod, "shift"], "space", lazy.layout.rotate()),

    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key([mod, "shift"], "Return", lazy.layout.toggle_split()),
    Key([mod], "Return", lazy.spawn("alacritty")),
    Key([mod], "t",lazy.spawn("emacs")),
    Key([mod], "Up", lazy.spawn("sh -c 'pactl set-sink-mute 0 false ; pactl set-sink-volume 0 +5%'")),
    Key([mod], "Down", lazy.spawn("sh -c 'pactl set-sink-mute 0 false ; pactl set-sink-volume 0 -5%'")),

    # Toggle between different layouts as defined below
    Key([mod, "shift"], "Tab", lazy.next_layout()),
    Key([mod], "q", lazy.window.kill()),

    Key([mod, "control"], "r", lazy.restart()),
    Key([mod, "control"], "q", lazy.shutdown()),
    # Key([mod], "r", lazy.spawncmd()), # Se puede usar esto en vez de dmenu
    Key([mod], "d", lazy.spawn("dmenu_run")),
    Key([mod], "n", lazy.spawn("alacritty -e ranger")),

    Key([mod], "c", lazy.layout.grow()),
    Key([mod], "g", lazy.layout.shrink()),
    Key([mod], "r", lazy.layout.normalize()),
    # Key([mod], "o", lazy.layout.maximize()),

    Key([mod], "2", lazy.to_screen(0)),
    Key([mod], "1", lazy.to_screen(1)),
    Key([mod], "Tab", lazy.next_screen()),

    
]

groups = [
    Group('WWW'),
    Group('File Nav'),
    Group('Work'),
    Group('Chat'),
    Group('Music'),
]

keys.extend([

    Key([mod], "a", lazy.group['WWW'].toscreen()),
    Key([mod], "o", lazy.group['File Nav'].toscreen()),
    Key([mod], "e", lazy.group['Work'].toscreen()),
    Key([mod], "u", lazy.group['Chat'].toscreen()),
    Key([mod], "i", lazy.group['Music'].toscreen()),

    Key([mod, "shift"], "a", lazy.window.togroup("WWW", switch_group=True)),
    Key([mod, "shift"], "o", lazy.window.togroup("File Nav", switch_group=True)),
    Key([mod, "shift"], "e", lazy.window.togroup("Work", switch_group=True)),
    Key([mod, "shift"], "u", lazy.window.togroup("Chat", switch_group=True)),
    Key([mod, "shift"], "i", lazy.window.togroup("Music", switch_group=True)),
])


# groups = [Group(i) for i in "aoeu"]

# for i in groups:
    # keys.extend([
        # # mod1 + letter of group = switch to group
        # Key([mod], i.name, lazy.group[i.name].toscreen()),
        # # mod1 + shift + letter of group = switch to & move focused window to group
        # Key([mod, "shift"], i.name, lazy.window.togroup(i.name, switch_group=True)),
        # # Or, use below if you prefer not to switch to that group.
        # # # mod1 + shift + letter of group = move focused window to group
        # # Key([mod, "shift"], i.name, lazy.window.togroup(i.name)),
    # ])

layouts = [
    layout.Max(),
    # layout.Stack(num_stacks=2),
    # Try more layouts by unleashing below layouts.
    # layout.Bsp(),
    # layout.Columns(),
    # layout.Matrix(),
    layout.MonadTall(border_focus = yellow),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

widget_defaults = dict(
    font='Fira Mono Bold',
    fontsize=14,
    padding=3,
    foreground=white,
)
extension_defaults = widget_defaults.copy()

num_screens = 2,

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.CurrentLayout(),
                widget.Spacer(20),
                widget.GroupBox(fontsize=11,font='Fira Mono Bold',foreground=red),
                widget.Prompt(),
                widget.WindowName(),
                widget.Systray(),
                widget.Clock(format='%d/%m/%Y %a %I:%M %p'),
                widget.TextBox("Volume:"),
                widget.Volume(),
            ],
            24, background = black, opacity = 0.8,
        ),
        wallpaper='~/Images/Wallpapers/mdjrqy_1920x1080.png',
        wallpaper_mode='fill',
    ),

    Screen(
        # top=bar.Bar(
        #     [
        #         widget.CurrentLayout(),
        #         widget.GroupBox(),
        #         widget.Prompt(font='Fira Mono'),
        #         widget.WindowName(),
        #         widget.Clock(format='%Y-%m-%d %a %I:%M %p'),
        #     ],
        #     24, background =black, opacity=0.8,
        # ),
        wallpaper='~/Images/Wallpapers/mdjrqy_1920x1080.png',
        wallpaper_mode='fill',
    ),

]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
main = None
follow_mouse_focus = False
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    {'wmclass': 'confirm'},
    {'wmclass': 'dialog'},
    {'wmclass': 'download'},
    {'wmclass': 'error'},
    {'wmclass': 'file_progress'},
    {'wmclass': 'notification'},
    {'wmclass': 'splash'},
    {'wmclass': 'toolbar'},
    {'wmclass': 'confirmreset'},  # gitk
    {'wmclass': 'makebranch'},  # gitk
    {'wmclass': 'maketag'},  # gitk
    {'wname': 'branchdialog'},  # gitk
    {'wname': 'pinentry'},  # GPG key password entry
    {'wmclass': 'ssh-askpass'},  # ssh-askpass
])
auto_fullscreen = True
focus_on_window_activation = "smart"



# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
