from libqtile import bar, layout, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal

mod = "mod4"
terminal = guess_terminal()

##################################################################################### Farben

colors = [["#FBF1C7", "#FBF1C7"],   #0
          ["#F2E5BC", "#F2E5BC"],   #1
          ["#00606B", "#00606B"],   #2
          ["#613E53", "#613E53"],   #3
          ["#C27DA7", "#C27DA7"],   #4
          ["#00606B", "#00606B"],   #5
          ["#613E53", "#613E53"],   #6
          ["#C275A7", "#C275A7"],   #7
          ["#D65D0E", "#D65D0E"],   #8
          ["#9D0006", "#9D0006"],   #9
          ["#000000", "#000000"],   #10
          ["#FFFFFF", "#FFFFFF"],   #11
          ["#7F001E", "#7F001E"],   #12
          ["#F0F0F0", "#F0F0F0"],   #13
          ["#EBDBB2", "#EBDBB2"],   #14
          ["#D5C4A1", "#D5C4A1"],   #15
          ["#BDAE93", "#BDAE93"],   #16
          ["#A89584", "#A89584"],   #17
          ["#504945", "#504945"],   #18
          ["#3C3836", "#3C3836"],   #19
          ["#282828", "#282828"],   #20
          ["#1D2021", "#1D2021"],   #21
          ["#B16286", "#B16286"]]   #22

##################################################################################### Keybindings
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

keys = [
    ### Fenster bewegen und layout wählen
    Key([mod], "period", float_cycle_forward, desc='FloatingWindow vor/hinter ein anderes bringen'),
    Key([mod], "comma", float_cycle_backward, desc='FloatingWindow vor/hinter ein anderes bringen'),
    Key([mod], "o", lazy.spawn('emacsclient -cF "((visibility . nil))" -e "(emacs-run-launcher)"'), desc="Emacs as run launcher"),
    Key([mod], "c", lazy.window.kill(), desc="Kill focused window"),
    Key([mod], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "Return", lazy.layout.next(), desc="Move window focus to other window"),
    Key([mod], "f", lazy.window.toggle_fullscreen(), desc='toggle fullscreen'),
    Key([mod, "shift"], "Left", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "Right", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "Down", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "Up", lazy.layout.shuffle_up(), desc="Move window up"),
    Key([mod], "Left", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod], "Right", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod], "Down", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod], "Up", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    Key([mod, "shift"], "Return", lazy.layout.toggle_split(), desc="Wechsel zwischen solit und full stack"), #Vergößerung/Verkleinerung einers Fensters im Stack (wenn dieses gesplitet ist)
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod, "shift"], "space", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),
    ### Programme starten
    Key([], "print", lazy.spawn('flameshot gui'), desc='Screenshot2'),
    Key([mod], "w", lazy.spawn('nitrogen --random --set-scaled /home/flowmis/flowmis-os/Backgrounds/dunkel'), desc="Wallpaperwechsel"),
    Key([mod, "shift"], "w", lazy.spawn('nitrogen --random --set-scaled /home/flowmis/flowmis-os/Backgrounds/hell'), desc="Wallpaperwechsel"),
    Key([mod], "e", lazy.spawn('emacsclient -c'), desc='EMACS'),    #'emacs  ~/cloud/life/raum/.org/home.org' wenn man bestimmte Datei beim Start öffnen will
    Key([mod], "space", lazy.spawn('emacsclient -c --eval "(eshell)"'), desc="Launch Eshell"),
    Key([mod, "shift"], "space", lazy.spawn('emacsclient -ce "(shell)"'), desc='shell in neuem Frame'), #erlaubt mir mit Shortcut schnell Einträge in Einkaufsliste etc. zu machen durch capture templates
    Key([mod, "control"], "space", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod], "p", lazy.spawn('keepassxc /home/flowmis/cloud/life/energie/self-sovereignity/privacy-security/passwörter/hotpassw.kdbx'), desc='Passwortmanager'),    #'emacs ~/cloud/life/raum/home.org' wenn man bestimmte Datei beim Start öffnen will
    Key([mod], "s", lazy.spawn('spotify-launcher'), desc="Spotify"),
    Key([mod], "d", lazy.spawn('pcmanfm'), desc='Explorer'),
    Key([mod], "b", lazy.spawn("brave"), desc='Bravebrowser'),
    Key([mod, "control"], "g", lazy.spawn("brave --app=https://chat.openai.com/"), desc='BraveApp-GPT'),
    Key([mod], "t", lazy.spawn('telegram-desktop'), desc='Telegram'),    #'emacs  ~/cloud/life/raum/.org/home.org' wenn man bestimmte Datei beim Start öffnen will
    Key([mod, "control"], "t", lazy.spawn("brave --app=https://de.tradingview.com/"), desc='Tradingview'),
    Key([mod, "control"], "t", lazy.spawn("brave --app=https://de.tradingview.com/"), desc='Tradingview'),
    Key([mod, "shift"], "t", lazy.spawn("brave --app=https://twitter.com/home"), desc='Tradingview'),
    Key([mod, "control"], "1", lazy.spawn("brave --app=https://mbox1.belwue.de/"), desc='MailSeminarStuttgart'),
    Key([mod, "control"], "2", lazy.spawn("brave --app=https://bap.navigator.web.de/"), desc='MailWeb'),
    Key([mod], "n", lazy.spawn('emacsclient -ne "(+org-capture/open-frame)"'), desc='Capture Templates'), #erlaubt mir mit Shortcut schnell Einträge in Einkaufsliste etc. zu machen durch capture templates
]

