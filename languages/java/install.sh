#!/bin/zsh

set -eo pipefail

: << 'EOF'
    Install Java 17 (Temurin) using SDKMAN.
EOF

echo "☕ Java installation script"

# Check if Java is already installed
if command -v java &> /dev/null; then
    echo "⚠️ Java is already installed:"
    java -version
    read "?Press [Enter] to continue anyway or [Ctrl+C] to abort..."
fi

echo "🔧 Installing dependencies..."
sudo apt update
sudo apt install -y zip unzip curl

# Check if SDKMAN is already installed
if [[ -d "$HOME/.sdkman" ]]; then
    echo "✅ SDKMAN is already installed."
else
    echo "📥 Installing SDKMAN..."
    curl -fsSL "https://get.sdkman.io" | bash
    echo "✅ SDKMAN installed successfully."
fi

# Load SDKMAN into the current shell session
source "$HOME/.sdkman/bin/sdkman-init.sh"

echo "🔍 Finding the latest Java 17 Temurin version..."
JAVA_VERSION="$(sdk list java 2>/dev/null | awk -F'|' '{gsub(/ /,"",$NF); if ($NF ~ /^17\..*-tem$/) print $NF}' | sort -V | tail -n1)"
if [[ -z "$JAVA_VERSION" ]]; then
    echo "❌ Could not determine the latest Java 17 Temurin version."
    exit 1
fi
echo "✅ Latest Java 17 Temurin: $JAVA_VERSION"

if [[ "$(sdk current java 2>/dev/null || true)" == *"$JAVA_VERSION"* ]]; then
    echo "✅ Java $JAVA_VERSION is already the current version."
else
    echo "📥 Installing Java $JAVA_VERSION..."
    export sdkman_auto_answer=true
    sdk install java "$JAVA_VERSION"
    unset sdkman_auto_answer
fi

echo "🔧 Setting Java $JAVA_VERSION as default..."
export sdkman_auto_answer=true
sdk default java "$JAVA_VERSION"
unset sdkman_auto_answer

echo "✅ Java installation completed."

# Verify Java installation
echo "🔍 Verifying Java installation..."
java -version
echo "✅ Java installation verified successfully."
