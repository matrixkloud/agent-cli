#!/bin/bash

# AI CLI Tools Configuration Manager
# Advanced configuration management with profiles and validation

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'

# Configuration
CONFIG_DIR="$HOME/.config/ai-cli-tools"
PROFILES_DIR="$CONFIG_DIR/profiles"
CURRENT_PROFILE_FILE="$CONFIG_DIR/current-profile"
DEFAULT_PROFILE="default"

log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
log_warning() { echo -e "${YELLOW}[WARNING]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }

# Initialize configuration system
init_config() {
    log_info "Initializing configuration system..."
    
    mkdir -p "$CONFIG_DIR"
    mkdir -p "$PROFILES_DIR"
    
    if [ ! -f "$CURRENT_PROFILE_FILE" ]; then
        echo "$DEFAULT_PROFILE" > "$CURRENT_PROFILE_FILE"
    fi
    
    if [ ! -f "$PROFILES_DIR/$DEFAULT_PROFILE.env" ]; then
        create_default_profile
    fi
    
    log_success "Configuration system initialized"
}

# Create default profile
create_default_profile() {
    cat > "$PROFILES_DIR/$DEFAULT_PROFILE.env" << 'EOF'
# AI CLI Tools Configuration Profile: default
# Generated on: $(date)

# API Keys
export ANTHROPIC_API_KEY=""
export OPENAI_API_KEY=""
export GOOGLE_API_KEY=""
export PERPLEXITY_API_KEY=""

# Tool Preferences
export AI_DEFAULT_MODEL="gpt-4"
export AI_MAX_TOKENS="4000"
export AI_TEMPERATURE="0.7"

# Editor Settings
export AI_EDITOR="code"
export AI_EDITOR_ARGS="--wait"

# Logging
export AI_LOG_LEVEL="INFO"
export AI_LOG_FILE="$HOME/.local/log/ai-cli.log"

# Cache Settings
export AI_CACHE_ENABLED="true"
export AI_CACHE_DIR="$HOME/.cache/ai-cli"
export AI_CACHE_TTL="3600"

# Network Settings
export AI_TIMEOUT="30"
export AI_RETRY_ATTEMPTS="3"
export AI_PROXY=""

# UI Settings
export AI_COLOR_OUTPUT="true"
export AI_SHOW_PROGRESS="true"
export AI_CONFIRM_ACTIONS="false"
EOF
    
    log_success "Default profile created"
}

# List available profiles
list_profiles() {
    log_info "Available profiles:"
    echo
    
    for profile_file in "$PROFILES_DIR"/*.env; do
        if [ -f "$profile_file" ]; then
            local profile_name=$(basename "$profile_file" .env)
            local current_profile=$(cat "$CURRENT_PROFILE_FILE" 2>/dev/null || echo "none")
            
            if [ "$profile_name" = "$current_profile" ]; then
                echo -e "  ${GREEN}* $profile_name${NC} (current)"
            else
                echo -e "  $profile_name"
            fi
        fi
    done
    echo
}

# Create new profile
create_profile() {
    local profile_name="$1"
    
    if [ -z "$profile_name" ]; then
        echo -e "${CYAN}Enter profile name:${NC}"
        read -r profile_name
    fi
    
    if [ -f "$PROFILES_DIR/$profile_name.env" ]; then
        log_error "Profile '$profile_name' already exists"
        return 1
    fi
    
    # Copy from current profile or create new
    local current_profile=$(cat "$CURRENT_PROFILE_FILE" 2>/dev/null || echo "$DEFAULT_PROFILE")
    if [ -f "$PROFILES_DIR/$current_profile.env" ]; then
        cp "$PROFILES_DIR/$current_profile.env" "$PROFILES_DIR/$profile_name.env"
    else
        create_default_profile
        cp "$PROFILES_DIR/$DEFAULT_PROFILE.env" "$PROFILES_DIR/$profile_name.env"
    fi
    
    # Update profile header
    sed -i "1s/.*/# AI CLI Tools Configuration Profile: $profile_name/" "$PROFILES_DIR/$profile_name.env"
    sed -i "2s/.*/# Generated on: $(date)/" "$PROFILES_DIR/$profile_name.env"
    
    log_success "Profile '$profile_name' created"
}

# Switch profile
switch_profile() {
    local profile_name="$1"
    
    if [ -z "$profile_name" ]; then
        list_profiles
        echo -e "${CYAN}Enter profile name to switch to:${NC}"
        read -r profile_name
    fi
    
    if [ ! -f "$PROFILES_DIR/$profile_name.env" ]; then
        log_error "Profile '$profile_name' not found"
        return 1
    fi
    
    echo "$profile_name" > "$CURRENT_PROFILE_FILE"
    log_success "Switched to profile '$profile_name'"
    
    # Source the new profile
    source "$PROFILES_DIR/$profile_name.env"
}

# Edit profile
edit_profile() {
    local profile_name="$1"
    
    if [ -z "$profile_name" ]; then
        local current_profile=$(cat "$CURRENT_PROFILE_FILE" 2>/dev/null || echo "$DEFAULT_PROFILE")
        profile_name="$current_profile"
    fi
    
    if [ ! -f "$PROFILES_DIR/$profile_name.env" ]; then
        log_error "Profile '$profile_name' not found"
        return 1
    fi
    
    local editor="${EDITOR:-nano}"
    $editor "$PROFILES_DIR/$profile_name.env"
    
    log_success "Profile '$profile_name' updated"
}

# Validate profile
validate_profile() {
    local profile_name="$1"
    
    if [ -z "$profile_name" ]; then
        local current_profile=$(cat "$CURRENT_PROFILE_FILE" 2>/dev/null || echo "$DEFAULT_PROFILE")
        profile_name="$current_profile"
    fi
    
    if [ ! -f "$PROFILES_DIR/$profile_name.env" ]; then
        log_error "Profile '$profile_name' not found"
        return 1
    fi
    
    log_info "Validating profile '$profile_name'..."
    
    # Source the profile
    source "$PROFILES_DIR/$profile_name.env"
    
    local errors=0
    
    # Check required API keys
    if [ -z "$ANTHROPIC_API_KEY" ]; then
        log_warning "ANTHROPIC_API_KEY not set"
    fi
    
    if [ -z "$OPENAI_API_KEY" ]; then
        log_warning "OPENAI_API_KEY not set"
    fi
    
    if [ -z "$GOOGLE_API_KEY" ]; then
        log_warning "GOOGLE_API_KEY not set"
    fi
    
    # Check numeric values
    if ! [[ "$AI_MAX_TOKENS" =~ ^[0-9]+$ ]]; then
        log_error "AI_MAX_TOKENS must be a number"
        ((errors++))
    fi
    
    if ! [[ "$AI_TEMPERATURE" =~ ^[0-9]*\.?[0-9]+$ ]]; then
        log_error "AI_TEMPERATURE must be a number"
        ((errors++))
    fi
    
    if [ $errors -eq 0 ]; then
        log_success "Profile '$profile_name' is valid"
    else
        log_error "Profile '$profile_name' has $errors errors"
        return 1
    fi
}

# Export profile
export_profile() {
    local profile_name="$1"
    local output_file="$2"
    
    if [ -z "$profile_name" ]; then
        local current_profile=$(cat "$CURRENT_PROFILE_FILE" 2>/dev/null || echo "$DEFAULT_PROFILE")
        profile_name="$current_profile"
    fi
    
    if [ -z "$output_file" ]; then
        output_file="$profile_name.env"
    fi
    
    if [ ! -f "$PROFILES_DIR/$profile_name.env" ]; then
        log_error "Profile '$profile_name' not found"
        return 1
    fi
    
    cp "$PROFILES_DIR/$profile_name.env" "$output_file"
    log_success "Profile '$profile_name' exported to '$output_file'"
}

# Import profile
import_profile() {
    local input_file="$1"
    local profile_name="$2"
    
    if [ -z "$input_file" ]; then
        echo -e "${CYAN}Enter path to profile file:${NC}"
        read -r input_file
    fi
    
    if [ ! -f "$input_file" ]; then
        log_error "File '$input_file' not found"
        return 1
    fi
    
    if [ -z "$profile_name" ]; then
        profile_name=$(basename "$input_file" .env)
    fi
    
    cp "$input_file" "$PROFILES_DIR/$profile_name.env"
    log_success "Profile '$profile_name' imported from '$input_file'"
}

# Show current configuration
show_config() {
    local profile_name=$(cat "$CURRENT_PROFILE_FILE" 2>/dev/null || echo "$DEFAULT_PROFILE")
    
    log_info "Current configuration (profile: $profile_name):"
    echo
    
    if [ -f "$PROFILES_DIR/$profile_name.env" ]; then
        source "$PROFILES_DIR/$profile_name.env"
        
        echo "API Keys:"
        echo "  ANTHROPIC_API_KEY: ${ANTHROPIC_API_KEY:+[SET]}"
        echo "  OPENAI_API_KEY: ${OPENAI_API_KEY:+[SET]}"
        echo "  GOOGLE_API_KEY: ${GOOGLE_API_KEY:+[SET]}"
        echo "  PERPLEXITY_API_KEY: ${PERPLEXITY_API_KEY:+[SET]}"
        echo
        echo "Settings:"
        echo "  AI_DEFAULT_MODEL: $AI_DEFAULT_MODEL"
        echo "  AI_MAX_TOKENS: $AI_MAX_TOKENS"
        echo "  AI_TEMPERATURE: $AI_TEMPERATURE"
        echo "  AI_EDITOR: $AI_EDITOR"
        echo "  AI_LOG_LEVEL: $AI_LOG_LEVEL"
    else
        log_error "Current profile not found"
    fi
}

# Main menu
show_menu() {
    echo -e "${PURPLE}================================${NC}"
    echo -e "${PURPLE}  AI CLI Tools Config Manager${NC}"
    echo -e "${PURPLE}================================${NC}"
    echo
    echo "1. List profiles"
    echo "2. Create profile"
    echo "3. Switch profile"
    echo "4. Edit profile"
    echo "5. Validate profile"
    echo "6. Export profile"
    echo "7. Import profile"
    echo "8. Show current config"
    echo "9. Exit"
    echo
}

# Main execution
main() {
    init_config
    
    if [ $# -eq 0 ]; then
        while true; do
            show_menu
            echo -e "${CYAN}Select an option (1-9):${NC}"
            read -r choice
            
            case $choice in
                1) list_profiles ;;
                2) create_profile ;;
                3) switch_profile ;;
                4) edit_profile ;;
                5) validate_profile ;;
                6) export_profile ;;
                7) import_profile ;;
                8) show_config ;;
                9) log_info "Exiting..."; exit 0 ;;
                *) log_error "Invalid option" ;;
            esac
            
            echo -e "${CYAN}Press Enter to continue...${NC}"
            read -r
        done
    else
        # Command line mode
        case "$1" in
            "list") list_profiles ;;
            "create") create_profile "$2" ;;
            "switch") switch_profile "$2" ;;
            "edit") edit_profile "$2" ;;
            "validate") validate_profile "$2" ;;
            "export") export_profile "$2" "$3" ;;
            "import") import_profile "$2" "$3" ;;
            "show") show_config ;;
            *) log_error "Unknown command: $1" ;;
        esac
    fi
}

# Run main function
main "$@"