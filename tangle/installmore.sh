git clone https://aur.archlinux.org/brave-bin.git /home/flowmis/
cd /home/flowmis/brave-bin/
makepkg -si        #soll nicht als root deshalb ahb ich es aus install skript raus
git clone --depth 1 https://github.com/hlissner/doom-emacs /home/flowmis/.emacs.d
cp /home/flowmis/.emacs.d /home/flowmis/.backupemacs.d                             #macht es nicht weil zu der Zeit noch kein solcher Ordner vorhanden ist?
/home/flowmis/.emacs.d/bin/doom install
/home/flowmis/.emacs.d/bin/doom sync
git clone https://github.com/flowmis/DLT.git                   #Klonen der Repos funktioniert nicht wenn sie privat sind und ich kein Token parat hab -> kann man Token mitliefern oder git credentials vorab aus FlowmisOS kopieren???
git clone https://github.com/flowmis/pres.git
git clone https://github.com/flowmis/Kivy.git
git clone https://github.com/flowmis/Sonstiges.git
git clone https://github.com/flowmis/Beachvolleyballfeld.git
sudo pacman -S deepin-screen-recorder thunderbird flameshot libreoffice gimp vlc pinta htop kdenlive python-pip virtualbox
#python müsste durch qtile bereits installiert worden sein
sudo pip install jupyter notebook
