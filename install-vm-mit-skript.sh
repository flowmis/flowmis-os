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
# - Ordner einhängen und checken ob es geht: sudo mount -t vboxsf share /home/flowmis/share
# - fstab um folgende Linie ergänzen dass geteilter Ordner automatisch eingehängt wird:
    # cloud						/home/flowmis/cloud	vboxsf		defaults 	0 0
# - .ssh nach ~ kopieren + cd in .ssh und chmod 0700 id_rsa sodass anschließend mit git clone git@github.com:flowmis/flowmis-os.git mein Repo geklont werden kann
# 5. Dieses Skript ausführen + rebooten + Qtile statt Wayland wählen und anmelden - fertig ist flowmis-os-minimal und weitere Module direkt aus Emacs installieren:
mkdir -p ~/.config/{alacritty,fish,picom} && echo 'Ordner erstellt'
sudo cp -r ~/flowmis-os/tangle/70-synaptics.conf /etc/X11/xorg.conf.d/70-synaptics.conf && echo '###########################Touchpad sollte funktionieren###########################'
cp -r ~/flowmis-os/tangle/alacritty.yml ~/.config/alacritty/alacritty.yml && cp -r ~/flowmis-os/tangle/config.fish ~/.config/fish/config.fish && echo '###########################Terminals ready###########################'
# cp -r ~/flowmis-os/tangle/.xprofile ~/.xprofile
cp -r ~/flowmis-os/tangle/.bashrc ~/.bashrc && cp -r ~/flowmis-os/tangle/.gitconfig ~/.gitconfig && cp -r ~/flowmis-os/tangle/picom.conf ~/.config/picom/picom.conf && echo '###########################Starteinstellungen vorhanden###########################'
sudo pacman -Syu && sudo pacman -S qtile picom fish eza starship alacritty pcmanfm nitrogen sddm emacs-nativecomp neovim fd ripgrep gnupg gpa keepassxc && echo 'Packete updated and installed'
# eza: Der Befehl ls gibt schönerer/funktionalere Darstellung aus -> meine aliase ändern machen dass ich ls weiterhin verwenden kann und nicht eza schreiben muss
# starship: Shell wird übersichtlicher: < und > statt sinnloser Angabe vom Standardpfad
# base-devel: ermöglicht <makepkg -si> um aus Binaries ein Paket zu machen das im Anschluss installiert werden kann
# ripgrep: für Doom Emacs (ebenso wie gnu find und fd (sollten jedoch bereits installiert sein - siehe auch github von doom emacs)
sudo systemctl enable sddm
