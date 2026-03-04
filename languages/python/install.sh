#!/bin/zsh

: << EOF
    ...
EOF

echo "🐍 The Python installation."
read -p "Press [Enter] to continue or [Ctrl+C] to abort..."

# Verify Python is installed
python3 --version
echo "✅ Python is already installed."

# Install UV
echo "📦 Installing UV..."
curl -LsSf https://astral.sh/uv/install.sh | sh
echo "✅ UV installed successfully."

source $HOME/.local/bin/env

# Verify installations
echo "🔍 Verifying installations..."
uv --version
echo "✅ Installations verified successfully."

# Install Python with UV
echo "🐍 Installing Python with UV..."

uv python install --default
echo "✅ Python installed successfully."

## Install other versions of Python
uv python install 3.13 3.12
