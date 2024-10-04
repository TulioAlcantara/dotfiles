$(cp -r .config/. ~/.config)
echo "Updated .config folder"
$(cp .zshrc ~)
echo "Updated .zshrc"
$(cp .tmux.conf ~)
echo "Updated tmux"

echo "Setup completed!"
