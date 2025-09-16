#!/bin/bash

# Kali Linux i3 Window Manager Setup Script
# This script sets up i3wm with configuration similar to your Hyprland setup

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logging functions
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if running on Kali Linux
check_kali() {
    if ! grep -qi "kali" /etc/os-release; then
        log_warning "This script is designed for Kali Linux. Proceeding anyway..."
    else
        log_info "Running on Kali Linux - good to go!"
    fi
}

# Update package database
update_system() {
    log_info "Updating package database..."
    sudo apt update
    log_success "Package database updated"
}

# Install essential packages
install_packages() {
    log_info "Installing required packages..."
    
    local packages=(
        "i3-wm"                  # i3 window manager
        "i3status"               # Status bar for i3
        "i3lock"                 # Screen locker
        "dmenu"                  # Application launcher (fallback)
        "rofi"                   # Modern application launcher
        "feh"                    # Wallpaper setter
        "picom"                  # Compositor for transparency/shadows
        "kitty"                  # Terminal emulator
        "brightnessctl"          # Brightness control
        "pulseaudio-utils"       # Audio control
        "playerctl"              # Media player control
        "maim"                   # Screenshot tool
        "xclip"                  # Clipboard management
        "arandr"                 # Monitor configuration GUI
        "lxappearance"           # GTK theme configuration
        "thunar"                 # File manager
        "fonts-font-awesome"     # Icon fonts
        "fonts-jetbrains-mono"   # JetBrains Mono font
        "nitrogen"               # Alternative wallpaper setter
        "redshift"               # Blue light filter
        "unzip"                  # For extracting themes
        "wget"                   # For downloading themes
        "curl"                   # For downloading files
    )
    
    for package in "${packages[@]}"; do
        if dpkg -l | grep -q "^ii  $package "; then
            log_info "$package is already installed"
        else
            log_info "Installing $package..."
            sudo apt install -y "$package" || log_error "Failed to install $package"
        fi
    done
    
    log_success "All packages installed successfully"
}

# Create necessary directories
create_directories() {
    log_info "Creating configuration directories..."
    
    local dirs=(
        "$HOME/.config/i3"
        "$HOME/.config/i3status"
        "$HOME/.config/rofi"
        "$HOME/.config/picom"
        "$HOME/.config/kitty"
        "$HOME/.config/zsh"
        "$HOME/.config/oh-my-posh"
        "$HOME/.config/btop"
        "$HOME/.config/btop/themes"
        "$HOME/Pictures/Wallpapers"
        "$HOME/.local/share/rofi/themes"
        "$HOME/.local/bin"
    )
    
    for dir in "${dirs[@]}"; do
        mkdir -p "$dir"
        log_info "Created directory: $dir"
    done
    
    log_success "Directories created successfully"
}

# Copy configuration files
copy_configs() {
    log_info "Copying configuration files..."
    
    local script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    
    # Copy i3 config
    if [ -f "$script_dir/config/i3/config" ]; then
        cp "$script_dir/config/i3/config" "$HOME/.config/i3/"
        log_success "Copied i3 configuration"
    else
        log_error "i3 config file not found at $script_dir/config/i3/config"
    fi
    
    # Copy i3status config
    if [ -f "$script_dir/config/i3status/config" ]; then
        cp "$script_dir/config/i3status/config" "$HOME/.config/i3status/"
        log_success "Copied i3status configuration"
    else
        log_error "i3status config file not found"
    fi
    
    # Copy rofi config
    if [ -f "$script_dir/config/rofi/config.rasi" ]; then
        cp "$script_dir/config/rofi/config.rasi" "$HOME/.config/rofi/"
        log_success "Copied rofi configuration"
    fi
    
    # Copy picom config
    if [ -f "$script_dir/config/picom/picom.conf" ]; then
        cp "$script_dir/config/picom/picom.conf" "$HOME/.config/picom/"
        log_success "Copied picom configuration"
    fi
    
    # Copy kitty config if exists
    if [ -f "$script_dir/config/kitty/kitty.conf" ]; then
        cp "$script_dir/config/kitty/kitty.conf" "$HOME/.config/kitty/"
        log_success "Copied kitty configuration"

    # Copy btop config if exists
    if [ -f "$script_dir/config/btop/btop.conf" ]; then
        cp "$script_dir/config/btop/btop.conf" "$HOME/.config/btop/"
        log_success "Copied btop configuration"
    fi

    # Copy btop theme if exists
    if [ -f "$script_dir/config/btop/themes/catppuccin_frappe.theme" ]; then
        cp "$script_dir/config/btop/themes/catppuccin_frappe.theme" "$HOME/.config/btop/themes/"
        log_success "Copied btop Catppuccin theme"
    fi
    fi
}

