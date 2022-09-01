    mkdir -p ~/.config/{rofi,alacritty,picom,qtile,doom,fish} && echo 'Ordner erstellt'
    sudo pacman -Syu && sudo pacman -S qtile picom fish exa alacritty pcmanfm nitrogen sddm emacs-nativecomp neovim fd ripgrep && echo 'Packete updated and installed'
    sudo systemctl enable sddm
    cd ~ && git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d && ~/.emacs.d/bin/doom install && ~/.emacs.d/bin/doom sync && ~/.emacs.d/bin/doom doctor && echo 'Installation beendet'
