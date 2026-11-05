#!/usr/bin/env bash

set -euo pipefail

: << 'EOF'
    Install Git, GitHub CLI, curl, and ZSH on a Linux system.

    This script assumes a Debian/Ubuntu-based distribution (apt).
EOF

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GIT_ENV="$SCRIPT_DIR/git.env"

echo "⚠️ CAUTION: This script will modify your system by installing software and changing the default shell to ZSH."
echo "⚠️ The system will need to reboot after the installation is complete."
read -r -p "Press [Enter] to continue or [Ctrl+C] to abort..."

# Update and upgrade the system
echo "🔄 Updating and upgrading the system..."
sudo apt update
sudo apt upgrade -y

# Install GitHub CLI, ZSH, curl, and git
echo "📩 Installing GitHub CLI, ZSH, curl, and git..."
sudo apt install -y gh zsh curl git
echo "✅ Packages installed successfully."

# Configure git credentials
echo "🔧 Configuring Git credentials..."
if [[ ! -f "$GIT_ENV" ]]; then
    echo "❌ $GIT_ENV not found. Create it before running this script."
    exit 1
fi
# shellcheck source=git.env
source "$GIT_ENV"

git config --global user.name "$GIT_AUTHOR_NAME"
git config --global user.email "$GIT_AUTHOR_EMAIL"
git config --global github.user "$GH_USER"

echo "✅ Git credentials configured successfully."

# Authenticate GitHub CLI
echo "🔐 Authenticating GitHub CLI..."
gh auth login
echo "✅ GitHub CLI authenticated successfully."

# Set ZSH as the default shell
echo "🔧 Setting ZSH as the default shell..."
chsh -s "$(command -v zsh)"
echo "✅ ZSH set as the default shell."

# Verify installations
echo "🔍 Verifying installations..."
gh --version
zsh --version
echo "✅ Installations verified successfully."

echo "⚠️ A system reboot is required to apply changes."
read -r -p "Press [Enter] to reboot now or [Ctrl+C] to abort and reboot later..."
sudo reboot
