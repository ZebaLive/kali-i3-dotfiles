#!/bin/bash

# Simple one-liner installer for Kali Linux i3 setup
# Usage: curl -sSL https://raw.githubusercontent.com/ZebaLive/kali-i3-dotfiles/refs/heads/main/install.sh | bash

set -e

REPO_URL="https://github.com/ZebaLive/kali-i3-dotfiles.git"
BRANCH="main"
DOTFILES_DIR="$HOME/dotfiles"

echo "🚀 Installing Kali Linux i3 Window Manager Setup..."

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo "📦 Installing git..."
    sudo apt update && sudo apt install -y git
fi

# Clone or update the repository
if [ -d "$DOTFILES_DIR" ]; then
    echo "📁 Updating existing dotfiles repository..."
    cd "$DOTFILES_DIR"
    git pull origin "$BRANCH"
else
    echo "📥 Cloning dotfiles repository..."
    git clone -b "$BRANCH" "$REPO_URL" "$DOTFILES_DIR"
fi

# Run the setup script
if [ -f "$DOTFILES_DIR/setup.sh" ]; then
    echo "⚙️  Running i3 setup script..."
    cd "$DOTFILES_DIR"
    chmod +x setup.sh
    ./setup.sh
else
    echo "❌ Setup script not found at $DOTFILES_DIR/setup.sh"
    exit 1
fi

echo "✅ Installation completed! Please log out and select i3 from your display manager."