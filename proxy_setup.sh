#!/bin/bash

echo "======================================"
echo "       Proxy Setup Script"
echo "======================================"

# Prompt user to enter proxy URL (leave empty to skip)
read -p "Enter proxy server URL (leave blank to skip): " PROXY_URL

if [ -z "$PROXY_URL" ]; then
    echo "No proxy URL provided. Skipping proxy setup."
    exit 0
fi

echo ""
echo "Applying proxy: $PROXY_URL"

# 1. Congifuring .env
echo "-> Configuring ~/.env ..."
touch ~/.env
# Delete any existing proxy settings (to prevent duplication)
sed -i '/export http_proxy=/d' ~/.env
sed -i '/export https_proxy=/d' ~/.env

# Add new proxy settings
echo "export http_proxy=\"$PROXY_URL\"" >> ~/.env
echo "export https_proxy=\"$PROXY_URL\"" >> ~/.env

# Also reflected in the session where the script is running
export http_proxy="$PROXY_URL"
export https_proxy="$PROXY_URL"

# 2. Git
echo "-> Configuring Git ..."
git config --global http.proxy "$PROXY_URL"
git config --global https.proxy "$PROXY_URL"

# 3. APT
echo "-> Configuring APT (may ask for sudo password) ..."
sudo bash -c "cat > /etc/apt/apt.conf.d/80proxy <<EOF
Acquire::http::Proxy \"$PROXY_URL\";
Acquire::https::Proxy \"$PROXY_URL\";
EOF"

# 4. NPM
echo "-> Configuring npm ..."
if command -v npm >/dev/null 2>&1; then
    npm config set proxy "$PROXY_URL"
    npm config set https-proxy "$PROXY_URL"
else
    echo "   npm is not installed yet. Skipping npm proxy setup."
fi

# 5. curl
echo "-> Configuring curl (~/.curlrc) ..."
touch ~/.curlrc
sed -i '/^proxy/d' ~/.curlrc
echo "proxy=\"$PROXY_URL\"" >> ~/.curlrc

# 6. snap
echo "-> Configuring snap ..."
if command -v snap >/dev/null 2>&1; then
    sudo snap set system proxy.http="$PROXY_URL"
    sudo snap set system proxy.https="$PROXY_URL"
    sudo systemctl restart snapd
else
    echo "   snap is not installed yet. Skipping npm proxy setup."
fi

echo ""
echo "Proxy setup completed successfully!"
echo "Note: To apply the environment variables to your current terminal session immediately, please run:"
echo "source ~/.env"
