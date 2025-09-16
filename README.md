# Kali Linux i3 Window Manager Setup

This setup provides a complete i3 window manager configuration for Kali Linux that closely mimics your existing Hyprland setup. The configuration includes similar keybindings, visual styling with the **official Catppuccin Frappe theme**, zsh with syntax highlighting, Oh My Posh prompt, and essential tools. **Optimized for high DPI displays (2880x1920@120Hz).**

## Features

- **i3 Window Manager** with Hyprland-like keybindings
- **Official Catppuccin Frappe Theme** for consistent styling
- **Zsh Shell** with syntax highlighting and autosuggestions
- **Oh My Posh** prompt with Zen theme
- **Modern CLI Tools** (bat, lsd, btop, zoxide, fastfetch)
- **High DPI Support** optimized for 2880x1920@120Hz displays
- **4K Wallpaper Support** with proper cropping
- **Rofi Application Launcher** with Catppuccin theming
- **Picom Compositor** for transparency and effects

## Quick Setup

1. **Run the setup script:**
   ```bash
   cd kali-dotfiles
   chmod +x setup.sh
   ./setup.sh
   ```

   This will automatically install:
   - i3 window manager and related packages
   - zsh, zsh-syntax-highlighting, zsh-autosuggestions
   - Modern CLI tools: bat, lsd, btop, zoxide, fastfetch
   - Oh My Posh prompt system
   - kitty terminal, rofi launcher, picom compositor
   - All configuration files with Catppuccin theming
   - Rebuilds bat cache and sets zsh as default shell

2. **Configure high DPI scaling (for 2880x1920@120Hz displays):**
   ```bash
   ./configure-high-dpi.sh
   ```

3. **Setup 4K wallpaper with proper cropping:**
   ```bash
   ./setup-wallpaper.sh
   ```

4. **Log out and select i3 from your display manager**

5. **Start using i3 with familiar keybindings, zsh shell, and official Catppuccin theming!**

### Optional: Update Themes

If you want to ensure you have the latest official themes, you can run:

```bash
./update-rofi-themes.sh
```

## Shell Configuration

### Zsh Setup

The setup automatically configures zsh as your default shell with:

- **Zsh Syntax Highlighting** with Catppuccin Macchiato theme
- **Zsh Autosuggestions** for command completion
- **Oh My Posh** prompt with the Zen theme
- **Fastfetch** system information display on new terminals

### Shell Features

- Command syntax highlighting with Catppuccin colors
- Auto-suggestions based on history
- Git status in prompt
- Execution time display for long-running commands
- Customizable prompt themes

### Aliases Included

- `zshrc` - Quick edit zsh configuration
- `i3config` - Quick edit i3 configuration  
- `cat` → `bat` (syntax highlighted cat)
- `ls` → `lsd` (modern ls with icons)
- `l` - Detailed file listing
- `top` → `btop` (modern system monitor)

### Modern CLI Tools

The setup includes modern replacements for traditional CLI tools:

- **bat** - Syntax highlighted `cat` with git integration
- **lsd** - Modern `ls` replacement with icons and colors
- **btop** - Beautiful system monitor with graphs and Catppuccin theme
- **zoxide** - Smart directory navigation that learns your habits
- **fastfetch** - Fast system information display

All tools are configured with Catppuccin theming for visual consistency.

## High DPI Configuration (2880x1920@120Hz)

This setup is specifically optimized for high-resolution displays:

### Scaling Adjustments Made:

- **Font sizes increased**: i3bar (14pt), rofi (16pt), kitty (16pt)
- **Gaps scaled up**: Inner gaps: 8px, Outer gaps: 15px  
- **Border thickness**: Increased to 3px for better visibility
- **Corner radius**: Scaled to 15px for proportional appearance
- **DPI setting**: Set to 180 DPI for crisp text rendering
- **Environment variables**: GDK_SCALE=1.5, QT_SCALE_FACTOR=1.5

### Wallpaper Handling:

- **4K wallpaper support** with proper cropping (not stretching)
- **`feh --bg-fill`** used to crop wallpapers to fit 2880x1920 perfectly
- **Automatic wallpaper setting** on login via .xprofile
- **Wallpaper management script** for easy wallpaper changes

## Key Bindings (Similar to Your Hyprland Setup)

### Essential Keys
- `Super + Enter` - Terminal (kitty)
- `Super + D` or `Super + Space` - Application launcher (rofi)
- `Super + E` - File manager (thunar)
- `Super + R` - Text editor (code)
- `Super + Shift + Return` - Browser
- `Super + Shift + Q` - Close window
- `Super + F` - Fullscreen
- `Super + Shift + B` - Toggle floating

