###Erstelle Ordner##########################################################################################
cd ~
mkdir -p ~/.config/{rofi,alacritty,picom,qtile,doom,conky,pcmanfm} & echo 'Ordner erstellt'
###Intsalliere Packete##########################################################################################
sudo pacman -Syu & echo 'Packete updated'
sudo pacman -S mtools base-devel networkmanager nm-connection-editor network-manager-applet brightnessctl i3lock pulseaudio pavucontrol bluez bluez-utils pulseaudio-bluetooth pulseaudio-alsa man-pages-de xorg xorg-xbacklight acpi xfce4-power-manager systemd picom sddm python-utils python-pip python-pipenv python-pytest-isort python-nose-exclude python-jsbeautifier python-iwlib python-dbus-next qtile stylelint pcmanfm nitrogen rofi ripgrep fd emacs-nativecomp alacritty scrot viewnior dunst bind bmon aspell aspell-de aspell-en ditaa tidy jq shellcheck cmake aspell exa fish starship htop neofetch deepin-screen-recorder thunderbird flameshot libreoffice gimp vlc pinta htop kdenlive virtualbox gpa gvfs simplescreenrecorder pandoc or1k-elf-binutils texlive-core qt5ct adapta-gtk-theme otf-fira-sans ssssss && echo 'Apps installier'
pip install jupyter notebook & echo 'Pakete installier'
sudo systemctl enable NetworkManager sddm & echo 'enabled NM & SDDM'
cd ~/.config/rofi/ && git clone --depth=1 https://github.com/adi1090x/rofi.git
cd ~ && git clone https://aur.archlinux.org/brave-bin.git && cd ~/brave-bin/ && makepkg -si && rm -rf ~/brave-bin/ && echo '###########################installed brave###########################'
cd ~ && git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d && ~/.emacs.d/bin/doom install && ~/.emacs.d/bin/doom sync && ~/.emacs.d/bin/doom doctor && echo 'Installation beendet'
git clone https://aur.archlinux.org/yay-git.git && cd ~/yay-git/ && makepkg -si && rm -rf ~/yay-git/ && yay -Syu && echo '###########################installed yay###########################'
yay -S dropbox sddm-sugar-dark archlinux-tweak-tool-git termite otf-alegreya-sans mu
###Kopiere tangled Ordner/Dateien an entsprechende Orte######################################
cp -r ~/FlowmisOS/tangle/config.el ~/.config/doom/ && cp -r ~/FlowmisOS/tangle/init.el ~/.config/doom/ $$ cp -r ~/FlowmisOS/tangle/packages.el ~/.config/doom/ && cp -r ~/FlowmisOS/tangle/banner ~/.config/doom/ && cp -r ~/FlowmisOS/tangle/themes ~/.config/doom/ && cp -r ~/FlowmisOS/tangle/eshell ~/.config/doom/ && echo '###########################Doom ready###########################'
cp -r ~/FlowmisOS/tangle/config.py ~/.config/qtile/config.py && cp -r ~/FlowmisOS/tangle/python-white.png ~/.config/qtile/pyhton-white.png && echo '###########################Qtile ready###########################'
cp -r ~/FlowmisOS/tangle/alacritty.yml ~/.config/alacritty/alacritty.yml && cp -r ~/FlowmisOS/tangle/config.fish ~/.config/fish/config.fish && echo '###########################Terminals ready###########################'
cp -r ~/FlowmisOS/tangle/.xprofile ~/.xprofile && cp -r ~/FlowmisOS/tangle/.bashrc ~/.bashrc && cp -r ~/FlowmisOS/tangle/.gitconfig ~/.gitconfig && cp -r ~/FlowmisOS/tangle/picom.conf ~/.config/picom/picom.conf && echo '###########################Starteinstellungen vorhanden###########################'
sudo cp -r ~/FlowmisOS/tangle/70-synaptics.conf /etc/X11/xorg.conf.d/70-synaptics.conf && echo '###########################Touchpad sollte funktionieren###########################'