# Install additional shell packages
install_shell_packages() {
    log_info "Installing shell-related packages..."
    
    local shell_packages=(
        "zsh"
        "zsh-syntax-highlighting"
        "zsh-autosuggestions"
        "fastfetch"
        "neovim"
        "bat"
        "lsd"
        "btop"
        "curl"
    )
    
    for package in "${shell_packages[@]}"; do
        if dpkg -l | grep -q "^ii  $package "; then
            log_info "$package is already installed"
        else
            log_info "Installing $package..."
            sudo apt install -y "$package" || log_error "Failed to install $package"
        fi
    done
    
    log_success "Shell packages installed successfully"
}

# Install Oh My Posh
install_oh_my_posh() {
    log_info "Installing Oh My Posh..."
    
    if command -v oh-my-posh > /dev/null 2>&1; then
        log_info "Oh My Posh is already installed"
        return
    fi
    
    # Install Oh My Posh using the official installer
    curl -s https://ohmyposh.dev/install.sh | bash -s
    
    # Add Oh My Posh to PATH in current session
    export PATH="$PATH:$HOME/.local/bin"
    
    if command -v oh-my-posh > /dev/null 2>&1; then
        log_success "Oh My Posh installed successfully"
    else
        log_warning "Oh My Posh installation may require a shell restart"
    fi
}

# Install zoxide (smart directory navigation)
install_zoxide() {
    log_info "Installing zoxide..."
    
    if command -v zoxide > /dev/null 2>&1; then
        log_info "Zoxide is already installed"
        return
    fi
    
    # Install zoxide using the official installer
    curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
    
    # Add zoxide to PATH in current session
    export PATH="$PATH:$HOME/.local/bin"
    
    if command -v zoxide > /dev/null 2>&1; then
        log_success "Zoxide installed successfully"
    else
        log_warning "Zoxide installation may require a shell restart"
    fi
}

# Setup zsh configuration
setup_zsh() {
    log_info "Setting up zsh configuration..."
    
    local script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    
    # Create necessary directories
    mkdir -p "$HOME/.config/zsh"
    mkdir -p "$HOME/.config/oh-my-posh"
    mkdir -p "$HOME/.config/btop"
    mkdir -p "$HOME/.config/btop/themes"
    
    # Copy zsh configuration files
    if [ -f "$script_dir/config/zshrc" ]; then
        cp "$script_dir/config/zshrc" "$HOME/.zshrc"
        log_success "Copied .zshrc configuration"
    else
        log_error "zshrc config file not found"
    fi
    
    # Copy zsh theme files
    if [ -f "$script_dir/config/zsh/catppuccin_macchiato-zsh-syntax-highlighting.zsh" ]; then
        cp "$script_dir/config/zsh/catppuccin_macchiato-zsh-syntax-highlighting.zsh" "$HOME/.config/zsh/"
        log_success "Copied zsh syntax highlighting theme"
    fi
    
    # Copy oh-my-posh theme
    if [ -f "$script_dir/config/oh-my-posh/zen.toml" ]; then
        cp "$script_dir/config/oh-my-posh/zen.toml" "$HOME/.config/oh-my-posh/"
        log_success "Copied oh-my-posh theme"
    fi
    
    # Set zsh as default shell
    if [ "$SHELL" != "/usr/bin/zsh" ] && [ "$SHELL" != "/bin/zsh" ]; then
        log_info "Setting zsh as default shell..."
        chsh -s /usr/bin/zsh || chsh -s /bin/zsh
        log_success "Zsh set as default shell (takes effect on next login)"
    else
        log_info "Zsh is already the default shell"
    fi
}

