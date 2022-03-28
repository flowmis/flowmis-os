sudo localectl --no-convert set-keymap de-latin1-nodeadkeys
sudo localectl --no-convert set-x11-keymap de pc105 deadgraveacute
sudo localectl status                                               # Check ob alles passt -> localctl noch oben in root ohne sudo???
sudo timedatectl set-ntp true                                       # Zeit und Datum über das network transfer protocol einholen
sudo timedatectl status                                             # Check ob alles pass
setxkbmap -layout de                                                # Tastaturlayout auf Deutsch
nitrogen --random --set-scaled /home/flowmis/FlowmisOS/Backgrounds
cd ~
git clone https://aur.archlinux.org/brave-bin.git
cd brave-bin/
makepkg -si                                                     #soll nicht als root installiert werden
cd ~
git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
cp -r ~/.emacs.d/ ~/.backup.emacs.d                                  #macht es?
~/.emacs.d/bin/doom install
sudo pacman -S markdown python-pip python-pipenv stylelint python-jsbeautifier tidy jq shellcheck cmake aspell python-pytest-isort python-nose-exclude htop lightdm-gtk-greeter-settings
sudo pip install jupyter notebook
~/.emacs.d/bin/doom doctor
mkdir -p ~/.config/{rofi,alacritty,picom,qtile,doom,conky,dmlight,pcmanfm}
cd ~/.config/rofi
git clone --depth=1 https://github.com/adi1090x/rofi.git
cd rofi
mkdir -p ~/.local/share/fonts
cp -rf ~/.config/rofi/rofi/fonts/* ~/.local/share/fonts/
cp -rf ~/.config/rofi/rofi/1080p/* ~/.config/rofi/
cd ~/.config/rofi/
rm -rf rofi/
sudo pacman -S python-utils brightnessctl xorg-xbacklight acpi xfce4-power-manager systemd i3lock scrot viewnior dunst bind bmon nm-connection-editor network-manager-applet
yay -S date termite
