#!/bin/zsh

: << EOF
    ...
EOF

echo "⚠️ The system will reboot automatically after the installation is complete."
read -p "Press [Enter] to continue or [Ctrl+C] to abort..." 

# Verify zsh is installed
zsh --version
echo "✅ ZSH is already installed."

# Install Oh My Zsh
echo "🛠️ Installing Oh My Zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
echo "✅ Oh My Zsh installed successfully."

# Install ZSH plugins
echo "🔌 Installing ZSH plugins..."
bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"

## Add ZSH plugins to .zshrc
echo "🔧 Configuring ZSH plugins..."

ZSHRC="$HOME/.zshrc"

echo "zinit light zdharma/fast-syntax-highlighting" >> $ZSHRC
echo "zinit light zsh-users/zsh-autosuggestions" >> $ZSHRC
echo "zinit light zsh-users/zsh-completions" >> $ZSHRC

echo "🥳 Enabling ZSH plugins..."
source $ZSHRC

echo "✅ ZSH plugins configured successfully."

# Config Starship prompt
echo "🚀 Configuring Starship prompt..."
curl -sS https://starship.rs/install.sh | sh

echo "🥸 Setting up Starship in .zshrc..."
echo 'eval "$(starship init zsh)"' >> $ZSHRC

echo "✅ ZSH configuration applied successfully."

# Verify installations
echo "🔍 Verifying installations..."
zsh --version
starship --version
echo "✅ Installations verified successfully."

### Reboot System
echo "🔄 Rebooting the system to apply changes..."
sudo reboot