# Download and install Catppuccin theme for rofi
install_rofi_theme() {
    log_info "Installing Catppuccin theme for rofi..."
    
    local theme_url="https://raw.githubusercontent.com/catppuccin/rofi/main/basic/.local/share/rofi/themes/catppuccin-frappe.rasi"
    local theme_path="$HOME/.local/share/rofi/themes/catppuccin-frappe.rasi"
    
    if wget -q "$theme_url" -O "$theme_path"; then
        log_success "Downloaded Catppuccin Frappe theme for rofi"
    else
        log_error "Failed to download rofi theme"
    fi
}

# Set up wallpaper
setup_wallpaper() {
    log_info "Setting up wallpaper..."
    
    local wallpaper_dir="$HOME/Pictures/Wallpapers"
    local script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    
    # Copy wallpaper if it exists in dotfiles
    if [ -f "$script_dir/wallpapers/forest.png" ]; then
        cp "$script_dir/wallpapers/forest.png" "$wallpaper_dir/"
        log_success "Copied wallpaper"
    else
        # Create a simple dark wallpaper if none exists
        convert -size 1920x1080 xc:'#303446' "$wallpaper_dir/default.png" 2>/dev/null || {
            log_warning "ImageMagick not available, creating simple wallpaper"
            echo "Creating default wallpaper..."
        }
    fi
}

# Enable auto-login to i3 (optional)
setup_display_manager() {
    log_info "Setting up display manager configuration..."
    
    # Create .xsession file to default to i3
    echo "exec i3" > "$HOME/.xsession"
    chmod +x "$HOME/.xsession"
    
    log_info "Created .xsession file to launch i3"
    log_warning "You may need to select i3 from your display manager login screen"
}

# Create useful scripts
create_scripts() {
    log_info "Creating utility scripts..."
    
    local script_dir="$HOME/.local/bin"
    mkdir -p "$script_dir"
    
    # Volume control script
    cat > "$script_dir/volume-control.sh" << 'EOF'
#!/bin/bash
case $1 in
    up)
        pactl set-sink-volume @DEFAULT_SINK@ +5%
        ;;
    down)
        pactl set-sink-volume @DEFAULT_SINK@ -5%
        ;;
    mute)
        pactl set-sink-mute @DEFAULT_SINK@ toggle
        ;;
esac

# Send notification
volume=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -o '[0-9]*%' | head -1)
if pactl get-sink-mute @DEFAULT_SINK@ | grep -q yes; then
    notify-send -t 1000 "Volume: Muted"
else
    notify-send -t 1000 "Volume: $volume"
fi
EOF
    
    chmod +x "$script_dir/volume-control.sh"
    
    # Screenshot script
    cat > "$script_dir/screenshot.sh" << 'EOF'
#!/bin/bash
case $1 in
    window)
        maim -u -i $(xdotool getactivewindow) | xclip -selection clipboard -t image/png
        notify-send "Screenshot" "Window copied to clipboard"
        ;;
    region)
        maim -u -s | xclip -selection clipboard -t image/png
        notify-send "Screenshot" "Region copied to clipboard"
        ;;
    full)
        maim -u | xclip -selection clipboard -t image/png
        notify-send "Screenshot" "Full screen copied to clipboard"
        ;;
esac
EOF
    
    chmod +x "$script_dir/screenshot.sh"
    
    log_success "Created utility scripts"
}

