#!/bin/zsh

: << EOF
    ...
EOF

echo "🐹 The Go installation."
read -p "Press [Enter] to continue or [Ctrl+C] to abort..."

# Install dependencies
echo "🔧 Installing dependencies..."
sudo apt update
sudo apt install -y curl software-properties-common


# Add Go repository
echo "➕ Adding Go repository..."
sudo add-apt-repository -y ppa:longsleep/golang-backports
sudo apt update

# Download and install Go
echo "📥 Downloading and installing Go..."

sudo apt install -y golang-go
echo "✅ Go installed successfully."

# Verify Go installation
echo "🔍 Verifying Go installation..."
go version
echo "✅ Go installation verified successfully."

# Print Go environment variables
echo "🌐 Go environment variables:"
go env | grep GOPATH
go env | grep GOROOT
echo "✅ Go environment variables displayed successfully."
