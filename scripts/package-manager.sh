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
PACKAGES[claude]="npm:@anthropic-ai/claude-code|pip:claude-ai|brew:claude-ai"
PACKAGES[gemini]="npm:@google/gemini-cli|pip:google-generativeai"
PACKAGES[codex]="npm:@openai/codex|pip:openai"
PACKAGES[perplexity]="pip:perplexity-ai|npm:@perplexity-ai/cli"
PACKAGES[aider]="pip:aider-chat|npm:aider-cli"
PACKAGES[ai_shell]="pip:ai-shell|npm:ai-shell"
PACKAGES[ollama]="brew:ollama|curl:https://ollama.ai/install.sh"
PACKAGES[cursor]="curl:https://cursor.com/install"
PACKAGES[copilot]="gh:github/gh-copilot"

# Package manager detection
detect_package_managers() {
    local managers=()
    
    if command -v npm >/dev/null 2>&1; then
        managers+=("npm")
    fi
    
    if command -v pip >/dev/null 2>&1; then
        managers+=("pip")
    fi
    
    if command -v pip3 >/dev/null 2>&1; then
        managers+=("pip3")
    fi
    
    if command -v brew >/dev/null 2>&1; then
        managers+=("brew")
    fi
    
    if command -v gh >/dev/null 2>&1; then
        managers+=("gh")
    fi
    
    if command -v curl >/dev/null 2>&1; then
        managers+=("curl")
    fi
    
    echo "${managers[@]}"
}

# Get package info
get_package_info() {
    local package_name="$1"
    local package_info="${PACKAGES[$package_name]}"
    
    if [ -z "$package_info" ]; then
        echo "Package '$package_name' not found"
        return 1
    fi
    
    echo "$package_info"
}

# Install package
install_package() {
    local package_name="$1"
    local package_info="${PACKAGES[$package_name]}"
    
    if [ -z "$package_info" ]; then
        log_error "Package '$package_name' not found"
        return 1
    fi
    
    log_info "Installing $package_name..."
    
    IFS='|' read -ra installers <<< "$package_info"
    
    for installer in "${installers[@]}"; do
        IFS=':' read -ra parts <<< "$installer"
        local manager="${parts[0]}"
        local package="${parts[1]}"
        
        case "$manager" in
            "npm")
                if command -v npm >/dev/null 2>&1; then
                    log_info "Installing via npm: $package"
                    npm install -g "$package"
                    log_success "$package_name installed via npm"
                    return 0
                fi
                ;;
            "pip"|"pip3")
                if command -v "$manager" >/dev/null 2>&1; then
                    log_info "Installing via $manager: $package"
                    "$manager" install "$package"
                    log_success "$package_name installed via $manager"
                    return 0
                fi
                ;;
            "brew")
                if command -v brew >/dev/null 2>&1; then
                    log_info "Installing via brew: $package"
                    brew install "$package"
                    log_success "$package_name installed via brew"
                    return 0
                fi
                ;;
            "gh")
                if command -v gh >/dev/null 2>&1; then
                    log_info "Installing via gh: $package"
                    gh extension install "$package"
                    log_success "$package_name installed via gh"
                    return 0
                fi
                ;;
            "curl")
                log_info "Installing via curl: $package"
                curl -fsSL "$package" | bash
                log_success "$package_name installed via curl"
                return 0
                ;;
        esac
    done
    
    log_error "No suitable package manager found for $package_name"
    return 1
}

