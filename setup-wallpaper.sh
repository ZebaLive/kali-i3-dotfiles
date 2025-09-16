#!/bin/bash

# Wallpaper Setup Script for 2880x1920@120Hz Display
# This script configures wallpaper with proper cropping (not stretching)

log_info() {
    echo -e "\033[0;34m[INFO]\033[0m $1"
}

log_success() {
    echo -e "\033[0;32m[SUCCESS]\033[0m $1"
}

log_error() {
    echo -e "\033[0;31m[ERROR]\033[0m $1"
}

setup_wallpaper() {
    log_info "Setting up wallpaper for 2880x1920@120Hz display..."
    
    local wallpaper_dir="$HOME/Pictures/Wallpapers"
    local script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    
    # Create wallpaper directory if it doesn't exist
    mkdir -p "$wallpaper_dir"
    
    # Check if wallpaper exists in the kali-dotfiles directory
    if [ -f "$script_dir/wallpapers/wallpaper.png" ]; then
        log_info "Found 4K wallpaper in dotfiles directory"
        cp "$script_dir/wallpapers/wallpaper.png" "$wallpaper_dir/"
        log_success "Copied 4K wallpaper to $wallpaper_dir"
    else
        log_error "4K wallpaper not found at $script_dir/wallpapers/wallpaper.png"
        return 1
    fi
    
    # Set wallpaper with proper cropping (--bg-fill crops to fit, doesn't stretch)
    log_info "Setting wallpaper with proper cropping for 2880x1920 display..."
    
    if command -v feh &> /dev/null; then
        feh --bg-fill "$wallpaper_dir/wallpaper.png"
        log_success "Wallpaper set with feh using --bg-fill (crops to fit screen)"
    else
        log_error "feh not installed. Install with: sudo apt install feh"
        return 1
    fi
    
    # Create autostart script for wallpaper
    mkdir -p ~/.config/autostart
    cat > ~/.config/autostart/wallpaper.desktop << EOF
[Desktop Entry]
Type=Application
Name=Wallpaper
Exec=feh --bg-fill $wallpaper_dir/wallpaper.png
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
EOF
    
    log_success "Created autostart entry for wallpaper"
    
    # Also create a script for manual wallpaper changes
    cat > "$wallpaper_dir/set-wallpaper.sh" << 'EOF'
#!/bin/bash
# Script to set wallpaper with proper cropping for 2880x1920@120Hz display

WALLPAPER_DIR="$HOME/Pictures/Wallpapers"

if [ $# -eq 0 ]; then
    echo "Usage: $0 <wallpaper-filename>"
    echo "Available wallpapers:"
    ls "$WALLPAPER_DIR"/*.{jpg,png,jpeg} 2>/dev/null
    exit 1
fi

WALLPAPER="$WALLPAPER_DIR/$1"

if [ -f "$WALLPAPER" ]; then
    feh --bg-fill "$WALLPAPER"
    echo "Wallpaper set: $WALLPAPER (cropped to fit 2880x1920)"
else
    echo "Wallpaper not found: $WALLPAPER"
    exit 1
fi
EOF
    
    chmod +x "$wallpaper_dir/set-wallpaper.sh"
    log_success "Created wallpaper management script at $wallpaper_dir/set-wallpaper.sh"
    
    echo
    log_info "Wallpaper configuration complete!"
    echo "• 4K wallpaper will be cropped (not stretched) to fit 2880x1920"
    echo "• Use 'feh --bg-fill' for proper cropping behavior"
    echo "• Wallpaper will be set automatically on login"
    echo "• Use $wallpaper_dir/set-wallpaper.sh to change wallpapers"
}

# Run the wallpaper setup
setup_wallpaperse
    echo "Wallpaper not found: $WALLPAPER"
    exit 1
fi
EOF
    
    chmod +x "$wallpaper_dir/set-wallpaper.sh"
    log_success "Created wallpaper management script at $wallpaper_dir/set-wallpaper.sh"
    
    echo
    log_info "Wallpaper configuration complete!"
    echo "• 4K wallpaper will be cropped (not stretched) to fit 2880x1920"
    echo "• Use 'feh --bg-fill' for proper cropping behavior"
    echo "• Wallpaper will be set automatically on login"
    echo "• Use $wallpaper_dir/set-wallpaper.sh to change wallpapers"
}

# Run the wallpaper setup
setup_wallpaper