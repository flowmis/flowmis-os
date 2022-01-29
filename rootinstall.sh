 # Achtung Video/Grafik Treiber je nach Gerät wechseln
 usermod -aG wheel,audio,video,optical,storage flowmis
 ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime
 hwclock --systohc
 mv ~/FlowmisOS/locale.conf ~/etc/locale.conf
 sed -i 's/#de_DE.UTF-8 UTF-8/de_DE.UTF-8 UTF-8/g' /etc/locale.gen
 locale-gen
 touch /etc/hostname        #nötig oder kann weg?
 echo FlowmisPC | cat > /etc/hostname
 mv ~/FlowmisOS/hosts ~/etc/hosts
 pacman -S grub pcmanfm efibootmgr dosfstools os-prober mtools networkmanager xf86-video-fbdev xorg alacritty base-devel lightdm lightdm-gtk-greeter picom nitrogen qtile rofi emacs ripgrep
 # Achtung richtige Videotreiber je nachdem wo installiert wird: xf86-video-fbdev für VM -> bei physischen Maschinen siehe unten
 # Intel-Grafiktreiber (Open Source): sudo pacman -S xf86-video-intel
 # Nvidia-Grafiktreiber (Open Source): sudo pacman -S xf86-video-nouveau
 # Nvidia (proprietäre) Grafiktreiber: sudo pacman -S nvidia nvidia-utils
 # ATI-Grafiktreiber: sudo pacman -S xf86-video-ati
 # Generische VESA-Treiber: sudo pacman -S xf86-video-vesa
 # Liste verfügbarer Open Source-Treiber: sudo pacman -Ss xf86-video
 # base-devel            -> for makepkg -si
 # lightdm               -> Login into Windowmanager
 # lightdm-gtk-greeter   -> Startbildschirm Loginmanager
 # ripgrep ist für doom emacs nötig (ebenso wie gnu find und fd (sollten jedoch bereits installiert sein - siehe auch github von doom emacs)
 mkdir /boot/EFI
 mount /dev/sda1 boot/EFI
 grub-install /dev/sda
 grub-mkconfig -o /boot/grub/grub.cfg
