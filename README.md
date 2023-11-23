# .files

Using [Arch Linux](https://archlinux.org/download/)

_Optional_

- Look up your Kernel version using `uname -r` and then install the equivalent [Linux Headers](https://archlinux.org/packages/core/x86_64/linux-headers/)
- To check the current installed headers use `ls /lib/modules`
- Nvidia Drivers using [Frogging](https://github.com/Frogging-Family/nvidia-all)

## Packages

### Install [Yay](https://github.com/Jguer/yay) (Package Manager)

    pacman -S --needed git base-devel
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si

### Install i3 Dependencies

    yay -S  ttf-jetbrains-mono-nerd.3.0.2-1 rofi polybar dunst pauvcontrol feh picom playerctl xdg-desktop-portal betterlockscreen

### Install Apps

#### GUI

    yay -S firefox thunderbird cider steam discord obsidian

#### Terminal

    yay -S kitty ranger btop lsd zoxide bat

### Nvim Dependencies

    yay -S neovim xclip fd fzf unzip ripgrep

## Shell

Currently using zsh, with [Oh-my-Zsh](https://ohmyz.sh) and [Powerlevel10k](https://github.com/romkatv/powerlevel10k) Theme

    yay -S zsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
    echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc

## Runtime Version Manager

Currently using [asdf](https://asdf-vm.com/)

    git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.13.1

Just need to clone the repo, since we've already added the asdf plugin to our .zshrc file