# Update package
update_package() {
    local package_name="$1"
    local package_info="${PACKAGES[$package_name]}"
    
    if [ -z "$package_info" ]; then
        log_error "Package '$package_name' not found"
        return 1
    fi
    
    log_info "Updating $package_name..."
    
    IFS='|' read -ra installers <<< "$package_info"
    
    for installer in "${installers[@]}"; do
        IFS=':' read -ra parts <<< "$installer"
        local manager="${parts[0]}"
        local package="${parts[1]}"
        
        case "$manager" in
            "npm")
                if command -v npm >/dev/null 2>&1; then
                    log_info "Updating via npm: $package"
                    npm update -g "$package"
                    log_success "$package_name updated via npm"
                    return 0
                fi
                ;;
            "pip"|"pip3")
                if command -v "$manager" >/dev/null 2>&1; then
                    log_info "Updating via $manager: $package"
                    "$manager" install --upgrade "$package"
                    log_success "$package_name updated via $manager"
                    return 0
                fi
                ;;
            "brew")
                if command -v brew >/dev/null 2>&1; then
                    log_info "Updating via brew: $package"
                    brew upgrade "$package"
                    log_success "$package_name updated via brew"
                    return 0
                fi
                ;;
            "gh")
                if command -v gh >/dev/null 2>&1; then
                    log_info "Updating via gh: $package"
                    gh extension upgrade "$package"
                    log_success "$package_name updated via gh"
                    return 0
                fi
                ;;
            "curl")
                log_info "Reinstalling via curl: $package"
                curl -fsSL "$package" | bash
                log_success "$package_name updated via curl"
                return 0
                ;;
        esac
    done
    
    log_error "No suitable package manager found for $package_name"
    return 1
}

# Uninstall package
uninstall_package() {
    local package_name="$1"
    local package_info="${PACKAGES[$package_name]}"
    
    if [ -z "$package_info" ]; then
        log_error "Package '$package_name' not found"
        return 1
    fi
    
    log_info "Uninstalling $package_name..."
    
    IFS='|' read -ra installers <<< "$package_info"
    
    for installer in "${installers[@]}"; do
        IFS=':' read -ra parts <<< "$installer"
        local manager="${parts[0]}"
        local package="${parts[1]}"
        
        case "$manager" in
            "npm")
                if command -v npm >/dev/null 2>&1; then
                    log_info "Uninstalling via npm: $package"
                    npm uninstall -g "$package"
                    log_success "$package_name uninstalled via npm"
                    return 0
                fi
                ;;
            "pip"|"pip3")
                if command -v "$manager" >/dev/null 2>&1; then
                    log_info "Uninstalling via $manager: $package"
                    "$manager" uninstall "$package"
                    log_success "$package_name uninstalled via $manager"
                    return 0
                fi
                ;;
            "brew")
                if command -v brew >/dev/null 2>&1; then
                    log_info "Uninstalling via brew: $package"
                    brew uninstall "$package"
                    log_success "$package_name uninstalled via brew"
                    return 0
                fi
                ;;
            "gh")
                if command -v gh >/dev/null 2>&1; then
                    log_info "Uninstalling via gh: $package"
                    gh extension remove "$package"
                    log_success "$package_name uninstalled via gh"
                    return 0
                fi
                ;;
            "curl")
                log_warning "Manual uninstallation required for $package_name"
                return 0
                ;;
        esac
    done
    
    log_error "No suitable package manager found for $package_name"
    return 1
}

# List installed packages
list_installed() {
    log_info "Listing installed AI CLI tools..."
    
    local tools=("claude" "gemini" "codex" "perplexity" "aider" "ai_shell" "ollama" "cursor-agent" "gh")
    local installed=()
    
    for tool in "${tools[@]}"; do
        if command -v "$tool" >/dev/null 2>&1; then
            installed+=("$tool")
        fi
    done
    
    if [ ${#installed[@]} -eq 0 ]; then
        log_warning "No AI CLI tools found"
    else
        log_success "Installed tools: ${installed[*]}"
    fi
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
    
    local package_info="${PACKAGES[$package_name]}"
    
    if [ -z "$package_info" ]; then
        log_error "Package '$package_name' not found"
        return 1
    fi
    
    echo "Package: $package_name"
    echo "Installers:"
    
    IFS='|' read -ra installers <<< "$package_info"
    
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