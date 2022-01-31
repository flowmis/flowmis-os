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
sudo pacman -S markdown python-pip python-pipenv stylelint python-jsbeautifier tidy jq shellcheck cmake aspell python-pytest-isort python-nose-exclude
sudo pip install jupyter notebook
~/.emacs.d/bin/doom doctor
mkdir -p ~/.config/{rofi,alacritty,picom,qtile,doom,conky,dmlight,pcmanfm}
#cp -r ~/FlowmisOS/tangle/init.el ~/.config/doom/init.el            # ändern zu ~/.doom.d
#cp -r ~/FlowmisOS/tangle/packages.el ~/.config/doom/packages.el    # ändern zu ~/.doom.d
#cp -r ~/FlowmisOS/tangle/config.el ~/.config/doom/config.el        # ändern zu ~/.doom.d
cp -r ~/FlowmisOS/tangle/.xprofile ~/.xprofile
cp -r ~/FlowmisOS/tangle/.bashrc ~/.bashrc
#cp -r ~/FlowmisOS/tangle/.gitconfig ~/.gitconfig
#cp -r ~/FlowmisOS/tangle/.git-credentials ~/.git-credentials
cp -r ~/FlowmisOS/tangle/picom.conf ~/.config/picom/picom.conf
cp -r ~/FlowmisOS/tangle/config.rasi ~/.config/rofi/config.rasi
cp -r ~/FlowmisOS/tangle/config.py ~/.config/qtile/config.py
cp -r ~/FlowmisOS/tangle/alacritty.yml ~/.config/alacritty/alacritty.yml
