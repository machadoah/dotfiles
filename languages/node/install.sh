#!/bin/zsh

: << EOF
    ...
EOF

echo "🥬 The Node installation."
read -p "Press [Enter] to continue or [Ctrl+C] to abort..."

# Download and install nvm (Node Version Manager):
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash

# in lieu of restarting the shell
\. "$HOME/.nvm/nvm.sh"

# Verify nvm installation:
nvm --version
echo "✅ nvm installed successfully."

# Download and install Node.js:
nvm install 24 # lts/krypton

# Verify the Node.js version:
node -v

echo "✅ Node.js installed successfully."

# Install others node versions
nvm install lts/hydrogen # v18.20.8
nvm install lts/iron # v20.19.6
nvm install lts/jod # v22.21.1

# Download and install pnpm:
corepack enable pnpm

# Verify pnpm version:
pnpm -v

echo "✅ pnpm installed successfully."

# Download and install Yarn:
corepack enable yarn

# Verify Yarn version:
yarn -v

echo "✅ Yarn installed successfully."

# 🍙 Install Bun
echo "🍙 Installing Bun..."
curl -fsSL https://bun.sh/install | bash

# Verify Bun installation:
bun --version

echo "✅ Bun installed successfully."
