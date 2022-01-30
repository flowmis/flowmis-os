sudo chown flowmis FlowmisOS
sudo chgrp flowmis FlowmisOS
sudo pacman -S pcmanfm picom nitrogen rofi emacs ripgrep fd xorg alacritty base-devel
git clone https://aur.archlinux.org/brave-bin.git
cd brave-bin/
makepkg -si        #soll nicht als root deshalb ahb ich es aus install skript raus
nitrogen --random --set-scaled /home/flowmis/FlowmisOS/Backgrounds
localectl --no-convert set-keymap de-latin1-nodeadkeys
localectl --no-convert set-x11-keymap de pc105 deadgraveacute
localectl status
