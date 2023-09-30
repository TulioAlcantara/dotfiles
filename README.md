## .files
## Packages
Install Yay (Package Manager)
   

     pacman -S --needed git base-devel
     git clone https://aur.archlinux.org/yay.git
     cd yay
     makepkg -si
Install Dependencies

    yay -S kitty lsd ttf-jetbrains-mono-nerd.3.0.2-1 neovim unzip ripgrep rofi polybar pauvcontrol ranger zsh feh picom playerctl xdg-desktop-portal 

## Shell
Currently using zsh, with Oh-my-Zsh and Powerlevel10k Theme

    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
    echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc


## Runtime Version Manager
Currently using asdf

    git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.13.1
    
 Just need to clone the repo, since we've already added the asdf plugin to our .zshrc file Essential Packages

