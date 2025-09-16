#!/bin/bash

# Additional script to ensure rofi themes are properly installed
# This script copies the official Catppuccin rofi themes

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Copying additional rofi theme files..."

# Ensure rofi config directory exists
mkdir -p "$HOME/.config/rofi"

# Copy theme files
if [ -f "$SCRIPT_DIR/config/rofi/catppuccin-frappe.rasi" ]; then
    cp "$SCRIPT_DIR/config/rofi/catppuccin-frappe.rasi" "$HOME/.config/rofi/"
    echo "✓ Copied Catppuccin Frappe color definitions"
fi

if [ -f "$SCRIPT_DIR/config/rofi/catppuccin-frappe-complete.rasi" ]; then
    cp "$SCRIPT_DIR/config/rofi/catppuccin-frappe-complete.rasi" "$HOME/.config/rofi/"
    echo "✓ Copied complete Catppuccin Frappe theme"
fi

echo "✓ Rofi themes updated successfully!"