##################################################################################### Desktop-Einstellungen
groups = [Group(i) for i in "123"]

for i in groups:
    keys.extend(
        [
            # mod + Zahl -> wechselt den "Desktop"
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            # mod + shift + Zahl -> verschiebt aktives Fenster auf anderen "Desktop"
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc="Switch to & move focused window to group {}".format(i.name),
            ),
            # Or, use below if you prefer not to switch to that group.
            # # mod1 + shift + letter of group = move focused window to group
            # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
            #     desc="move focused window to group {}".format(i.name)),
        ]
    )

layouts = [
    layout.Columns(border_focus=colors[2], border_width = 3, margin = 8),
    layout.Max(border_focus=colors[2], border_width = 3, margin = 8),
    # layout.Stack(num_stacks=2),
    layout.Bsp(border_focus=colors[2], border_width = 3, margin = 8),
    # layout.Matrix(),
    # layout.MonadTall(),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    layout.TreeTab(border_focus=colors[2], border_width = 3),
    # layout.VerticalTile(),
    # layout.Zoomy(),
    # layout.Floating()
]

widget_defaults = dict(
    font="Ubuntu Bold",
    fontsize=13,
    padding=6,
    background=colors[20],
    foreground = colors[1],
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.CurrentLayoutIcon(padding = 1),
                widget.TextBox(text = '|', padding = 10),
                widget.WindowCount(),
                widget.TextBox(text = '|', padding = 10),
                widget.Clock(format = "%A, %B %d - %H:%M ", padding = 10),
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
                    background = colors[10]),
                widget.Prompt(),
                widget.WindowName(),
                widget.Net(),
                # NB Systray is incompatible with Wayland, consider using StatusNotifier instead
                # widget.StatusNotifier(),
                widget.Systray(),
                widget.QuickExit(default_text = '⏻'),
            ],
            24,
            border_width=[2, 0, 2, 0],  # Draw top and bottom borders
            # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

floating_layout = layout.Floating(
    border_focus=colors[2],  # Hier die gewünschte Rahm(en)farbe angeben
    border_width = 4,  # Hier die gewünschte Rahm(en)farbe angeben
    float_rules=[*layout.Floating.default_float_rules, Match(title='emacs-run-launcher'), Match(title='Confirmation'), Match(title='Alacritty'), Match(title='Keepassxc'),
                 ]
)


# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
