# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#
# General Settings
#

# 文字の色を変える (Keep user's original setting)
PROMPT='%{${fg[cyan]}%} $n %{${reset_color}%}'

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# History configuration
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

#
# Completion Styles
# Note: compinit is handled by Prezto. Kept only custom visual styles.
#
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

#
# Theme (Powerlevel10k)
#
source ~/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

#
# NVM (Node Version Manager) - Lazy Load
#
export NVM_DIR="$HOME/.nvm"
_lazy_load_nvm() {
  # ダミー関数を削除
  unset -f nvm node npm npx yarn corepack
  # NVM本体の読み込み
  if [ -s "$NVM_DIR/nvm.sh" ]; then
    source "$NVM_DIR/nvm.sh"
  fi
  # 補完の読み込み
  if [ -s "$NVM_DIR/bash_completion" ]; then
    source "$NVM_DIR/bash_completion"
  fi
}

# 初回実行時にのみ _lazy_load_nvm をトリガーするダミー関数
nvm() { _lazy_load_nvm; nvm "$@"; }
node() { _lazy_load_nvm; node "$@"; }
npm() { _lazy_load_nvm; npm "$@"; }
npx() { _lazy_load_nvm; npx "$@"; }
yarn() { _lazy_load_nvm; yarn "$@"; }
corepack() { _lazy_load_nvm; corepack "$@"; }

#
# Aliases
#

# lsd recommended setting
alias ls='lsd'
alias l='ls -lt'
alias ll='l'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree'

# Setting nvim alias
alias vi="nvim"
alias vim="nvim"
alias view="nvim -R"

# Clipboard
alias clip='xsel --clipboard --input'
alias cpwd='pwd|clip'

# Setting lazygit alias
alias lg='lazygit'
alias lgit='lazygit'

# ~/.zshrc の一番最後（エイリアスの下など）に追記
source ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
