#!/bin/zsh

set -eo pipefail

: << 'EOF'
    Install the latest stable Go from the official tarball.
EOF

echo "🐹 Go installation script"

# Check if Go is already installed
if command -v go &> /dev/null; then
    echo "⚠️ Go is already installed:"
    go version
    read "?Press [Enter] to continue anyway or [Ctrl+C] to abort..."
fi

echo "🔧 Installing dependencies..."
sudo apt update
sudo apt install -y curl tar

GO_VERSION="$(curl -fsSL 'https://go.dev/VERSION?m=text' | head -n1)"
if [[ -z "$GO_VERSION" ]]; then
    echo "❌ Could not determine the latest Go version."
    exit 1
fi

case "$(uname -m)" in
    x86_64)
        GOARCH="amd64"
        ;;
    aarch64|arm64)
        GOARCH="arm64"
        ;;
    *)
        echo "❌ Unsupported architecture: $(uname -m)"
        exit 1
        ;;
esac

echo "📥 Downloading $GO_VERSION for linux/$GOARCH..."
TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

curl -fsSL "https://go.dev/dl/${GO_VERSION}.linux-${GOARCH}.tar.gz" -o "$TMP_DIR/go.tar.gz"

echo "🔧 Installing Go in /usr/local/go..."
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf "$TMP_DIR/go.tar.gz"

export PATH="/usr/local/go/bin:$PATH"

# Verify Go installation
echo "🔍 Verifying Go installation..."
go version
go env GOPATH
go env GOROOT
echo "✅ Go installation verified successfully."
