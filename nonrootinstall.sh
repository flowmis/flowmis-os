 localectl --no-convert set-keymap de-latin1-nodeadkeys
 localectl --no-convert set-x11-keymap de pc105 deadgraveacute
 localectl status
 mkdir -p ~/.config/{rofi,alacritty,picom,qtile,doom}
 git clone --depth 1 https://github.com/hlissner/doom-emacs /home/flowmis/.emacs.d
 cp /home/flowmis/.emacs.d /home/flowmis/.backupemacs.d                             #macht es nicht weil zu der Zeit noch kein solcher Ordner vorhanden ist?
 /home/flowmis/.emacs.d/bin/doom install
 cp /home/flowmis/FlowmisOS/init.el /home/flowmis/.config/doom/init.el
 cp /home/flowmis/FlowmisOS/packages.el /home/flowmis/.config/doom/packages.el
 cp /home/flowmis/FlowmisOS/config.el /home/flowmis/.config/doom/config.el
 cp /home/flowmis/FlowmisOS/.xprofile /home/flowmis/.xprofile
 cp /home/flowmis/FlowmisOS/config.py /home/flowmis/.config/qtile/config.py
 cp /home/flowmis/FlowmisOS/config.rasi /home/flowmis/.config/rofi/config.rasi
 /home/flowmis/.emacs.d/bin/doom sync
 cd /home/flowmis
 git clone https://aur.archlinux.org/brave-bin.git
 cd brave-bin/
 makepkg -si        #soll nicht als root deshalb ahb ich es aus install skript raus
 nitrogen --random --set-scaled /home/flowmis/FlowmisOS/Backgrounds
