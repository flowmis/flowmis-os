 localectl --no-convert set-keymap de-latin1-nodeadkeys
 localectl --no-convert set-x11-keymap de pc105 deadgraveacute
 localectl status
 mkdir -p ~/.config/{rofi,alacritty,picom,qtile,doom}
 git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
 cp ~/.emacs.d ~/.backupemacs.d                             #macht es nicht weil zu der Zeit noch kein solcher Ordner vorhanden ist?
 ~/.emacs.d/bin/doom install
 cp ~/FlowmisOS/init.el ~/.config/doom/init.el
 cp ~/FlowmisOS/packages.el ~/.config/doom/packages.el
 cp ~/FlowmisOS/config.el ~/.config/doom/config.el
 cp ~/FlowmisOS/.xprofile ~/.xprofile
 cp ~/FlowmisOS/config.py ~/.config/qtile/config.py
 cp ~/FlowmisOS/config.rasi ~/.config/rofi/config.rasi
 ~/.emacs.d/bin/doom sync
 cd ~
 git clone https://aur.archlinux.org/brave-bin.git
 cd brave-bin/
 makepkg -si        #soll nicht als root deshalb ahb ich es aus install skript raus