# Final setup instructions
print_instructions() {
    finalize_setup
    log_success "i3 window manager setup completed!"
    echo
    log_info "Next steps:"
    echo "1. Log out and select 'i3' from your display manager"
    echo "2. Press Super+Return to open a terminal"
    echo "3. Press Super+D or Super+Space to open the application launcher"
    echo "4. Press Super+Shift+Q to close windows"
    echo "5. Use Super+1-9 to switch workspaces"
    echo
    log_info "Key bindings (similar to your Hyprland setup):"
    echo "- Super+Return: Terminal"
    echo "- Super+D/Space: Application launcher"
    echo "- Super+E: File manager"
    echo "- Super+R: Text editor"
    echo "- Super+F: Fullscreen"
    echo "- Super+B: Toggle floating"
    echo "- Super+Shift+Q: Close window"
    echo "- Super+Arrow Keys: Move focus"
    echo "- Super+Shift+Arrow Keys: Move window"
    echo "- Super+Ctrl+Arrow Keys: Resize window"
    echo
    log_info "Configuration files are located in:"
    echo "- ~/.config/i3/config"
    echo "- ~/.config/i3status/config"
    echo "- ~/.config/rofi/config.rasi"
    echo
    log_warning "Reboot or restart your display manager to see the changes"
}

# Final system configuration
finalize_setup() {
    log_info "Finalizing system configuration..."
    
    # Rebuild bat cache to register themes
    if command -v bat > /dev/null 2>&1; then
        log_info "Building bat cache for theme registration..."
        bat cache --build || log_warning "Failed to build bat cache"
        log_success "Bat cache rebuilt successfully"
    fi
    
    # Ensure zsh is set as default shell
    current_shell=$(basename "$SHELL")
    if [ "$current_shell" != "zsh" ]; then
        log_info "Setting zsh as default shell..."
        if command -v zsh > /dev/null 2>&1; then
            chsh -s "$(which zsh)" || {
                log_warning "Failed to change shell automatically. Please run 'chsh -s \$(which zsh)' manually after reboot."
            }
            log_success "Zsh set as default shell (takes effect on next login)"
        else
            log_error "Zsh not found in system"
        fi
    else
        log_info "Zsh is already the default shell"
    fi
}

# Main execution
main() {
    log_info "Starting Kali Linux i3 Window Manager setup..."
    echo
    
    check_kali
    update_system
    install_packages
    create_directories
    copy_configs
    install_rofi_theme
    setup_wallpaper
    setup_display_manager
    create_scripts
    print_instructions
    finalize_setup
    
    log_success "Setup completed successfully!"
}

# Run main function
main "$@"
    log_info "Updating package database..."
    sudo apt update
    log_success "Package database updated"
}

# Install essential packages
install_packages() {
    log_info "Installing required packages..."
    
    local packages=(
        "i3-wm"                  # i3 window manager
        "i3status"               # Status bar for i3
        "i3lock"                 # Screen locker
        "dmenu"                  # Application launcher (fallback)
        "rofi"                   # Modern application launcher
        "feh"                    # Wallpaper setter
        "picom"                  # Compositor for transparency/shadows
        "kitty"                  # Terminal emulator
        "brightnessctl"          # Brightness control
        "pulseaudio-utils"       # Audio control
        "playerctl"              # Media player control
        "maim"                   # Screenshot tool
        "xclip"                  # Clipboard management
        "arandr"                 # Monitor configuration GUI
        "lxappearance"           # GTK theme configuration
        "thunar"                 # File manager
        "fonts-font-awesome"     # Icon fonts
        "fonts-jetbrains-mono"   # JetBrains Mono font
        "nitrogen"               # Alternative wallpaper setter
        "redshift"               # Blue light filter
        "unzip"                  # For extracting themes
        "wget"                   # For downloading themes
        "curl"                   # For downloading files
    )
    
    for package in "${packages[@]}"; do
        if dpkg -l | grep -q "^ii  $package "; then
            log_info "$package is already installed"
        else
            log_info "Installing $package..."
            sudo apt install -y "$package" || log_error "Failed to install $package"
        fi
    done
    
    log_success "All packages installed successfully"
}

# Create necessary directories
create_directories() {
    log_info "Creating configuration directories..."
    
    local dirs=(
        "$HOME/.config/i3"
        "$HOME/.config/i3status"
        "$HOME/.config/rofi"
        "$HOME/.config/picom"
        "$HOME/.config/kitty"
        "$HOME/.config/zsh"
        "$HOME/.config/oh-my-posh"
        "$HOME/.config/btop"
        "$HOME/.config/btop/themes"
        "$HOME/Pictures/Wallpapers"
        "$HOME/.local/share/rofi/themes"
        "$HOME/.local/bin"
    )
    
    for dir in "${dirs[@]}"; do
        mkdir -p "$dir"
        log_info "Created directory: $dir"
    done
    
    log_success "Directories created successfully"
}

