if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Theme
ZSH_THEME="powerlevel10k/powerlevel10k"

# Plugins
plugins=(git asdf sudo history vi-mode)

# oh-my-zsh
export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh

# fzf
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

# nvm
source /usr/share/nvm/init-nvm.sh

# rust
# source $HOME/.cargo/env

# zoxide setup
eval "$(zoxide init zsh)"

# Aliases
alias cat=bat
alias ls=lsd
alias df=duf
alias bye=shutdown -h now

# Apps
alias t=tmux
alias v=nvim
alias f=fzf
alias g=lazygit
alias r=ranger

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# pnpm
export PNPM_HOME="/home/tulio/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
