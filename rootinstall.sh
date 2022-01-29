 # Achtung Video/Grafik Treiber je nach Gerät wechseln
 usermod -aG wheel,audio,video,optical,storage flowmis
 ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime
 hwclock --systohc
 echo LANG=de_DE.UTF-8 | cat > /etc/locale.conf
 sed -i 's/#de_DE.UTF-8 UTF-8/de_DE.UTF-8 UTF-8/g' /etc/locale.gen
 locale-gen
 echo FlowmisPC | cat /etc/hostname
 echo 127.0.0.1\tlocalhost\n::1\t\tlocalhost\n127.0.1.1\tFlowmisPC.localdomain\tFlowmisPC | cat > /etc/hosts
 pacman -S grub pcmanfm efibootmgr dosfstools os-prober mtools networkmanager xf86-video-fbdev xorg alacritty base-devel lightdm lightdm-gtk-greeter picom nitrogen qtile rofi emacs
 mkdir /boot/EFI
 mount /dev/sda1 boot/EFI
 grub-install /dev/sda
 grub-mkconfig -o /boot/grub/grub.cfg
 exit
