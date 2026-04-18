#!/usr/bin/env bash
set -e

OS="$(uname -s)"

# Common configs
cp -r .config/. ~/.config
echo "Updated .config"
cp .zshrc ~/.zshrc
echo "Updated .zshrc"
cp .tmux.conf ~/.tmux.conf
echo "Updated .tmux.conf"

if [[ "$OS" == "Darwin" ]]; then
  cp .aerospace.toml ~/.aerospace.toml
  echo "Updated .aerospace.toml"
  ZED_DIR="$HOME/Library/Application Support/Zed"
  mkdir -p "$ZED_DIR"
  cp zed/settings.json zed/keymap.json zed/debug.json "$ZED_DIR/"
  echo "Updated Zed config"
elif [[ "$OS" == "Linux" ]]; then
  cp -r .config-i3/. ~/.config
  echo "Updated i3/polybar/picom/dunst/rofi"
fi

echo "Setup completed!"
