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
 pacman -S grub pcmanfm efibootmgr dosfstools os-prober mtools networkmanager xf86-video-fbdev xorg alacritty base-devel lightdm lightdm-gtk-greeter picom nitrogen qtile rofi emacs
 mkdir /boot/EFI
 mount /dev/sda1 boot/EFI
 grub-install /dev/sda
 grub-mkconfig -o /boot/grub/grub.cfg
