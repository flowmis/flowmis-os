# -*- coding: utf-8 -*-
import os
import re
import socket
import subprocess
from libqtile import qtile
from libqtile.config import Click, Drag, Group, KeyChord, Key, Match, Screen
from libqtile.command import lazy
from libqtile import layout, bar, widget, hook
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal
from typing import List

###Start Verbesserung Floating Windows###
floating_window_index = 0

def float_cycle(qtile, forward: bool):
    global floating_window_index
    floating_windows = []
    for window in qtile.current_group.windows:
        if window.floating:
            floating_windows.append(window)
    if not floating_windows:
        return
    floating_window_index = min(floating_window_index, len(floating_windows) -1)
    if forward:
        floating_window_index += 1
    else:
        floating_window_index += 1
    if floating_window_index >= len(floating_windows):
        floating_window_index = 0
    if floating_window_index < 0:
        floating_window_index = len(floating_windows) - 1
    win = floating_windows[floating_window_index]
    win.cmd_bring_to_front()
    win.cmd_focus()

@lazy.function
def float_cycle_backward(qtile):
    float_cycle(qtile, False)

@lazy.function
def float_cycle_forward(qtile):
    float_cycle(qtile, True)
###Ende Verbesserung Floating Windows (2 Keybindings mit den hier definierten Funktionen machen es dann anwendbar!)###

mod = "mod4"
keys = [ Key([mod], "Return", lazy.spawn("alacritty"), desc='Launches My Terminal'),
        #weiss nicht weshalb aber macht irgendwie dass ich mit doppel Fn Taste den App Launcher starten kann
         # Key([], "XF86AudioRaiseVolume", lazy.spawn('pamixer -i 2'), desc='lauter'),
         Key([mod], "period", float_cycle_forward, desc='FloatingWindow vor/hinter ein anderes bringen'),
         Key([mod], "comma", float_cycle_backward, desc='FloatingWindow vor/hinter ein anderes bringen'),
         # Key([], "XF86AudioLowerVolume", lazy.spawn('pamixer -d 2'), desc='leiser'),
         # Key([], "XF86AudioMute", lazy.spawn('pamixer -t'), desc='leiser'),
         # Key([], "XF86MonBrightnessUp", lazy.spawn('brightnessctl s 5%+'), desc='heller'),
         # Key([], "XF86MonBrightnessDown", lazy.spawn('brightnessctl s 5%-'), desc='dunkler'),
         # Key([], "XF86Cut", lazy.spawn('simplescreenrecorder'), desc='Screenrecord1'),
         # Key([], "F7", lazy.spawn('deepin-screen-recorder'), desc='Screenrecord2'),
         # Key([], "Print", lazy.spawn('gnome-screenshot -i'), desc='Screenshot1'),
         Key([], "print", lazy.spawn('flameshot gui'), desc='Screenshot2'),
         Key([mod], "e", lazy.spawn('emacs ~/Dropbox/2nd-brain/org-roam-notes/roam-orga/home.org'), desc='EMACS'),
         Key([mod], "w", lazy.spawn('nitrogen --random --set-scaled /home/flowmis/FlowmisOS/Backgrounds'), desc="Wallpaperwechsel"),
         Key([mod], "t", lazy.spawn('emacsclient -ce "(shell)"'), desc='eshell in neuem Frame'), #erlaubt mir mit Shortcut schnell Einträge in Einkaufsliste etc. zu machen durch capture templates
         # Key([mod], "a", lazy.spawn("sh /home/flowmis/.config/rofi/launchers/misc/launcher.sh"), desc='AppLauncher'),
         Key([mod], "d", lazy.spawn('pcmanfm'), desc='Explorer'),
         Key([mod], "b", lazy.spawn("brave"), desc='Bravebrowser'),
         Key([mod], "Tab", lazy.next_layout(), desc='Toggle through layouts'),
         Key([mod], "c", lazy.window.kill(), desc='Kill active window'),
         Key([mod], "n", lazy.spawn('emacsclient -ne "(+org-capture/open-frame)"'), desc='Capture Templates'), #erlaubt mir mit Shortcut schnell Einträge in Einkaufsliste etc. zu machen durch capture templates
         Key([mod], "r", lazy.restart(), desc='Restart Qtile'),
         Key([mod], "q", lazy.shutdown(), desc='Shutdown Qtile'),
         ### Treetab controls
         Key([mod, "shift"], "h", lazy.layout.move_left(), desc='Move up a section in treetab'),
         Key([mod, "shift"], "l", lazy.layout.move_right(), desc='Move down a section in treetab'),
         ### Window controls
         Key([mod], "Down", lazy.layout.shuffle_down(), lazy.layout.section_down(), desc='Move windows down in current stack'),
         Key([mod], "Up", lazy.layout.shuffle_up(), lazy.layout.section_up(), desc='Move windows up in current stack'),
         Key([mod], "Left", lazy.layout.shrink(), lazy.layout.decrease_nmaster(), desc='Shrink window (MonadTall), decrease number in master pane (Tile)'),
         Key([mod], "Right", lazy.layout.grow(), lazy.layout.increase_nmaster(), desc='Expand window (MonadTall), increase number in master pane (Tile)'),
         Key([mod], "f", lazy.window.toggle_fullscreen(), desc='toggle fullscreen'),
         ### Stack controls
         Key([mod], "space", lazy.layout.next(), desc='Switch window focus to other pane(s) of stack'),
         Key([mod, "shift"], "space", lazy.layout.toggle_split(), desc='Toggle between split and unsplit sides of stack'),
        ]