### Window Management
- `Super + Arrow Keys` - Move focus
- `Super + Shift + Arrow Keys` - Move window
- `Super + Ctrl + Arrow Keys` - Resize window
- `Super + B` - Split horizontal
- `Super + V` - Split vertical

### Workspaces
- `Super + 1-9` - Switch to workspace
- `Super + Shift + 1-9` - Move window to workspace
- `Super + Minus` - Scratchpad

### System Controls
- `Super + Ctrl + L` - Lock screen
- `Super + Shift + C` - Reload config
- `Super + Shift + R` - Restart i3
- `Super + Shift + L` - Exit i3

### Media Keys
- `Volume Up/Down/Mute` - Audio control
- `Brightness Up/Down` - Screen brightness
- `Print` - Screenshot (region)
- `Super + Print` - Screenshot (window)
- `Super + Shift + Print` - Screenshot (full screen)

## Features

### Visual Styling
- **Official Catppuccin Frappe Theme** - Direct from the official Catppuccin i3 repository
- **Proper color variables** - Uses `$lavender`, `$base`, `$mauve`, etc.
- **Rounded corners** - 10px radius (via picom)
- **Window transparency** - Active: 90%, Inactive: 80%
- **Gaps** - Inner: 5px, Outer: 10px
- **Blur effects** - Background blur for semi-transparent windows

### Applications
- **Terminal**: kitty with your existing configuration
- **Launcher**: rofi with **official Catppuccin Frappe theme**
- **Compositor**: picom for transparency and visual effects
- **Status bar**: i3status with system information
- **File manager**: thunar
- **Screenshots**: maim with clipboard integration

### Auto-start Applications
- picom (compositor)
- feh (wallpaper)
- redshift (blue light filter)

## Configuration Files

- `~/.config/i3/config` - Main i3 configuration
- `~/.config/i3/catppuccin-frappe` - Official Catppuccin Frappe color definitions
- `~/.config/i3status/config` - Status bar configuration
- `~/.config/rofi/config.rasi` - Application launcher configuration
- `~/.config/rofi/catppuccin-frappe-complete.rasi` - Official Catppuccin Frappe rofi theme
- `~/.config/picom/picom.conf` - Compositor settings
- `~/.config/kitty/kitty.conf` - Terminal configuration

## Customization

### Wallpaper
Place your wallpaper in `~/Pictures/Wallpapers/forest.png` or modify the feh command in the i3 config:
```bash
exec --no-startup-id feh --bg-scale ~/Pictures/Wallpapers/your-wallpaper.png
```

### Theme Colors
The setup uses Catppuccin Frappe colors. To modify colors, edit the color values in:
- `~/.config/i3/config` (window borders and bar colors)
- `~/.config/rofi/config.rasi` (launcher colors)
- `~/.config/picom/picom.conf` (transparency and effects)

### Additional Applications
To add auto-start applications, add lines to your i3 config:
```bash
exec --no-startup-id your-application
```

## Differences from Hyprland

While this setup closely mimics your Hyprland configuration, there are some differences:

1. **Compositor**: Uses picom instead of built-in Hyprland compositor
2. **Status bar**: Uses i3status instead of waybar
3. **Protocols**: Uses X11 instead of Wayland
4. **Some animations**: More limited animation support
5. **Blur**: Different blur implementation

## Troubleshooting

### If applications don't start:
- Check if they're installed: `which kitty rofi thunar`
- Install missing packages: `sudo apt install kitty rofi thunar`

### If wallpaper doesn't load:
- Check wallpaper path in i3 config
- Install feh: `sudo apt install feh`
- Use nitrogen as alternative: `sudo apt install nitrogen`

### If transparency doesn't work:
- Check picom is running: `pgrep picom`
- Restart picom: `pkill picom && picom --config ~/.config/picom/picom.conf &`

### If status bar is missing:
- Check i3status is installed: `which i3status`
- Restart i3: `Super + Shift + R`

## Contributing

Feel free to modify the configuration files to better suit your needs. The setup is designed to be modular and easily customizable.

## Resources

- [i3 User's Guide](https://i3wm.org/docs/userguide.html)
- [i3status Manual](https://i3wm.org/i3status/manpage.html)
- [Rofi Configuration](https://github.com/davatorium/rofi)
- [Picom Configuration](https://github.com/yshui/picom)
- [Catppuccin Theme](https://github.com/catppuccin/catppuccin)# kali-i3-dotfiles
