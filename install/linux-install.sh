#!/bin/zsh

: << EOF
    Install Oh My Zsh, Zinit plugins, and Starship prompt.
EOF

echo "🐚 ZSH configuration script"

# Verify zsh is installed
if ! command -v zsh &> /dev/null; then
    echo "❌ ZSH is not installed. Please run linux-pre-install.sh first."
    exit 1
fi
echo "✅ ZSH is installed."

# Install Oh My Zsh
if [[ -d "$HOME/.oh-my-zsh" ]]; then
    echo "✅ Oh My Zsh is already installed."
else
    echo "🛠️ Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    echo "✅ Oh My Zsh installed successfully."
fi

# Install ZSH plugins
if [[ -d "$HOME/.local/share/zinit/zinit.git" ]]; then
    echo "✅ Zinit is already installed."
else
    echo "🔌 Installing Zinit..."
    bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
    echo "✅ Zinit installed successfully."
fi

## Add ZSH plugins to .zshrc
ZSHRC="$HOME/.zshrc"

# Check if plugins are already configured
if ! grep -q "zinit light zdharma/fast-syntax-highlighting" "$ZSHRC" 2>/dev/null; then
    echo "🔧 Adding ZSH plugins..."
    echo "zinit light zdharma/fast-syntax-highlighting" >> "$ZSHRC"
    echo "zinit light zsh-users/zsh-autosuggestions" >> "$ZSHRC"
    echo "zinit light zsh-users/zsh-completions" >> "$ZSHRC"
    echo "✅ ZSH plugins configured."
else
    echo "✅ ZSH plugins already configured."
fi

# Config Starship prompt
if command -v starship &> /dev/null; then
    echo "✅ Starship is already installed."
else
    echo "🚀 Installing Starship prompt..."
    curl -sS https://starship.rs/install.sh | sh
    echo "✅ Starship installed."
fi

# Check if Starship is already configured in .zshrc
if ! grep -q 'eval "$(starship init zsh)"' "$ZSHRC" 2>/dev/null; then
    echo "🥸 Setting up Starship in .zshrc..."
    echo 'eval "$(starship init zsh)"' >> "$ZSHRC"
    echo "✅ Starship configured."
else
    echo "✅ Starship already configured."
fi

# Verify installations
echo "🔍 Verifying installations..."
zsh --version
starship --version
echo "✅ Installations verified successfully."

echo "✅ ZSH configuration completed. Restart your shell to apply changes."
