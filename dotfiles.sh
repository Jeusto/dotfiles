#!/usr/bin/env bash

DOTFILES_DIR="$HOME/dotfiles"
TARGET_DIR="$HOME"
BACKUP_DIR="$HOME/.dotfiles-backup-$(date +%Y%m%d-%H%M%S)"

# Detect platform
detect_platform() {
    case "$(uname -s)" in
        Linux*)     echo "~linux" ;;
        Darwin*)    echo "~macos" ;;
        CYGWIN*|MINGW32*|MSYS*|MINGW*) echo "~windows" ;;
        *)          echo "unknown" ;;
    esac
}

# Create backup directory if it doesn't exist
create_backup_dir() {
    if [[ ! -d "$BACKUP_DIR" ]]; then
        mkdir -p "$BACKUP_DIR"
        echo "Created backup directory: $BACKUP_DIR"
    fi
}

# Backup existing files/directories that would conflict with stow
backup_conflicts() {
    local package_dir="$1"
    local package_name="$2"
    
    # Check if stow would have conflicts
    local conflicts=$(stow -d "$DOTFILES_DIR" -t "$TARGET_DIR" -n "$package_name" 2>&1 | grep "existing target")
    
    if [[ -n "$conflicts" ]]; then
        echo "Found conflicts for $package_name, backing up existing files..."
        create_backup_dir
        
        # Parse conflicts and backup each file
        while IFS= read -r line; do
            if [[ "$line" =~ existing\ target.*:\ (.+) ]]; then
                local conflict_path="${BASH_REMATCH[1]}"
                local full_path="$TARGET_DIR/$conflict_path"
                
                if [[ -e "$full_path" ]]; then
                    # Create parent directory in backup location
                    local backup_parent="$BACKUP_DIR/$(dirname "$conflict_path")"
                    mkdir -p "$backup_parent"
                    
                    # Move the conflicting file/directory to backup
                    echo "  Backing up: $conflict_path"
                    mv "$full_path" "$BACKUP_DIR/$conflict_path"
                fi
            fi
        done <<< "$conflicts"
    fi
}

PLATFORM=$(detect_platform)

# Install or uninstall dotfiles
case "$1" in
  install)
    # Only install platform-specific directories and common directories
    for dir in */; do
        dir_name="${dir%/}"
        if [[ "$dir_name" =~ ^(~windows|~macos|~linux)$ ]]; then
            # Check if this is the current platform
            platform_name="${dir_name#~}"
            if [[ "$platform_name" == "$PLATFORM" ]]; then
                echo "Installing platform-specific config: $dir_name"
                backup_conflicts "$dir" "$dir_name"
                stow -d "$DOTFILES_DIR" -vt "$TARGET_DIR" "$dir_name"
            fi
        else
            # Install common directories (not platform-specific)
            echo "Installing common config: $dir_name"
            backup_conflicts "$dir" "$dir_name"
            stow -d "$DOTFILES_DIR" -vt "$TARGET_DIR" "$dir_name"
        fi
    done
    
    if [[ -d "$BACKUP_DIR" ]]; then
        echo ""
        echo "Backup completed. Original files saved to: $BACKUP_DIR"
        echo "You can safely remove this directory after confirming everything works correctly."
    fi
    ;;
  uninstall)
    # Only uninstall platform-specific directories and common directories
    for dir in */; do
        dir_name="${dir%/}"
        if [[ "$dir_name" =~ ^(~windows|~macos|~linux)$ ]]; then
            # Check if this is the current platform
            platform_name="${dir_name#~}"
            if [[ "$platform_name" == "$PLATFORM" ]]; then
                echo "Uninstalling platform-specific config: $dir_name"
                stow -d "$DOTFILES_DIR" -Dvt "$TARGET_DIR" "$dir_name"
            fi
        else
            # Uninstall common directories (not platform-specific)
            echo "Uninstalling common config: $dir_name"
            stow -d "$DOTFILES_DIR" -Dvt "$TARGET_DIR" "$dir_name"
        fi
    done
    ;;
  *)
    echo "Wrong argument, install or uninstall expected"
    exit 1
    ;;
esac
