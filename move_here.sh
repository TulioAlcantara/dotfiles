$(cp -r ~/.config/kitty ~/.config/nvim .config/)
$(cp ~/.tmux.conf .tmux.conf)
echo "Copied files from .config/"
$(cp -r ~/.config/i3 ~/.config/polybar ~/.config/picom ~/.config/dunst ~/.config/rofi .config-i3/)
echo "Copied files from .config/ (i3)"
$(cp ~/.zshrc .zshrc)
echo "Copied .zshrc"
echo "Files Updated!"
