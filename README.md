# .files

## Scripts

- `move_here.sh` — pull configs from your home directory into this repo
- `setup.sh` — apply configs from this repo to your home directory

Both scripts auto-detect macOS vs Linux and apply the appropriate configs.

---

## macOS

### Homebrew

    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

### CLI Tools

    brew install neovim fzf zoxide direnv bat lsd duf yazi lazygit tmux

### Nvim Dependencies

    brew install ripgrep fd unzip
    npm i -g neovim @fsouza/prettierd

### Window Manager — [AeroSpace](https://github.com/nikitabobko/AeroSpace)

    brew install --cask aerospace

### Shell

[Oh-my-Zsh](https://ohmyz.sh) and [Powerlevel10k](https://github.com/romkatv/powerlevel10k):

    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

---

## Linux (Arch)

### i3 Dependencies

    yay -S ttf-cascadia-code-nerd rofi polybar dunst pavucontrol feh picom playerctl xdg-desktop-portal betterlockscreen flameshot dolphin kitty

### CLI Tools

    yay -S neovim yazi btop lsd zoxide duf tldr bat w3m openssh fzf ripgrep fd unzip lazygit

### Nvim Dependencies

    npm i -g neovim @fsouza/prettierd node-check-updates

### [Yay](https://github.com/Jguer/yay) (AUR helper)

    pacman -Syu
    pacman -S --needed git base-devel
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si

### Shell

    yay -S zsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

---

## Shared

### Runtime Version Managers

[asdf](https://asdf-vm.com/):

    git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.13.1

[nvm](https://github.com/nvm-sh/nvm):

    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

### Tmux Plugin Manager

    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
