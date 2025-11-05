#!/bin/bash

# AI CLI Tools Package Manager
# Unified package management across different package managers

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'

# Package definitions
declare -A PACKAGES
PACKAGES[anthropic-claude]="npm:@anthropic-ai/claude-code|pip:claude-ai|brew:claude-ai"
PACKAGES[google-gemini]="npm:@google/gemini-cli|pip:google-generativeai"
PACKAGES[openai-codex]="npm:@openai/codex|pip:openai"
PACKAGES[perplexity-ai]="pip:perplexity-ai|npm:@perplexity-ai/cli"
PACKAGES[aider-chat]="pip:aider-chat|npm:aider-cli"
PACKAGES[ai-shell]="pip:ai-shell|npm:ai-shell"
PACKAGES[ollama]="brew:ollama|curl:https://ollama.ai/install.sh"
PACKAGES[cursor]="curl:https://cursor.com/install"
PACKAGES[github-copilot]="gh:github/gh-copilot"

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

# Get the preferred package manager for a given package
get_preferred_manager() {
    local package_name="$1"
    local package_info="${PACKAGES[$package_name]}"

    IFS='|' read -ra installers <<< "$package_info"

    for installer in "${installers[@]}"; do
        IFS=':' read -ra parts <<< "$installer"
        local manager="${parts[0]}"

        if command -v "$manager" >/dev/null 2>&1; then
            echo "$manager"
            return
        fi
    done
}

# Install a package using a specific package manager
install_package_with_manager() {
    local package_name="$1"
    local manager="$2"
    local package_info="${PACKAGES[$package_name]}"

    IFS='|' read -ra installers <<< "$package_info"

    for installer in "${installers[@]}"; do
        IFS=':' read -ra parts <<< "$installer"
        local current_manager="${parts[0]}"
        local package="${parts[1]}"

        if [ "$current_manager" == "$manager" ]; then
            case "$manager" in
                "npm")
                    npm install -g "$package"
                    ;;
                "pip"|"pip3")
                    "$manager" install "$package"
                    ;;
                "brew")
                    brew install "$package"
                    ;;
                "gh")
                    gh extension install "$package"
                    ;;
                "curl")
                    curl -fsSL "$package" | bash
                    ;;
            esac
            return
        fi
    done

    log_error "Could not find installer for package '$package_name' with manager '$manager'"
    exit 1
}

# Install a package
install_package() {
    local package_name="$1"

    if [ -z "${PACKAGES[$package_name]}" ]; then
        log_error "Package '$package_name' not found"
        exit 1
    fi

    local preferred_manager=$(get_preferred_manager "$package_name")

    if [ -z "$preferred_manager" ]; then
        log_error "No suitable package manager found for package '$package_name'"
        exit 1
    fi

    log_info "Installing '$package_name' with '$preferred_manager'..."

    if install_package_with_manager "$package_name" "$preferred_manager"; then
        log_success "Successfully installed '$package_name'"
    else
        log_error "Failed to install '$package_name'"
        exit 1
    fi
}

# Update a package
update_package() {
    local package_name="$1"

    if [ -z "${PACKAGES[$package_name]}" ]; then
        log_error "Package '$package_name' not found"
        exit 1
    fi

    local preferred_manager=$(get_preferred_manager "$package_name")

    if [ -z "$preferred_manager" ]; then
        log_error "No suitable package manager found for package '$package_name'"
        exit 1
    fi

    log_info "Updating '$package_name' with '$preferred_manager'..."

    if update_package_with_manager "$package_name" "$preferred_manager"; then
        log_success "Successfully updated '$package_name'"
    else
        log_error "Failed to update '$package_name'"
        exit 1
    fi
}

# Update a package with a specific package manager
update_package_with_manager() {
    local package_name="$1"
    local manager="$2"
    local package_info="${PACKAGES[$package_name]}"

    IFS='|' read -ra installers <<< "$package_info"

    for installer in "${installers[@]}"; do
        IFS=':' read -ra parts <<< "$installer"
        local current_manager="${parts[0]}"
        local package="${parts[1]}"

        if [ "$current_manager" == "$manager" ]; then
            case "$manager" in
                "npm")
                    npm update -g "$package"
                    ;;
                "pip"|"pip3")
                    "$manager" install --upgrade "$package"
                    ;;
                "brew")
                    brew upgrade "$package"
                    ;;
                "gh")
                    gh extension upgrade "$package"
                    ;;
                "curl")
                    curl -fsSL "$package" | bash
                    ;;
            esac
            return
        fi
    done

    log_error "Could not find installer for package '$package_name' with manager '$manager'"
    exit 1
}


