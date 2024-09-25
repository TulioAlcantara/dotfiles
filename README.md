# .files

Using [Arch Linux](https://archlinux.org/download/)

_Optional_

- Look up your Kernel version using `uname -r` and then install the equivalent [Linux Headers](https://archlinux.org/packages/core/x86_64/linux-headers/)
- To check the current installed headers use `ls /lib/modules`
- Nvidia Drivers using [Frogging](https://github.com/Frogging-Family/nvidia-all) or using installing the `nvidia` package

## Scripts

- `move_here.sh` to update the repo
- `setup.sh` to update your env

## Packages

### [Yay](https://github.com/Jguer/yay) (Package Manager)

    pacman -S --needed git base-devel
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si

### i3 Dependencies

    yay -S ttf-cascadia-code-nerd noto-fonts-jp-vf rofi polybar dunst pauvcontrol feh picom playerctl xdg-desktop-portal betterlockscreen flameshot

### Terminal Apps

    yay -S kitty yazi btop lsd zoxide duf tldr bat w3m open-ssh

### Nvim Dependencies

    yay -S neovim xclip fd fzf unzip ripgrep lazygit
    npm i -g neovim @fsouza/prettierd node-check-updates

## Shell

[Oh-my-Zsh](https://ohmyz.sh) and [Powerlevel10k](https://github.com/romkatv/powerlevel10k) Theme

    yay -S zsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

## Runtime Version Manager

[asdf](https://asdf-vm.com/)

    git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.13.1

[nvm](https://github.com/nvm-sh/nvm)

    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

Just need to clone the repo, since we've already added the asdf plugin to our .zshrc file

## WSL

    pacman -Syu
    pacman -S --needed git base-devel
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
    yay -S ranger btop lsd zoxide duf tldr bat w3m openssh neovim xclip fd fzf unzip ripgrep lazygit zsh tmux
    git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.13.1
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