groups = [Group("-1-", layout='monadtall'),
          Group("-2-", layout='monadtall'),
          Group("-3-", layout='monadwide'),
          Group("-4-", layout='monadwide'),
          Group("-5-", layout='zoomy'),
          Group("-6-", layout='floating')]
# Allow MODKEY+[0 through 9] to bind to groups, see https://docs.qtile.org/en/stable/manual/config/groups.html
# MOD4 + index Number : Switch to Group[index]
# MOD4 + shift + index Number : Send active window to another Group
from libqtile.dgroups import simple_key_binder
dgroups_key_binder = simple_key_binder("mod4")

layout_theme = {"border_width": 2, "margin": 8, "border_focus": "000000", "border_normal": "1D2330"}
layouts = [
    #layout.Bsp(**layout_theme),
    #layout.Stack(stacks=2, **layout_theme),
    #layout.Columns(**layout_theme),
    #layout.RatioTile(**layout_theme),
    #layout.VerticalTile(**layout_theme),
    #layout.Matrix(**layout_theme),
    #layout.Max(**layout_theme),
    #layout.Stack(num_stacks=2),
    #layout.RatioTile(**layout_theme),
    #layout.Tile(shift_windows = True, border_width = 1, margin = 4,
    #    border_focus = 'e1acff', border_normal = '1D2330'),
    #layout.Tile(shift_windows=True, **layout_theme),
    layout.MonadWide(**layout_theme),
    layout.MonadTall(**layout_theme),
    layout.Zoomy(**layout_theme),
    layout.Floating(**layout_theme)
    #layout.TreeTab(
    #    font = "Ubuntu",
    #    fontsize = 10,
    #    sections = ["--1--", "--2--", "--3--", "--4--"],
    #    section_fontsize = 10,
    #    border_width = 2,
    #    bg_color = "1c1f24",
    #    active_bg = "c678dd",
    #    active_fg = "000000",
    #    inactive_bg = "a9a1e1",
    #    inactive_fg = "1c1f24",
    #    padding_left = 0,
    #    padding_x = 0,
    #    padding_y = 5,
    #    section_top = 10,
    #    section_bottom = 20,
    #    level_shift = 8,
    #    vspace = 3,
    #    panel_width = 200
    #),
]

colors = [["#282c34", "#282c34"],
          ["#1c1f24", "#1c1f24"],
          ["#dfdfdf", "#dfdfdf"],
          ["#ff6c6b", "#ff6c6b"],
          ["#98be65", "#98be65"],
          ["#da8548", "#da8548"],
          ["#51afef", "#51afef"],
          ["#c678dd", "#c678dd"],
          ["#46d9ff", "#46d9ff"],
          ["#a9a1e1", "#a9a1e1"],
          ["#000000", "#000000"]]

prompt = "{0}@{1}: ".format(os.environ["USER"], socket.gethostname())

##### DEFAULT WIDGET SETTINGS #####
widget_defaults = dict(
    font="Ubuntu Bold",
    fontsize = 10,
    padding = 2,
    background=colors[10]
)
extension_defaults = widget_defaults.copy()