# Uninstall a package
uninstall_package() {
    local package_name="$1"

    if [ -z "${PACKAGES[$package_name]}" ]; then
        log_error "Package '$package_name' not found"
        exit 1
    fi

    local preferred_manager=$(get_preferred_manager "$package_name")

    if [ -z "$preferred_manager" ]; then
        log_error "No suitable package manager found for package '$package_name'"
        exit 1
    fi

    log_info "Uninstalling '$package_name' with '$preferred_manager'..."

    if uninstall_package_with_manager "$package_name" "$preferred_manager"; then
        log_success "Successfully uninstalled '$package_name'"
    else
        log_error "Failed to uninstall '$package_name'"
        exit 1
    fi
}

# Uninstall a package with a specific package manager
uninstall_package_with_manager() {
    local package_name="$1"
    local manager="$2"
    local package_info="${PACKAGES[$package_name]}"

    IFS='|' read -ra installers <<< "$package_info"

    for installer in "${installers[@]}"; do
        IFS=':' read -ra parts <<< "$installer"
        local current_manager="${parts[0]}"
        local package="${parts[1]}"

        if [ "$current_manager" == "$manager" ]; then
            case "$manager" in
                "npm")
                    npm uninstall -g "$package"
                    ;;
                "pip"|"pip3")
                    "$manager" uninstall "$package"
                    ;;
                "brew")
                    brew uninstall "$package"
                    ;;
                "gh")
                    gh extension remove "$package"
                    ;;
                "curl")
                    log_warning "Manual uninstallation required for '$package_name'"
                    ;;
            esac
            return
        fi
    done

    log_error "Could not find installer for package '$package_name' with manager '$manager'"
    exit 1
}

# List installed packages
list_installed() {
    log_info "Listing installed AI CLI tools..."

    for package_name in "${!PACKAGES[@]}"; do
        if command -v "$package_name" >/dev/null 2>&1; then
            log_success "$package_name is installed"
        fi
    done
}

# Show package info
show_package_info() {
    local package_name="$1"

    if [ -z "$package_name" ]; then
        echo "Available packages:"
        for pkg in "${!PACKAGES[@]}"; do
            echo "  $pkg"
        done
        return
    fi

    if [ -z "${PACKAGES[$package_name]}" ]; then
        log_error "Package '$package_name' not found"
        exit 1
    fi

    echo "Package: $package_name"
    echo "Installers:"

    IFS='|' read -ra installers <<< "${PACKAGES[$package_name]}"

    for installer in "${installers[@]}"; do
        IFS=':' read -ra parts <<< "$installer"
        local manager="${parts[0]}"
        local package="${parts[1]}"

        if command -v "$manager" >/dev/null 2>&1; then
            echo "  ✓ $manager: $package"
        else
            echo "  ✗ $manager: $package (not available)"
        fi
    done
}

# Main execution
main() {
    case "${1:-help}" in
        "install")
            if [ -z "$2" ]; then
                log_error "Package name required"
                exit 1
            fi
            install_package "$2"
            ;;
        "update")
            if [ -z "$2" ]; then
                log_error "Package name required"
                exit 1
            fi
            update_package "$2"
            ;;
        "uninstall")
            if [ -z "$2" ]; then
                log_error "Package name required"
                exit 1
            fi
            uninstall_package "$2"
            ;;
        "list")
            list_installed
            ;;
        "info")
            show_package_info "$2"
            ;;
        "help"|*)
            echo "AI CLI Tools Package Manager"
            echo
            echo "Usage: $0 <command> [package]"
            echo
            echo "Commands:"
            echo "  install <package>   Install a package"
            echo "  update <package>    Update a package"
            echo "  uninstall <package> Uninstall a package"
            echo "  list                List installed packages"
            echo "  info [package]      Show package information"
            echo "  help                Show this help"
            echo
            echo "Available packages:"
            for pkg in "${!PACKAGES[@]}"; do
                echo "  $pkg"
            done
            ;;
    esac
}

# Run main function
main "$@"
