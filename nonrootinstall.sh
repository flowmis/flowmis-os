 mkdir -p ~/.config/{rofi,alacritty,picom,qtile,doom}
 mv ~/.emacs.d ~/.backupemacs.d
 git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
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
