git clone https://github.com/flowmis/DLT.git                   #Klonen der Repos funktioniert nicht wenn sie privat sind und ich kein Token parat hab -> kann man Token mitliefern oder git credentials vorab aus FlowmisOS kopieren???
git clone https://github.com/flowmis/pres.git
git clone https://github.com/flowmis/Kivy.git
git clone https://github.com/flowmis/Sonstiges.git
git clone https://github.com/flowmis/Beachvolleyballfeld.git
sudo pacman -Syu
sudo pacman -S deepin-screen-recorder thunderbird flameshot libreoffice gimp vlc pinta htop kdenlive python-pip virtualbox gpa gvfs pulseaudio pavucontrol bluez bluez-utils pulseaudio-bluetooth pulseaudio-alsa simplescreenrecorder pandoc or1k-elf-binutils texlive-core neofetch man-pages-de gnome-screenshot lxappearance qt5ct adapta-gtk-theme
cd ~/Downloads
git clone https://aur.archlinux.org/yay-git.git
cd yay-git/
makepkg -si
yay -Syu
yay -S dropbox
#python müsste durch qtile bereits installiert worden sein
