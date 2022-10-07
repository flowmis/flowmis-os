#mkdir -p ~/.config/{alacritty,fish} && echo 'Ordner erstellt'
#sudo cp -r ~/FlowmisOS/tangle/70-synaptics.conf /etc/X11/xorg.conf.d/70-synaptics.conf && echo '###########################Touchpad sollte funktionieren###########################'
#cp -r ~/FlowmisOS/tangle/alacritty.yml ~/.config/alacritty/alacritty.yml && cp -r ~/FlowmisOS/tangle/config.fish ~/.config/fish/config.fish && echo '###########################Terminals ready###########################'
#cp -r ~/FlowmisOS/tangle/.xprofile ~/.xprofile && cp -r ~/FlowmisOS/tangle/.bashrc ~/.bashrc && cp -r ~/FlowmisOS/tangle/.gitconfig ~/.gitconfig && cp -r ~/FlowmisOS/tangle/picom.conf ~/.config/picom/picom.conf && echo '###########################Starteinstellungen vorhanden###########################'
#sudo pacman -Syu && sudo pacman -S qtile picom fish exa starship alacritty pcmanfm nitrogen sddm emacs-nativecomp neovim fd ripgrep gnupg openssh gpa keepassxc && echo 'Packete updated and installed'
#sudo systemctl enable sddm
cd ~ && git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d && ~/.emacs.d/bin/doom install && ~/.emacs.d/bin/doom sync && ~/.emacs.d/bin/doom doctor && echo 'Installation beendet'
