# .files

## Scripts

- `move_here.sh` — pull configs from your home directory into this repo
- `setup.sh` — apply configs from this repo to your home directory
- `kanata-setup.sh` — (macOS) install & load the kanata LaunchDaemons (run after `setup.sh`)

`move_here.sh` and `setup.sh` auto-detect macOS vs Linux and apply the appropriate configs.

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

### Keyboard — [kanata](https://github.com/jtroo/kanata) (home row mods)

Software home row mods (CAGS) on the **built-in MacBook keyboard only** —
external keyboards (e.g. a Vial/QMK board) are left to their own firmware via
`macos-dev-names-include` in `~/.config/kanata/kanata.kbd`.

kanata needs the Karabiner virtual HID driver on macOS. Versions must match:
kanata 1.11 talks to driver **v6.2.0** — newer driver releases may silently fail.

    brew install kanata

    # Karabiner-DriverKit-VirtualHIDDevice v6.2.0
    curl -L -o /tmp/karabiner-driver.pkg \
      https://github.com/pqrs-org/Karabiner-DriverKit-VirtualHIDDevice/releases/download/v6.2.0/Karabiner-DriverKit-VirtualHIDDevice-6.2.0.pkg
    sudo installer -pkg /tmp/karabiner-driver.pkg -target /
    sudo /Applications/.Karabiner-VirtualHIDDevice-Manager.app/Contents/MacOS/Karabiner-VirtualHIDDevice-Manager forceActivate

Then enable the extension in **System Settings → General → Login Items &
Extensions → Driver Extensions** (`org.pqrs.Karabiner-DriverKit-VirtualHIDDevice`).

Grant **Input Monitoring** to the kanata binary (System Settings → Privacy &
Security → Input Monitoring → `+` → add `/opt/homebrew/bin/kanata`, or the real
Cellar path if the symlink won't resolve). Daemons can't trigger the prompt, so
this must be added manually.

Install & load the daemons (driver daemon + kanata), which then auto-start at boot:

    ./kanata-setup.sh

> **Note:** the plists in `.config/kanata/` hardcode absolute paths
> (`/Users/tulio/...` and `/opt/homebrew/...`) because launchd does not expand
> `~` or env vars. On a different machine/user, edit those paths in
> `com.kanata.daemon.plist` (and the Cellar path if kanata isn't under
> `/opt/homebrew`) before running `kanata-setup.sh`.

Useful commands:

    sudo launchctl kickstart -k system/com.kanata.daemon   # reload after editing kanata.kbd
    sudo launchctl bootout system/com.kanata.daemon        # stop/disable
    tail -f /var/log/kanata.log                            # logs

If a device isn't grabbed (or you swap keyboards), run `kanata --cfg
~/.config/kanata/kanata.kbd` once in a terminal and copy the exact device name
it prints into `macos-dev-names-include`.

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
