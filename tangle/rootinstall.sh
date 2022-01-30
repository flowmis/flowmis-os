usermod -aG wheel,audio,video,optical,storage flowmis                      # Erteilen der Rechte bzw. in welcher Gruppe der User ist
ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime                    # Link zur Zeitzone um richtige Uhrzeit etc. zu hinterlegen. Manche Programme funktionieren ohne richtige locales nicht
hwclock --systohc                                                          # setzt Zeit
mv /home/flowmis/FlowmisOS/tangle/locale.conf /etc/locale.conf                    # verschiebt die hier im Dokument erstellte Datei locale.conf mit richtigem Inhalt an den richtigen Ort
sed -i 's/#de_DE.UTF-8 UTF-8/de_DE.UTF-8 UTF-8/g' /etc/locale.gen          # sucht einen String und ersetzt ihn
locale-gen                                                                 # generiert die locales
echo FlowmisPC | cat > /etc/hostname                                       # schreibt neue Datei an gewünschten Ort mit gewünschtem Inhalt
mv /home/flowmis/FlowmisOS/tangle/hosts /etc/hosts
pacman -S grub efibootmgr dosfstools os-prober mtools networkmanager xf86-video-fbdev
mkdir /boot/EFI
mount /dev/sda1 boot/EFI
grub-install /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg
localectl --no-convert set-keymap de-latin1-nodeadkeys
localectl --no-convert set-x11-keymap de pc105 deadgraveacute
localectl status
