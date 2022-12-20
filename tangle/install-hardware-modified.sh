###Achtung: Das ist nur ein geändertes Skript zusätzliche Informationen finden sich dort wo das Skript install-hardware ist
##Speicher formatieren und Dateisystem einrichten
# fdisk /dev/sda + <n> + <p> + <Enter> + <Enter> + <Enter> <w>
# fdisk -l                                                                  # check Partionen -> Alternativ: lsblk
# mkfs.fat -F32 /dev/sda1                                                   # Falls Namen nicht mehr bewusst sind mit "lsblk" alle möglichen Partitionen anzeigen lassen
# mkswap /dev/sda2
# swapon /dev/sda2
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
# cd /home/flowmis/ && git clone https://github.com/flowmis/FlowmisOS.git
# . /home/flowmis/FlowmisOS/tangle/install-hardware-modified.sh
cd /home/flowmis/ && chown flowmis FlowmisOS/ && chgrp flowmis FlowmisOS/   # Mit root geclonte Repo auf richtigen Nutzer mit richtigen Rechten geändert
ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime                     # Link zur Zeitzone um richtige Uhrzeit etc. zu hinterlegen. Manche Programme funktionieren ohne richtige locales nicht
hwclock --systohc                                                           # setzt Zeit
mv /home/flowmis/FlowmisOS/tangle/locale.conf /etc/locale.conf              # verschiebt vorab erstellte Datei
sed -i 's/#de_DE.UTF-8 UTF-8/de_DE.UTF-8 UTF-8/g' /etc/locale.gen           # sucht einen String und ersetzt ihn
locale-gen                                                                  # generiert die locales
echo FlowmisPC | cat > /etc/hostname                                        # schreibt neue Datei an gewünschten Ort mit gewünschtem Inhalt
mv /home/flowmis/FlowmisOS/tangle/hosts /etc/hosts                          # verschiebt vorab erstellte Datei
##Grafiktreiber wählen - bei 2 sollte man nur die Treiber der guten Grafikkarte installieren
pacman -S xf86-video-fbdev                                                # Grafiktreiber VM
##Tastaturlayout auf Deutsch
# localectl --no-convert set-keymap de-latin1-nodeadkeys && localectl --no-convert set-x11-keymap de pc105 deadgraveacute && localectl status
# setxkbmap -layout de                                                      # Tastaturlayout auf Deutsch
##Sonstiges
# mkdir /boot/EFI                                                           # Erstellung des Bootdirectories
# mount /dev/sda boot/EFI                                                   # was ist die EFI ppartition in der VM - habe ich ja nicht angelegt???
# grub-install                                                              # Eventuell muss Pfad mit angegeben werden: grub-install /dev/sda
# grub-mkconfig -o /boot/grub/grub.cfg                                      # Ohne diese wird es zu Problemen beim booten kommen
# timedatectl set-ntp true && timedatectl status                            # Zeit und Datum über das network transfer protocol einholen
# EDITOR=nvim visudo                                                        # uncomment #%wheel ALL=(ALL) ALL
# systemctl enable NetworkManager
# systemctl enable sddm
# exit
# umount -l /mnt
# reboot & login
# sudo NetworkManager                                                       # keine Fehlermeldung = past alles
# sudo nmcli device wifi list                                               # nmcli wird mit NetworkManager installiert und zeigt vorhandene Wlan Netzwerke an
# sudo nmcli device wifi connect "Name Wlan" password "Passwort Wlan"       # Verbindet mit Wlan (https://wiki.archlinux.org/title/NetworkManager)
