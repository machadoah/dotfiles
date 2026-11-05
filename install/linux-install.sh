#!/bin/zsh

set -eo pipefail

: << 'EOF'
    Install Oh My Zsh, Zinit, Starship, and the repository Zsh config.

    This script assumes linux-pre-install.sh has already run.
EOF

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
ZSHRC_SOURCE="$REPO_ROOT/zsh/my.zshrc"
ZSHRC_TARGET="$HOME/.zshrc"

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
    curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | RUNZSH=no CHSH=no sh
    echo "✅ Oh My Zsh installed successfully."
fi

# Install Zinit
if [[ -d "$HOME/.local/share/zinit/zinit.git" ]]; then
    echo "✅ Zinit is already installed."
else
    echo "🔌 Installing Zinit..."
    curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh | bash
    echo "✅ Zinit installed successfully."
fi

# Install Starship
if command -v starship &> /dev/null; then
    echo "✅ Starship is already installed."
else
    echo "🚀 Installing Starship prompt..."
    curl -fsSL https://starship.rs/install.sh | sh -s -- -y
    echo "✅ Starship installed."
fi

# Install the repository Zsh config
if [[ ! -f "$ZSHRC_SOURCE" ]]; then
    echo "❌ $ZSHRC_SOURCE not found."
    exit 1
fi

if [[ -L "$ZSHRC_TARGET" && "$(readlink "$ZSHRC_TARGET")" == "$ZSHRC_SOURCE" ]]; then
    echo "✅ ~/.zshrc is already linked to the repository config."
else
    if [[ -e "$ZSHRC_TARGET" || -L "$ZSHRC_TARGET" ]]; then
        BACKUP="$ZSHRC_TARGET.backup.$(date +%Y%m%d%H%M%S)"
        echo "📦 Backing up existing .zshrc to $BACKUP"
        mv "$ZSHRC_TARGET" "$BACKUP"
    fi

    echo "🔗 Linking $ZSHRC_SOURCE -> $ZSHRC_TARGET"
    ln -s "$ZSHRC_SOURCE" "$ZSHRC_TARGET"
fi

# Verify installations
echo "🔍 Verifying installations..."
zsh --version
starship --version
zsh -n "$ZSHRC_SOURCE"
echo "✅ ZSH configuration completed. Restart your shell to apply changes."
