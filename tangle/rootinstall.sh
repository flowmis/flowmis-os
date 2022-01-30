   usermod -aG wheel,audio,video,optical,storage flowmis                      # Erteilen der Rechte bzw. in welcher Gruppe der User ist
   sed -i 's/ #%wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/g' /etc/sudoers      # Ermöglicht sudo usern der Gruppe wheel alle sudo Befehle auszuführen wenn sie das sudo passwort haben
   ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime                    # Link zur Zeitzone um richtige Uhrzeit etc. zu hinterlegen. Manche Programme funktionieren ohne richtige locales nicht
   hwclock --systohc                                                          # setzt Zeit
   mv /home/flowmis/FlowmisOS/locale.conf /etc/locale.conf                    # verschiebt die hier im Dokument erstellte Datei locale.conf mit richtigem Inhalt an den richtigen Ort
   sed -i 's/#de_DE.UTF-8 UTF-8/de_DE.UTF-8 UTF-8/g' /etc/locale.gen          # sucht einen String und ersetzt ihn
   locale-gen                                                                 # generiert die locales
   echo FlowmisPC | cat > /etc/hostname                                       # schreibt neue Datei an gewünschten Ort mit gewünschtem Inhalt (touch nötig wenn Datei noch nicht vorhanden ist?)
   mv /home/flowmis/FlowmisOS/hosts /etc/hosts
   pacman -S grub efibootmgr dosfstools os-prober mtools networkmanager xf86-video-fbdev
   mkdir /boot/EFI
   mount /dev/sda1 boot/EFI
   grub-install /dev/sda
   grub-mkconfig -o /boot/grub/grub.cfg
