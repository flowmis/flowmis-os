sudo localectl --no-convert set-keymap de-latin1-nodeadkeys
sudo localectl --no-convert set-x11-keymap de pc105 deadgraveacute
sudo localectl status                                               #localctl noch oben in root ohne sudo???
nitrogen --random --set-scaled /home/flowmis/FlowmisOS/Backgrounds
mkdir -p ~/.config/{rofi,alacritty,picom,qtile,doom,conky,dmlight,pcmanfm}
#cp -r ~/FlowmisOS/tangle/init.el ~/.config/doom/init.el
#cp -r ~/FlowmisOS/tangle/packages.el ~/.config/doom/packages.el
#cp -r ~/FlowmisOS/tangle/config.el ~/.config/doom/config.el
cp -r ~/FlowmisOS/tangle/.xprofile ~/.xprofile
cp -r ~/FlowmisOS/tangle/.bashrc ~/.bashrc
#cp -r ~/FlowmisOS/tangle/.gitconfig ~/.gitconfig
#cp -r ~/FlowmisOS/tangle/.git-credentials ~/.git-credentials
cp -r ~/FlowmisOS/tangle/picom.conf ~/.config/picom/picom.conf
cp -r ~/FlowmisOS/tangle/config.rasi ~/.config/rofi/config.rasi
cp -r ~/FlowmisOS/tangle/config.py ~/.config/qtile/config.py
cp -r ~/FlowmisOS/tangle/alacritty.yml ~/.config/alacritty/alacritty.yml
