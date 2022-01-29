 # Achtung Video/Grafik Treiber je nach Gerät wechseln
 ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime
 hwclock --systohc
 echo LANG=de_DE.UTF-8 | cat > /etc/locale.conf
 sed -i 's/#de_DE.UTF-8 UTF-8/de_DE.UTF-8 UTF-8/g' /etc/locale.gen
 locale-gen
 echo FlowmisPC | cat /etc/hostname
 echo 127.0.0.1\tlocalhost\n::1\t\tlocalhost\n127.0.1.1\tFlowmisPC.localdomain\tFlowmisPC | cat > /etc/hosts
 mkdir -p ~/.config/{rofi,alacritty,picom,qtile,doom}
 git clone https://aur.archlinux.org/brave-bin.git
 cd brave-bin/
 makepkg -si
 mv ~/.emacs.d ~/.backupemacs.d
 git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
 ~/.emacs.d/bin/doom install
 cp ~/FlowmisOS/init.el ~/.config/doom/init.el
 cp ~/FlowmisOS/packages.el ~/.config/doom/packages.el
 cp ~/FlowmisOS/config.el ~/.config/doom/config.el
 ~/.emacs.d/bin/doom sync
 cd ..
 cd ..
 cd ..
 mkdir /boot/EFI
 mount /dev/sda1 boot/EFI
 grub-install /dev/sda
 grub-mkconfig -o /boot/grub/grub.cfg
 exit