# Copy configuration files
copy_configs() {
    log_info "Copying configuration files..."
    
    local script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    
    # Copy i3 config
    if [ -f "$script_dir/config/i3/config" ]; then
        cp "$script_dir/config/i3/config" "$HOME/.config/i3/"
        log_success "Copied i3 configuration"
    else
        log_error "i3 config file not found at $script_dir/config/i3/config"
    fi
    
    # Copy i3status config
    if [ -f "$script_dir/config/i3status/config" ]; then
        cp "$script_dir/config/i3status/config" "$HOME/.config/i3status/"
        log_success "Copied i3status configuration"
    else
        log_error "i3status config file not found"
    fi
    
    # Copy rofi config
    if [ -f "$script_dir/config/rofi/config.rasi" ]; then
        cp "$script_dir/config/rofi/config.rasi" "$HOME/.config/rofi/"
        log_success "Copied rofi configuration"
    fi
    
    # Copy picom config
    if [ -f "$script_dir/config/picom/picom.conf" ]; then
        cp "$script_dir/config/picom/picom.conf" "$HOME/.config/picom/"
        log_success "Copied picom configuration"
    fi
    
    # Copy kitty config if exists
    if [ -f "$script_dir/config/kitty/kitty.conf" ]; then
        cp "$script_dir/config/kitty/kitty.conf" "$HOME/.config/kitty/"
        log_success "Copied kitty configuration"

    # Copy btop config if exists
    if [ -f "$script_dir/config/btop/btop.conf" ]; then
        cp "$script_dir/config/btop/btop.conf" "$HOME/.config/btop/"
        log_success "Copied btop configuration"
    fi

    # Copy btop theme if exists
    if [ -f "$script_dir/config/btop/themes/catppuccin_frappe.theme" ]; then
        cp "$script_dir/config/btop/themes/catppuccin_frappe.theme" "$HOME/.config/btop/themes/"
        log_success "Copied btop Catppuccin theme"
    fi
    fi
}

# Download and install Catppuccin theme for rofi
install_rofi_theme() {
    log_info "Installing Catppuccin theme for rofi..."
    
    local theme_url="https://raw.githubusercontent.com/catppuccin/rofi/main/basic/.local/share/rofi/themes/catppuccin-frappe.rasi"
    local theme_path="$HOME/.local/share/rofi/themes/catppuccin-frappe.rasi"
    
    if wget -q "$theme_url" -O "$theme_path"; then
        log_success "Downloaded Catppuccin Frappe theme for rofi"
    else
        log_error "Failed to download rofi theme"
    fi
}

# Set up wallpaper
setup_wallpaper() {
    log_info "Setting up wallpaper..."
    
    local wallpaper_dir="$HOME/Pictures/Wallpapers"
    local script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    
    # Copy wallpaper if it exists in dotfiles
    if [ -f "$script_dir/wallpapers/forest.png" ]; then
        cp "$script_dir/wallpapers/forest.png" "$wallpaper_dir/"
        log_success "Copied wallpaper"
    else
        # Create a simple dark wallpaper if none exists
        convert -size 1920x1080 xc:'#303446' "$wallpaper_dir/default.png" 2>/dev/null || {
            log_warning "ImageMagick not available, creating simple wallpaper"
            echo "Creating default wallpaper..."
        }
    fi
}

# Enable auto-login to i3 (optional)
setup_display_manager() {
    log_info "Setting up display manager configuration..."
    
    # Create .xsession file to default to i3
    echo "exec i3" > "$HOME/.xsession"
    chmod +x "$HOME/.xsession"
    
    log_info "Created .xsession file to launch i3"
    log_warning "You may need to select i3 from your display manager login screen"
}

