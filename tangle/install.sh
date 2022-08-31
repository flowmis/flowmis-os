mkdir -p ~/.config/{rofi,alacritty,picom,qtile,doom,conky,pcmanfm} & echo 'Ordner erstellt'
sudo pacman -Syu & echo 'Packete updated'
sudo pacman -S mtools networkmanager xf86-video-fbdev pcmanfm picom nitrogen rofi emacs-nativecomp ripgrep fd xorg alacritty base-devel sddm qtile python-utils otf-fira-sans  brightnessctl xorg-xbacklight acpi xfce4-power-manager systemd i3lock scrot viewnior dunst bind bmon nm-connection-editor network-manager-applet aspell aspell-de aspell-en ditaa markdown python-pip python-pipenv stylelint python-jsbeautifier tidy jq shellcheck cmake aspell python-pytest-isort python-nose-exclude htop deepin-screen-recorder thunderbird flameshot libreoffice gimp vlc pinta htop kdenlive python-pip virtualbox gpa gvfs pulseaudio pavucontrol bluez bluez-utils pulseaudio-bluetooth pulseaudio-alsa simplescreenrecorder pandoc or1k-elf-binutils texlive-core neofetch man-pages-de gnome-screenshot qt5ct adapta-gtk-theme exa fish starship python-iwlib python-dbus-next 
sudo pip install jupyter notebook & echo 'Pakete installier'
sudo systemctl enable NetworkManager sddm & echo 'enabled NM & SDDM'
git clone https://aur.archlinux.org/brave-bin.git
git clone https://aur.archlinux.org/yay-git.git
git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
cd ~/.config/rofi/
git clone --depth=1 https://github.com/adi1090x/rofi.git
cd ~/brave-bin/
makepkg -si                                                     #soll nicht als root installiert werden
rm -r ~/brave-bin/
cd ~/yay-git/
makepkg -si
rm -r ~/yay-git/
yay -Syu
yay -S dropbox sddm-sugar-dark archlinux-tweak-tool-git termite otf-alegreya-sans
~/.emacs.d/bin/doom install
~/.emacs.d/bin/doom sync
~/.emacs.d/bin/doom doctor
