#!/bin/bash

# Exit immediately if a command fails
set -e

# Get the absolute path to this script's directory
DOT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "Starting setup..."

# ==========================================
# 0. Setup Proxy Configuration
# ==========================================
# Note for maintainers:
# Set up the network proxy before any other steps.
# This must be executed first because subsequent scripts (e.g., install_apps.sh)
# and git commands require internet access to download packages and repositories.echo ""
echo ""
echo "0. Running proxy setup..."
if [ -f "$DOT_DIR/proxy_setup.sh" ]; then
    chmod +x "$DOT_DIR/proxy_setup.sh"
    "$DOT_DIR/proxy_setup.sh"
    
    # Source the newly created .env to apply proxy environment variables
    # to the current session for subsequent commands (apt, npm, git, etc.).if [ -f "$HOME/.env" ]; then
    if [ -f "$HOME/.env" ]; then
        source "$HOME/.env"
        echo "Loaded environment variables from ~/.env"
    fi
else
    echo "Warning: proxy_setup.sh not found. Skipping proxy configuration."
fi

# ==========================================
# 1. Install applications
# ==========================================
echo ""
echo "1. Running application installation..."
if [ -f "$DOT_DIR/install_apps.sh" ]; then
    chmod +x "$DOT_DIR/install_apps.sh"
    "$DOT_DIR/install_apps.sh"
else
    echo "Warning: install_apps.sh not found. Skipping."
fi

# ==========================================
# 2. Install Powerlevel10k
# ==========================================
echo ""
echo "2. Setting up Powerlevel10k..."
if [ ! -d "$HOME/powerlevel10k" ]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$HOME/powerlevel10k"
else
    echo "Powerlevel10k is already installed."
fi

# ==========================================
# 3. Create symbolic links
# ==========================================
echo ""
echo "3. Creating symbolic links..."
# List of files to link (from ~/dotfiles/ to ~/)
DOT_FILES=(
    ".curlrc"
    ".p10k.zsh"
    ".tmux.conf"
    ".zshrc"
    ".zshenv"
)

for file in "${DOT_FILES[@]}"; do
    if [ -f "$DOT_DIR/$file" ]; then
        ln -snf "$DOT_DIR/$file" "$HOME/$file"
        echo "Linked: ~/$file -> $DOT_DIR/$file"
    else
        echo "Warning: $file not found in $DOT_DIR. Skipping."
    fi
done

# ==========================================
# 4. Change default shell to zsh
# ==========================================
echo ""
echo "4. Checking default shell..."
if [ "$SHELL" != "$(which zsh)" ]; then
    echo "Changing default shell to zsh (you may be prompted for your password)..."
    chsh -s $(which zsh)
else
    echo "Default shell is already zsh."
fi

# ==========================================
# 5. Neovim Setup
# ==========================================
echo ""
echo "5. Setting up Neovim configuration..."
NVIM_CONFIG_DIR="$HOME/.config/nvim"
NVIM_REPO="http://10.206.16.11/keisuke.edo/config-nvim.git"

mkdir -p "$HOME/.config"

if [ -d "$NVIM_CONFIG_DIR" ]; then
    echo "Existing Neovim config found. Backing up..."
    mv "$NVIM_CONFIG_DIR" "${NVIM_CONFIG_DIR}_backup_$(date +%Y%m%d_%H%M%S)"
fi

git clone "$NVIM_REPO" "$NVIM_CONFIG_DIR"
echo "Neovim config cloned to $NVIM_CONFIG_DIR"

# ==========================================
# 6. zsh-autosuggestions Setup
# ==========================================
echo ""
echo "6. Setting up zsh-autosuggestions..."
if [ ! -d "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
else
    echo "zsh-autosuggestions is already installed."
fi

echo ""
echo "Setup complete! Please restart your terminal."
