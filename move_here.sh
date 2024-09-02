$(cp -r ~/.config/i3 ~/.config/polybar ~/.config/picom ~/.config/dunst ~/.config/rofi ~/.config/kitty ~/.config/nvim .config/)
$(cp ~/.config/tmux/tmux.conf .config/tmux/)
echo "Copied files from .config/"
$(cp ~/.zshrc .)
echo "Copied .zshrc"
echo "Files Updated!"