def init_widgets_list():
    widgets_list = [
            widget.CurrentLayoutIcon(
                       background = colors[10],
                       padding = 0,
                       scale = 0.7
                       ),
            widget.WindowCount(
                       background = colors[10],
                       fontsize = 12,
                       padding = 10,
                       ),
            widget.Clock(
                       background = colors[10],
                       format = "%A, %B %d - %H:%M ",
                       fontsize = 12,
                       padding = 10
                       ),
            widget.TextBox(text = '|', background = colors[10], foreground = '474747', padding = 10, fontsize = 14),
            widget.GroupBox(
                       active = colors[2],
                       inactive = colors[6],
                       highlight_color = colors[1],
                       highlight_method = "line",
                       this_current_screen_border = colors[6],
                       this_screen_border = colors [4],
                       other_current_screen_border = colors[6],
                       other_screen_border = colors[4],
                       foreground = colors[6],
                       background = colors[10]
                       ),
            widget.TextBox(text = '|', background = colors[10], foreground = '474747', padding = 10, fontsize = 14),
            widget.WindowName(
                       foreground = colors[2],
                       background = colors[10],
                       padding = 0
                       ),
            widget.TextBox(text = '|', background = colors[10], foreground = '474747', padding = 10, fontsize = 14),
            widget.Net(
                       background = colors[10],
                       ),
            widget.TextBox(text = '|', background = colors[10], foreground = '474747', padding = 10, fontsize = 14),
            widget.CryptoTicker(
                       background = colors[10],
                       padding = 10
                       ),
            widget.CryptoTicker(
                       background = colors[10],
                       padding = 10,
                       crypto = "ETH"
                       ),
            widget.CryptoTicker(
                       background = colors[10],
                       padding = 10,
                       crypto = "ADA"
                       ),
            widget.TextBox(text = '|', background = colors[10], foreground = '474747', padding = 10, fontsize = 14),
            widget.Systray(
                       background = colors[10],
                       padding = 5
                       ),
            widget.PulseVolume(
                       background = colors[10],
                       fmt = 'Vol: {}',
                       padding = 5
                       ),
            widget.BatteryIcon(
                       background = colors[10],
                       padding = 5,
                       scale = 1.1,
                       ),
            ]
    return widgets_list

def init_widgets_screen1():
    widgets_screen1 = init_widgets_list()
    del widgets_screen1[9:10]               # Slicing removes unwanted widgets (systray) on Monitors 1,3
    return widgets_screen1

def init_widgets_screen2():
    widgets_screen2 = init_widgets_list()
    return widgets_screen2                 # Monitor 2 will display all widgets in widgets_list

def init_screens():
    return [Screen(top=bar.Bar(widgets=init_widgets_screen1(), opacity=0.85, size=30)),
            Screen(top=bar.Bar(widgets=init_widgets_screen2(), opacity=0.85, size=20)),
            Screen(top=bar.Bar(widgets=init_widgets_screen1(), opacity=0.85, size=20))]

if __name__ in ["config", "__main__"]:
    screens = init_screens()
    widgets_list = init_widgets_list()
    widgets_screen1 = init_widgets_screen1()
    widgets_screen2 = init_widgets_screen2()

def window_to_prev_group(qtile):
    if qtile.currentWindow is not None:
        i = qtile.groups.index(qtile.currentGroup)
        qtile.currentWindow.togroup(qtile.groups[i - 1].name)

def window_to_next_group(qtile):
    if qtile.currentWindow is not None:
        i = qtile.groups.index(qtile.currentGroup)
        qtile.currentWindow.togroup(qtile.groups[i + 1].name)

def window_to_previous_screen(qtile):
    i = qtile.screens.index(qtile.current_screen)
    if i != 0:
        group = qtile.screens[i - 1].group.name
        qtile.current_window.togroup(group)

def window_to_next_screen(qtile):
    i = qtile.screens.index(qtile.current_screen)
    if i + 1 != len(qtile.screens):
        group = qtile.screens[i + 1].group.name
        qtile.current_window.togroup(group)

def switch_screens(qtile):
    i = qtile.screens.index(qtile.current_screen)
    group = qtile.screens[i - 1].group
    qtile.current_screen.set_group(group)

mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_app_rules = []  # type: List
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False

floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    # default_float_rules include: utility, notification, toolbar, splash, dialog,
    # file_progress, confirm, download and error.
    *layout.Floating.default_float_rules,
    Match(title='Confirmation'),      # tastyworks exit box
    Match(title='Viewnior'),        # qalculate-gtk
    Match(title='Alacritty'),        # qalculate-gtk
    Match(wm_class='kdenlive'),       # kdenlive
    Match(wm_class='pinentry-gtk-2'), # GPG key password entry
])
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

@hook.subscribe.startup_once
def start_once():
    home = os.path.expanduser('~')
    subprocess.call([home + '/.config/qtile/autostart.sh'])

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
