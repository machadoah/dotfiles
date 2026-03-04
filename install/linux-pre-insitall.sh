#!/bin/bash

: << EOF
    Install GitHub CLI and ZSH on a Linux system.
EOF

echo "⚠️ CAUTION: This script will modify your system by installing software and changing the default shell to ZSH."
echo "⚠️ The system will reboot automatically after the installation is complete."
read -p "Press [Enter] to continue or [Ctrl+C] to abort..." 

# Update and upgrade the system
echo "🔄 Updating and upgrading the system..."
sudo apt update && sudo apt upgrade -y

# Configure git credentials
echo "🔧 Configuring Git credentials..."
echo "Please ensure that the 'install/git.env' file is correctly set up with your Git credentials."
source ./install/git.env

git config --global user.name "$GIT_AUTHOR_NAME"
git config --global user.email "$GIT_AUTHOR_EMAIL"
git config --global github.user "$GH_USER"

echo "✅ Git credentials configured successfully."

# Install GitHub CLI
echo "📩 Installing GitHub CLI..."
sudo apt update
sudo apt install -y gh
echo "✅ GitHub CLI installed successfully."

# Authenticate GitHub CLI
echo "🔐 Authenticating GitHub CLI..."
gh auth login

echo "✅ GitHub CLI authenticated successfully."

# Install ZSH
echo "🐚 Installing ZSH..."
sudo apt install -y zsh
echo "✅ ZSH installed successfully."

# Set ZSH as the default shell
echo "🔧 Setting ZSH as the default shell..."
chsh -s $(which zsh)
echo "✅ ZSH set as the default shell."

# Verify installations
echo "🔍 Verifying installations..."
gh --version
zsh --version
echo "✅ Installations verified successfully."

### Init zsh
echo "🚀 Initializing ZSH ..."
zsh
echo "✅ ZSH initialized successfully."

### Reboot System
echo "🔄 Rebooting the system to apply changes..."
sudo reboot
