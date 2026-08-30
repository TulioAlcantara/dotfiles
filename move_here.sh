#!/usr/bin/env bash

OS="$(uname -s)"

# Common configs
cp -r ~/.config/kitty ~/.config/nvim ~/.config/yazi ~/.config/bat ~/.config/ghostty ~/.config/kanata .config/
echo "Copied .config/ (kitty, nvim, yazi, bat, ghostty, kanata)"
cp ~/.tmux.conf .tmux.conf
echo "Copied .tmux.conf"
cp ~/.zshrc .zshrc
echo "Copied .zshrc"

if [[ "$OS" == "Darwin" ]]; then
  cp ~/.aerospace.toml .aerospace.toml
  echo "Copied .aerospace.toml"
  ZED_DIR="$HOME/Library/Application Support/Zed"
  cp "$ZED_DIR/settings.json" "$ZED_DIR/keymap.json" "$ZED_DIR/debug.json" zed/
  echo "Copied Zed config"
elif [[ "$OS" == "Linux" ]]; then
  if command -v i3 >/dev/null 2>&1; then
    cp -r ~/.config/i3 ~/.config/polybar ~/.config/picom ~/.config/dunst ~/.config/rofi .config-i3/
    echo "Copied .config-i3/ (i3, polybar, picom, dunst, rofi)"
  else
    echo "i3 not found — skipping i3/polybar/picom/dunst/rofi configs"
  fi
fi

echo "Files updated!"
