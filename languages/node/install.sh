#!/bin/zsh

: << EOF
    Install Node.js using NVM, plus pnpm, Yarn, and Bun.
EOF

echo "🥬 Node.js installation script"

# Download and install nvm (Node Version Manager) if not installed
if [[ -d "$HOME/.nvm" ]]; then
    echo "✅ NVM is already installed."
else
    echo "📦 Installing NVM..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
    echo "✅ NVM installed successfully."
fi

# Source NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Verify nvm installation
echo "🔍 NVM version:"
nvm --version
echo "✅ NVM is working."

# Install Node.js 24 LTS (Krypton) if not installed
if nvm list 2>/dev/null | grep -q "24"; then
    echo "✅ Node.js 24 is already installed."
else
    echo "📦 Installing Node.js 24 (LTS Krypton)..."
    nvm install 24
    echo "✅ Node.js 24 installed."
fi

# Install other Node.js LTS versions
for version in "lts/hydrogen" "lts/iron" "lts/jod"; do
    if nvm list 2>/dev/null | grep -q "$version"; then
        echo "✅ Node.js $version is already installed."
    else
        echo "📦 Installing Node.js $version..."
        nvm install "$version"
    fi
done

# Verify the default Node.js version
echo "🔍 Default Node.js version:"
node -v
echo "✅ Node.js verified."

# Enable pnpm if not already enabled
if command -v pnpm &> /dev/null; then
    echo "✅ pnpm is already installed."
else
    echo "📦 Enabling pnpm via Corepack..."
    corepack enable pnpm
    echo "✅ pnpm enabled."
fi

# Verify pnpm version
pnpm -v
echo "✅ pnpm verified."

# Enable Yarn if not already enabled
if command -v yarn &> /dev/null; then
    echo "✅ Yarn is already installed."
else
    echo "📦 Enabling Yarn via Corepack..."
    corepack enable yarn
    echo "✅ Yarn enabled."
fi

# Verify Yarn version
yarn -v
echo "✅ Yarn verified."

# Install Bun if not already installed
if command -v bun &> /dev/null; then
    echo "✅ Bun is already installed."
    bun --version
else
    echo "🍙 Installing Bun..."
    curl -fsSL https://bun.sh/install | bash
    echo "✅ Bun installed."
fi

# Verify Bun installation
bun --version
echo "✅ Bun verified."

echo "✅ All Node.js tools installed successfully."
