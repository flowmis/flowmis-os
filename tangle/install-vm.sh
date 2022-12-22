# 1. ~python -m archinstall~
#    Einstellungen:
#    - Sprache auf de & locale-lang auf de.DE
#    - Grub als Bootloader wählen
#    - Root Passwort vergeben + Account/User mit Passwort erstellen
#    - Profil auf xorg ändern
#    - Dem Gerät entsprechende Grafiktreiber wählen
#    - pulseaudio wählen
#    - NetworkManager wählen
#    - Timezone auf Europe-Berlin
#    - Zusatzpakete angeben: git sudo networkmanager
#    - Festplatte wählen, alles wipen + ext4 filesystem konfigurieren
#    - Installation starten
# 2. shutdown, iso/installationsmedium entfernen, boot & login -> Internet sollte gehen und arch-minimal ist fertig installiert!
# 3. Falls kein Internet - mit nmcli im Wlan anmelden
# 4. VM konfigurieren:
    # - sudo pacman -S virtualbox-guest-utils openssh
    # - sudo VBoxClient-all
    # - In VirtualBox Einstellungen der jeweiligen VM  -> Allgemein -> Erweitert -> Gemeinsame Zwischenablage & Drag'n'Drop auf bidirektional stellen
    # - In VirtualBox Einstellungen der jeweiligen VM  -> Allgemein -> Gemeinsame Ordner -> "Hinzufügen" drücken unter: Ordner der virtuellen Maschine -> Pfad Ordnername etc beispielsweise wie folgt angeben (Ordner sollte vorab auf beiden Systemen erstellt werden): <C:\Users\manem\Desktop\share -- share -- automatisch einbinden -- Einbindungspunkt leer lassen>
    # - Ordner einhängen: sudo mount -t vboxsf share /home/flowmis/share
    # - .ssh nach ~ kopieren + cd in .ssh und chmod 0700 id_rsa sodass anschließend mit git clone git@github.com:flowmis/FlowmisOS.git mein Repo geklont werden kann
# 5. Dieses Skript ausführen:
mkdir -p ~/.config/{alacritty,fish,picom} && echo 'Ordner erstellt'
sudo cp -r ~/FlowmisOS/tangle/70-synaptics.conf /etc/X11/xorg.conf.d/70-synaptics.conf && echo '###########################Touchpad sollte funktionieren###########################'
cp -r ~/FlowmisOS/tangle/alacritty.yml ~/.config/alacritty/alacritty.yml && cp -r ~/FlowmisOS/tangle/config.fish ~/.config/fish/config.fish && echo '###########################Terminals ready###########################'
# cp -r ~/FlowmisOS/tangle/.xprofile ~/.xprofile
cp -r ~/FlowmisOS/tangle/.bashrc ~/.bashrc && cp -r ~/FlowmisOS/tangle/.gitconfig ~/.gitconfig && cp -r ~/FlowmisOS/tangle/picom.conf ~/.config/picom/picom.conf && echo '###########################Starteinstellungen vorhanden###########################'
sudo pacman -Syu && sudo pacman -S qtile picom fish exa starship alacritty pcmanfm nitrogen sddm emacs-nativecomp neovim fd ripgrep gnupg gpa keepassxc && echo 'Packete updated and installed'
# exa: Der Befehl ls gibt schönerer/funktionalere Darstellung aus -> meine aliase ändern machen dass ich ls weiterhin verwenden kann und nicht exa schreiben muss
# starship: Shell wird übersichtlicher: < und > statt sinnloser Angabe vom Standardpfad
# base-devel: ermöglicht <makepkg -si> um aus Binaries ein Paket zu machen das im Anschluss installiert werden kann
# ripgrep: für Doom Emacs (ebenso wie gnu find und fd (sollten jedoch bereits installiert sein - siehe auch github von doom emacs)
sudo systemctl enable sddm
cd ~ && git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d && ~/.emacs.d/bin/doom install && ~/.emacs.d/bin/doom sync && ~/.emacs.d/bin/doom doctor && echo 'Installation beendet'
