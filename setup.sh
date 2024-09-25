$(cp -r .config/. ~/.config)
echo "Updated .config folder"
$(cp -r .config-i3/. ~/.config)
echo "Updated .config-i3 folder"
$(cp .zshrc ~)
echo "Updated .zshrc"
echo "Setup completed!"
