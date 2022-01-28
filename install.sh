 # Achtung Video/Grafik Treiber je nach Gerät wechseln 
 git clone https://github.com/flowmis/DLT.git
 git clone https://github.com/flowmis/pres.git
 git clone https://github.com/flowmis/Kivy.git
 git clone https://github.com/flowmis/Sonstiges.git
 git clone https://github.com/flowmis/Beachvolleyballfeld.git 
 sudo pacman -S xf86-video-nouveau xorg alacritty base-devel lightdm lightdm-gtk-greeter networkmanager picom pinta htop kdenlive nitrogen qtile rofi deepin-screen-recorder thunderbird emacs flameshot libreoffice gimp vlc
 # xf86-video-fbdev > bei physischen Maschinen Intel, AMD oder Nividia Treiber (siehe ArchWiki)
 # Intel-Grafiktreiber (Open Source): sudo pacman -S xf86-video-intel
 # Nvidia-Grafiktreiber (Open Source): sudo pacman -S xf86-video-nouveau
 # Nvidia (proprietäre) Grafiktreiber: sudo pacman -S nvidia nvidia-utils
 # ATI-Grafiktreiber: sudo pacman -S xf86-video-ati
 # Generische VESA-Treiber: sudo pacman -S xf86-video-vesa
 # Liste verfügbarer Open Source-Treiber: sudo pacman -Ss xf86-video
 # base-devel            -> for makepkg -si
 # lightdm               -> Login into Windowmanager
 # lightdm-gtk-greeter   -> Startbildschirm Loginmanager
 # python python-pip virtualbox noch hinzufügen?
 # sudo pip install jupyter notebook
 git clone https://aur.archlinux.org/brave-bin.git
 cd brave-bin/
 makepkg -si
 mv ~/.emacs.d ~/.backupemacs.d
 git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
 ~/.emacs.d/bin/doom install
 ~/.emacs.d/bin/doom refresh
