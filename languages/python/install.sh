#!/bin/zsh

set -eo pipefail

: << 'EOF'
    Install Python using UV (Astral), plus ruff and ty.
EOF

echo "🐍 Python installation script"

# Install UV if not already installed
if command -v uv &> /dev/null; then
    echo "✅ UV is already installed."
    uv --version
else
    echo "📦 Installing UV..."
    curl -LsSf https://astral.sh/uv/install.sh | sh
    echo "✅ UV installed successfully."
fi

# Source UV environment
if [[ -f "$HOME/.local/bin/env" ]]; then
    source "$HOME/.local/bin/env"
fi

# Verify UV installation
echo "🔍 Verifying UV installation..."
uv --version
echo "✅ UV installation verified."

# Install Python with UV
echo "🐍 Installing Python with UV..."
uv python install --default
uv python install 3.13 3.12
echo "✅ Python installed successfully."

# Install the tools used by the Zed configuration
if command -v ruff &> /dev/null; then
    echo "✅ ruff is already installed."
else
    echo "🧹 Installing ruff..."
    uv tool install ruff
fi

if command -v ty &> /dev/null; then
    echo "✅ ty is already installed."
else
    echo "🔍 Installing ty..."
    uv tool install ty
fi

# Verify installations
echo "🔍 Verifying Python installations..."
uv python list
ruff --version
ty --version
echo "✅ Python installations verified successfully."
