   ###Achtung: Auf Hardware machen mehrere Partitionen Sinn
   # fdisk -l                                                                    # Alternativ: <lsblk>
   # fdisk /dev/sda                                                              # mit fdisk in Partition gehen -> Partitionen löschen <d>/neue erstellen <n> -> <m> mögliche Befehle zeigen
   # <g><n><1><Enter><+550M>                                                     # EFI Partition erstellen: <g> kreiert Label - GPT disk label (Achtung falls MBR verwendet wurde) <n> neue Partition mit Nummer <1>  und first sector default <Enter> und second sector 550MiB <+550M>
   # <n><2><Enter><+2G>                                                          # Swap Partition mit Nummer 2 und mindesten 1GiB (oder wie hier 2GiB) erstellen
   # <n><3><Enter><Enter>                                                        # Linux Filesystem Partition mit restlichem Speicher erstellen
   # <t><1><L><1>                                                                # Partition 1 zu EFI ändern (<L> zeigt mögliche Partitionstypen und <1>=EFI)
   # <t><2><19>                                                                  # Partition 2 zu Swap ändern -> Partition 3 muss man nicht ändern da Standard Linux Filesystem passt
   # <w>                                                                         # write changes und fdisk verlassen
   # mkfs.fat -F32 /dev/sda1
   # mkswap /dev/sda2
   # swapon /dev/sda2
   # mkfs.ext4 /dev/sda3
   # mount /dev/sda3 /mnt
   ###Einfache Variante ohne mehrere Partitionen
   # fdisk /dev/sda + <n> + <p> + <Enter> + <Enter> + <Enter> <w>
   # fdisk -l                                                                  # check Partionen -> Alternativ: lsblk
   # mkfs.ext4 /dev/sda1
   ##System einrichten
   # mount /dev/sda1 /mnt
   # pacstrap /mnt base linux linux-firmware                                   # Installiert die grundlegendsten Komponenten die man benötigt um mit dem Linux Kernel arbeiten zu können
   # genfstab -U /mnt >> /mnt/etc/fstab                                        # generiert FileSystemTable
   # arch-chroot /mnt                                                          # Mit root in /mnt gehen
   # pacman -S neovim sudo git
   # passwd
   # useradd -m flowmis
   # passwd flowmis
   # usermod -aG wheel,audio,video,optical,storage flowmis                     # Erteilen der Rechte bzw. in welcher Gruppe der User ist
   # pacman -S grub efibootmgr dosfstools os-prober mtools networkmanager sddm
   # cd /home/flowmis/ && git clone https://github.com/flowmis/flowmis-os.git
   # . /home/flowmis/flowmis-os/tangle/install-hardware-modified.sh
   cd /home/flowmis/ && chown flowmis flowmis-os/ && chgrp flowmis flowmis-os/   # Mit root geclonte Repo auf richtigen Nutzer mit richtigen Rechten geändert
   ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime                     # Link zur Zeitzone um richtige Uhrzeit etc. zu hinterlegen. Manche Programme funktionieren ohne richtige locales nicht
   hwclock --systohc                                                           # setzt Zeit
   mv /home/flowmis/flowmis-os/tangle/locale.conf /etc/locale.conf              # verschiebt vorab erstellte Datei
   sed -i 's/#de_DE.UTF-8 UTF-8/de_DE.UTF-8 UTF-8/g' /etc/locale.gen           # sucht einen String und ersetzt ihn
   locale-gen                                                                  # generiert die locales
   echo FlowmisPC | cat > /etc/hostname                                        # schreibt neue Datei an gewünschten Ort mit gewünschtem Inhalt
   mv /home/flowmis/flowmis-os/tangle/hosts /etc/hosts                          # verschiebt vorab erstellte Datei
   ##Grafiktreiber wählen - bei 2 sollte man nur die Treiber der guten Grafikkarte installieren
   pacman -S xf86-video-fbdev                                                # Grafiktreiber VM
   ##Sonstiges
   # mkdir /boot/EFI                                                           # Erstellung des Bootdirectories
   # mount /dev/sda boot/EFI                                                   # was ist die EFI ppartition in der VM - habe ich ja nicht angelegt???
   # grub-install                                                              # Eventuell muss Pfad mit angegeben werden: grub-install /dev/sda
   # grub-mkconfig -o /boot/grub/grub.cfg                                      # Ohne diese wird es zu Problemen beim booten kommen
   # EDITOR=nvim visudo                                                        # uncomment #%wheel ALL=(ALL) ALL
   # systemctl enable NetworkManager
   # systemctl enable sddm
   # exit
   # umount -l /mnt
   # reboot & login
   # sudo NetworkManager                                                       # keine Fehlermeldung = past alles
   # sudo nmcli device wifi list                                               # nmcli wird mit NetworkManager installiert und zeigt vorhandene Wlan Netzwerke an
   # sudo nmcli device wifi connect "Name Wlan" password "Passwort Wlan"       # Verbindet mit Wlan (https://wiki.archlinux.org/title/NetworkManager)
   ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime                     # Link zur Zeitzone um richtige Uhrzeit etc. zu hinterlegen. Manche Programme funktionieren ohne richtige locales nicht
   hwclock --systohc                                                           # setzt Zeit
   mv /home/flowmis/flowmis-os/tangle/locale.conf /etc/locale.conf              # verschiebt vorab erstellte Datei
   sed -i 's/#de_DE.UTF-8 UTF-8/de_DE.UTF-8 UTF-8/g' /etc/locale.gen           # sucht einen String und ersetzt ihn
   locale-gen                                                                  # generiert die locales
   echo FlowmisPC | cat > /etc/hostname                                        # schreibt neue Datei an gewünschten Ort mit gewünschtem Inhalt
   mv /home/flowmis/flowmis-os/tangle/hosts /etc/hosts                          # verschiebt vorab erstellte Datei
   # localectl --no-convert set-keymap de-latin1-nodeadkeys && localectl --no-convert set-x11-keymap de pc105 deadgraveacute && localectl status
   # setxkbmap -layout de                                                      # Tastaturlayout auf Deutsch
   # timedatectl set-ntp true && timedatectl status                            # Zeit und Datum über das network transfer protocol einholen
