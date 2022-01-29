 git clone https://aur.archlinux.org/brave-bin.git
 cd brave-bin/
 makepkg -si        #soll nicht als root deshalb ahb ich es aus install skript raus
 sudo systemctl enable NetworkManager
 sudo systemctl enable lightdm
 sudo systemctl reboot
