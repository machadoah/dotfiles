#!/bin/zsh

: << EOF
    ...
EOF

echo "☕ The Java installation."
read -p "Press [Enter] to continue or [Ctrl+C] to abort..."

# Install dependencies
echo "🔧 Installing dependencies..."
sudo apt update
sudo apt install -y zip unzip curl software-properties-common

# Install SDKMAN
echo "📥 Downloading and installing SDKMAN..."
curl -s "https://get.sdkman.io" | bash

# Load SDKMAN into the current shell session
source "$HOME/.sdkman/bin/sdkman-init.sh"

# Install Java using SDKMAN
echo "📥 Installing Java..."
sdk install java 17.0.17-tem -y

echo "✅ Java installed successfully."

# Verify Java installation
echo "🔍 Verifying Java installation..."
java -version

echo "✅ Java installation verified successfully."
