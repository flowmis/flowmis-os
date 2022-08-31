cd /home/flowmis/
chown flowmis FlowmisOS/                                            # owner root -> owner flowmis
chgrp flowmis FlowmisOS/                                            # Gruppe root -> Gruppe flowmis
usermod -aG wheel,audio,video,optical,storage flowmis               # Erteilen der Rechte bzw. in welcher Gruppe der User ist
ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime             # Link zur Zeitzone um richtige Uhrzeit etc. zu hinterlegen. Manche Programme funktionieren ohne richtige locales nicht
hwclock --systohc                                                   # setzt Zeit
mv /home/flowmis/FlowmisOS/tangle/locale.conf /etc/locale.conf      # verschiebt vorab erstellte Datei
sed -i 's/#de_DE.UTF-8 UTF-8/de_DE.UTF-8 UTF-8/g' /etc/locale.gen   # sucht einen String und ersetzt ihn
locale-gen                                                          # generiert die locales
echo FlowmisPC | cat > /etc/hostname                                # schreibt neue Datei an gewünschten Ort mit gewünschtem Inhalt
mv /home/flowmis/FlowmisOS/tangle/hosts /etc/hosts                  # verschiebt vorab erstellte Datei
pacman -S grub efibootmgr dosfstools os-prober mtools networkmanager xf86-video-fbdev 
mkdir /boot/EFI                                                     # Erstellung des Bootdirectories
mount /dev/sda1 boot/EFI                                            # Achtung2!!! Pfad abhängig von zuvor ausgeführten fdsik Befehlen <mount /dev/"EFI_Partitionsname/Partition1" boot/EFI>
grub-install                                                        # Achtung3!!! Geht grub install ohne Pfad nicht dann folgendes adden> /dev/sda  (siehe auch Achtung3 oben
grub-mkconfig -o /boot/grub/grub.cfg                                # Ohne diese wird es zu Problemen beim booten kommen
localectl --no-convert set-keymap de-latin1-nodeadkeys
localectl --no-convert set-x11-keymap de pc105 deadgraveacute
localectl status                                               # Check ob alles passt -> localctl noch oben in root ohne sudo???
timedatectl set-ntp true                                       # Zeit und Datum über das network transfer protocol einholen
timedatectl status                                             # Check ob alles pass
setxkbmap -layout de                                                # Tastaturlayout auf Deutsch
nitrogen --random --set-scaled /home/flowmis/FlowmisOS/Backgrounds
