#!/bin/zsh

: << EOF
    Install Java (Temurin 17) using SDKMAN.
EOF

echo "☕ Java installation script"

# Check if Java is already installed
if command -v java &> /dev/null; then
    echo "⚠️ Java is already installed:"
    java -version
    read -p "Press [Enter] to continue anyway or [Ctrl+C] to abort..."
fi

echo "🔧 Installing dependencies..."
sudo apt update
sudo apt install -y zip unzip curl software-properties-common

# Check if SDKMAN is already installed
if [[ -d "$HOME/.sdkman" ]]; then
    echo "✅ SDKMAN is already installed."
else
    echo "📥 Downloading and installing SDKMAN..."
    curl -s "https://get.sdkman.io" | bash
fi

# Load SDKMAN into the current shell session
source "$HOME/.sdkman/bin/sdkman-init.sh"

# Check if Java 17 is already installed via SDKMAN
if sdk current java 2>/dev/null | grep -q "17.0.17-tem"; then
    echo "✅ Java 17.0.17-tem is already installed."
else
    echo "📥 Installing Java..."
    sdk install java 17.0.17-tem -y
fi

echo "✅ Java installation completed."

# Verify Java installation
echo "🔍 Verifying Java installation..."
java -version

echo "✅ Java installation verified successfully."
