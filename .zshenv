# Default editor
export EDITOR='nvim'
export VISUAL='nvim'

# NVM directory
export NVM_DIR="$HOME/.nvm"

# Load local environment variables (proxies, etc.)
if [[ -f "$HOME/.env" ]]; then
  source "$HOME/.env"
fi
export PATH="/snap/bin:$PATH"
