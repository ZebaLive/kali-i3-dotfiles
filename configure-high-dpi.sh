#!/bin/bash

# High DPI Scaling Setup Script for 2880x1920@120Hz display
# This script configures proper scaling for the unusual resolution

log_info() {
    echo -e "\033[0;34m[INFO]\033[0m $1"
}

log_success() {
    echo -e "\033[0;32m[SUCCESS]\033[0m $1"
}

log_info "Configuring high DPI scaling for 2880x1920@120Hz display..."

# Set DPI for X11 applications
xrandr --dpi 180

# Set scaling environment variables
export GDK_SCALE=1.5
export GDK_DPI_SCALE=1
export QT_AUTO_SCREEN_SCALE_FACTOR=1
export QT_SCALE_FACTOR=1.5
export QT_SCREEN_SCALE_FACTORS=1.5

# Configure cursor size for high DPI
export XCURSOR_SIZE=36

# Update Xresources for proper DPI
echo "Xft.dpi: 180" > ~/.Xresources
echo "Xcursor.size: 36" >> ~/.Xresources
xrdb -merge ~/.Xresources

# Create .xprofile for automatic scaling on login
cat > ~/.xprofile << 'EOF'
#!/bin/bash

# High DPI scaling configuration for 2880x1920@120Hz
export GDK_SCALE=1.5
export GDK_DPI_SCALE=1
export QT_AUTO_SCREEN_SCALE_FACTOR=1
export QT_SCALE_FACTOR=1.5
export QT_SCREEN_SCALE_FACTORS=1.5
export XCURSOR_SIZE=36

# Set DPI
xrandr --dpi 180

# Set wallpaper with proper cropping for 2880x1920
if [ -f "$HOME/Pictures/Wallpapers/wallpaper.png" ]; then
    feh --bg-fill "$HOME/Pictures/Wallpapers/wallpaper.png"
fi
EOF

chmod +x ~/.xprofile

log_success "High DPI scaling configured!"
log_info "Settings will take effect after restarting your session"
log_info "Your display resolution: 2880x1920@120Hz"
log_info "DPI set to: 180"
log_info "Scaling factor: 1.5x"