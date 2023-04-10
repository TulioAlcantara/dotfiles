# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# env vars
export ZSH="$HOME/.oh-my-zsh"
export PATH=/home/tulio/.local/bin:$PATH

# theme
ZSH_THEME="powerlevel10k/powerlevel10k"

# plugins
plugins=(git zsh-autosuggestions sudo web-search history zsh-syntax-highlighting zsh-vi-mode)
fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src

# oh-my-zsh source
source $ZSH/oh-my-zsh.sh

# aliases
alias zshconfig="mate ~/.zshrc"
alias ohmyzsh="mate ~/.oh-my-zsh"
alias ls="logo-ls"
alias v="lvim"
alias f="nautilus ."

# asdf
# . $HOME/.asdf/asdf.sh
# . $HOME/.asdf/completions/asdf.bash

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
