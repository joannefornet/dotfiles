#!/bin/bash
set -e

echo "=== 1. APT Packages ==="
sudo apt update
sudo apt install -y \
    build-essential \
    cmake \
    curl \
    dos2unix \
    ffmpeg \
    htop \
    jq \
    npm \
    python3-pip \
    python3-venv \
    pipx \
    tmux \
    tree \
    zip \
    zsh \
    zstd \
    xsel

echo "=== 2. Snap Packages ==="
sudo snap install lsd
sudo snap install nvim --classic
# sudo snap install google-cloud-sdk --classic

echo "=== 3. NPM Packages ==="
# NVMが未インストールならインストール
#export NVM_DIR="$HOME/.nvm"
#if [ ! -d "$NVM_DIR" ]; then
#    echo "Installing NVM..."
#    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
#fi
#
## NVMをこのスクリプト内で有効化
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
#
#echo "Installing Node.js LTS..."
#nvm install --lts
#nvm use --lts
#
## npm install -g の代わりに corepack を使う（権限エラーを回避）
#echo "Enabling pnpm via corepack..."
#corepack enable pnpm
#corepack prepare pnpm@latest --activate
#
echo "=== 4. Python Tools (CLI only) ==="
# Install only standalone CLI tools
pipx install csvkit || true
pipx install uv || true

echo "Done!"
