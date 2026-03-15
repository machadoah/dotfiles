#!/bin/zsh

: << EOF
    Install Python using UV (Astral).
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
echo "✅ Python installed successfully."

# Install other versions of Python
echo "📦 Installing additional Python versions (3.13, 3.12)..."
uv python install 3.13 3.12
echo "✅ Additional Python versions installed."

# Verify installations
echo "🔍 Verifying Python installations..."
uv python list
echo "✅ Python installations verified successfully."
