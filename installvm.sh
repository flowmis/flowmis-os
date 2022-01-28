 git clone https://github.com/flowmis/DLT.git
 git clone https://github.com/flowmis/pres.git
 git clone https://github.com/flowmis/Kivy.git
 git clone https://github.com/flowmis/Sonstiges.git
 git clone https://github.com/flowmis/Beachvolleyballfeld.git 
 git clone https://aur.archlinux.org/brave-bin.git
 git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
 sudo pacman -S xf86-video-fbdev xorg alacritty base-devel lightdm lightdm-gtk-greeter networkmanager picom pinta htop kdenlive nitrogen qtile rofi deepin-screen-recorder thunderbird emacs flameshot libreoffice gimp vlc
 # xf86-video-fbdev > bei physischen Maschinen Intel, AMD oder Nividia Treiber (siehe ArchWiki)
 # base-devel            -> for makepkg -si
 # lightdm               -> Login into Windowmanager
 # lightdm-gtk-greeter   -> Startbildschirm Loginmanager
 #python python-pip virtualbox noch hinzufügen?
 #sudo pip install jupyter notebook
 git clone https://aur.archlinux.org/brave-bin.git
 cd brave-bin/
 makepkg -si
 mv ~/.emacs.d ~/.backupemacs.d
 git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
 ~/.emacs.d/bin/doom install
 ~/.emacs.d/bin/doom refresh