# Create useful scripts
create_scripts() {
    log_info "Creating utility scripts..."
    
    local script_dir="$HOME/.local/bin"
    mkdir -p "$script_dir"
    
    # Volume control script
    cat > "$script_dir/volume-control.sh" << 'EOF'
#!/bin/bash
case $1 in
    up)
        pactl set-sink-volume @DEFAULT_SINK@ +5%
        ;;
    down)
        pactl set-sink-volume @DEFAULT_SINK@ -5%
        ;;
    mute)
        pactl set-sink-mute @DEFAULT_SINK@ toggle
        ;;
esac

# Send notification
volume=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -o '[0-9]*%' | head -1)
if pactl get-sink-mute @DEFAULT_SINK@ | grep -q yes; then
    notify-send -t 1000 "Volume: Muted"
else
    notify-send -t 1000 "Volume: $volume"
fi
EOF
    
    chmod +x "$script_dir/volume-control.sh"
    
    # Screenshot script
    cat > "$script_dir/screenshot.sh" << 'EOF'
#!/bin/bash
case $1 in
    window)
        maim -u -i $(xdotool getactivewindow) | xclip -selection clipboard -t image/png
        notify-send "Screenshot" "Window copied to clipboard"
        ;;
    region)
        maim -u -s | xclip -selection clipboard -t image/png
        notify-send "Screenshot" "Region copied to clipboard"
        ;;
    full)
        maim -u | xclip -selection clipboard -t image/png
        notify-send "Screenshot" "Full screen copied to clipboard"
        ;;
esac
EOF
    
    chmod +x "$script_dir/screenshot.sh"
    
    log_success "Created utility scripts"
}

# Final setup instructions
print_instructions() {
    finalize_setup
    log_success "i3 window manager setup completed!"
    echo
    log_info "Next steps:"
    echo "1. Log out and select 'i3' from your display manager"
    echo "2. Press Super+Return to open a terminal"
    echo "3. Press Super+D or Super+Space to open the application launcher"
    echo "4. Press Super+Shift+Q to close windows"
    echo "5. Use Super+1-9 to switch workspaces"
    echo
    log_info "Key bindings (similar to your Hyprland setup):"
    echo "- Super+Return: Terminal"
    echo "- Super+D/Space: Application launcher"
    echo "- Super+E: File manager"
    echo "- Super+R: Text editor"
    echo "- Super+F: Fullscreen"
    echo "- Super+B: Toggle floating"
    echo "- Super+Shift+Q: Close window"
    echo "- Super+Arrow Keys: Move focus"
    echo "- Super+Shift+Arrow Keys: Move window"
    echo "- Super+Ctrl+Arrow Keys: Resize window"
    echo
    log_info "Configuration files are located in:"
    echo "- ~/.config/i3/config"
    echo "- ~/.config/i3status/config"
    echo "- ~/.config/rofi/config.rasi"
    echo
    log_warning "Reboot or restart your display manager to see the changes"
}

# Final system configuration
finalize_setup() {
    log_info "Finalizing system configuration..."
    
    # Rebuild bat cache to register themes
    if command -v bat > /dev/null 2>&1; then
        log_info "Building bat cache for theme registration..."
        bat cache --build || log_warning "Failed to build bat cache"
        log_success "Bat cache rebuilt successfully"
    fi
    
    # Ensure zsh is set as default shell
    current_shell=$(basename "$SHELL")
    if [ "$current_shell" != "zsh" ]; then
        log_info "Setting zsh as default shell..."
        if command -v zsh > /dev/null 2>&1; then
            chsh -s "$(which zsh)" || {
                log_warning "Failed to change shell automatically. Please run 'chsh -s \$(which zsh)' manually after reboot."
            }
            log_success "Zsh set as default shell (takes effect on next login)"
        else
            log_error "Zsh not found in system"
        fi
    else
        log_info "Zsh is already the default shell"
    fi
}

# Main execution
main() {
    log_info "Starting Kali Linux i3 Window Manager setup..."
    echo
    
    check_kali
    update_system
    install_packages
    install_shell_packages
    install_oh_my_posh
    install_zoxide
    create_directories
    copy_configs
    setup_zsh
    install_rofi_theme
    setup_wallpaper
    setup_display_manager
    create_scripts
    print_instructions
    finalize_setup
    
    log_success "Setup completed successfully!"
}

# Run main function
main "$@"