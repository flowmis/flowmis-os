 localectl --no-convert set-keymap de-latin1-nodeadkeys
 localectl --no-convert set-x11-keymap de pc105 deadgraveacute
 localectl status
 sudo pacman -S pcmanfm picom nitrogen rofi emacs ripgrep fd xorg alacritty base-devel lightdm lightdm-gtk-greeter qtile
 sudo systemctl enable NetworkManager lightdm
 #nötig? sudo systemctl reboot          
 git clone --depth 1 https://github.com/hlissner/doom-emacs /home/flowmis/.emacs.d
 cp /home/flowmis/.emacs.d /home/flowmis/.backupemacs.d                             #macht es nicht weil zu der Zeit noch kein solcher Ordner vorhanden ist?
 /home/flowmis/.emacs.d/bin/doom install
 /home/flowmis/.emacs.d/bin/doom sync
 cd /home/flowmis
 git clone https://aur.archlinux.org/brave-bin.git
 cd brave-bin/
 makepkg -si        #soll nicht als root deshalb ahb ich es aus install skript raus
 nitrogen --random --set-scaled /home/flowmis/FlowmisOS/Backgrounds
