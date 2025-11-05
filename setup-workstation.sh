#!/bin/bash

# AI Agent CLI Tools Workstation Setup Script
# This script prepares your workstation to use all AI agent CLI tools

# Exit on any error to prevent the script from continuing to run if a command fails.
set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Configuration
SHELL_PROFILE=""
NVM_VERSION="v0.40.3"
NODE_VERSION="22"

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

log_step() {
    echo -e "${PURPLE}[STEP]${NC} $1"
}

# Detect shell and set profile
detect_shell() {
    if [[ "$SHELL" == *"zsh"* ]]; then
        SHELL_PROFILE="$HOME/.zshrc"
        log_info "Detected Zsh shell"
    elif [[ "$SHELL" == *"bash"* ]]; then
        SHELL_PROFILE="$HOME/.bashrc"
        log_info "Detected Bash shell"
    else
        SHELL_PROFILE="$HOME/.bashrc"
        log_warning "Unknown shell, defaulting to bash"
    fi
}

# Check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check system prerequisites
check_prerequisites() {
    log_step "Checking system prerequisites..."

    local missing_deps=()

    # Check for curl
    if ! command_exists curl; then
        missing_deps+=("curl")
    else
        log_success "curl is installed"
    fi

    # Check for wget (optional)
    if ! command_exists wget; then
        log_warning "wget is not installed (optional but recommended)"
    else
        log_success "wget is installed"
    fi

    # Check for git
    if ! command_exists git; then
        missing_deps+=("git")
    else
        log_success "git is installed"
    fi

    # Check for unzip
    if ! command_exists unzip; then
        missing_deps+=("unzip")
    else
        log_success "unzip is installed"
    fi

    if [ ${#missing_deps[@]} -ne 0 ]; then
        log_error "Missing required dependencies: ${missing_deps[*]}"
        log_info "Please install them using your package manager:"
        log_info "  Ubuntu/Debian: sudo apt update && sudo apt install ${missing_deps[*]}"
        log_info "  CentOS/RHEL: sudo yum install ${missing_deps[*]}"
        log_info "  macOS: brew install ${missing_deps[*]}"
        exit 1
    fi
}

# Install Node.js via nvm
install_nodejs() {
    log_step "Installing Node.js via nvm..."

    # Check if nvm is already installed
    if [ -d "$HOME/.nvm" ]; then
        log_info "nvm is already installed, updating..."
        cd "$HOME/.nvm"
        git fetch --tags origin
        git checkout "tags/$NVM_VERSION"
    else
        log_info "Installing nvm $NVM_VERSION..."
        curl -o- "https://raw.githubusercontent.com/nvm-sh/nvm/$NVM_VERSION/install.sh" | bash
    fi

    # Source nvm
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

    # Install Node.js LTS
    log_info "Installing Node.js $NODE_VERSION..."
    nvm install "$NODE_VERSION"
    nvm use "$NODE_VERSION"
    nvm alias default "$NODE_VERSION"

    # Verify installation
    if command_exists node && command_exists npm; then
        log_success "Node.js $(node --version) and npm $(npm --version) installed successfully"
    else
        log_error "Failed to install Node.js"
        exit 1
    fi
}

# Install AI CLI tools
install_ai_tools() {
    log_step "Installing AI CLI tools..."

    local tools=("claude" "cursor" "gemini" "codex" "copilot" "perplexity" "ollama" "aider" "ai_shell")

    for tool in "${tools[@]}"; do
        ./scripts/package-manager.sh install "$tool"
    done
}

# Setup environment variables
setup_environment() {
    log_step "Setting up environment variables..."

    # Create .env file for API keys
    local env_file="$HOME/.ai-cli-env"

    if [ ! -f "$env_file" ]; then
        log_info "Creating environment file: $env_file"
        cat > "$env_file" << 'EOF'
# AI CLI Tools Environment Variables
# Add your API keys here

# Anthropic Claude API Key
# Get from: https://console.anthropic.com/
# export ANTHROPIC_API_KEY="your-anthropic-api-key-here"

# Google Gemini API Key
# Get from: https://makersuite.google.com/app/apikey
# export GOOGLE_API_KEY="your-google-api-key-here"

# OpenAI API Key
# Get from: https://platform.openai.com/api-keys
# export OPENAI_API_KEY="your-openai-api-key-here"

# Perplexity API Key
# Get from: https://www.perplexity.ai/settings/api
# export PERPLEXITY_API_KEY="your-perplexity-api-key-here"
EOF
        log_success "Environment file created: $env_file"
    else
        log_info "Environment file already exists: $env_file"
    fi

    # Add nvm to shell profile
    if ! grep -q "NVM_DIR" "$SHELL_PROFILE"; then
        log_info "Adding nvm configuration to $SHELL_PROFILE"
        cat >> "$SHELL_PROFILE" << 'EOF'

# NVM Configuration
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
EOF
        log_success "NVM configuration added to $SHELL_PROFILE"
    else
        log_info "NVM configuration already exists in $SHELL_PROFILE"
    fi

    # Add AI CLI environment loading
    if ! grep -q "AI CLI Tools" "$SHELL_PROFILE"; then
        log_info "Adding AI CLI environment loading to $SHELL_PROFILE"
        cat >> "$SHELL_PROFILE" << 'EOF'

# AI CLI Tools Environment
if [ -f "$HOME/.ai-cli-env" ]; then
    source "$HOME/.ai-cli-env"
fi
EOF
        log_success "AI CLI environment loading added to $SHELL_PROFILE"
    else
        log_info "AI CLI environment loading already exists in $SHELL_PROFILE"
    fi
}

# Interactive API key setup
setup_api_keys() {
    log_step "Setting up API keys..."

    ./scripts/configure-api-keys.sh
}

# Verify installations
verify_installations() {
    log_step "Verifying installations..."

    ./scripts/quick-test.sh
}

# Create helper scripts
create_helper_scripts() {
    log_step "Creating helper scripts..."

    # Create update script
    cat > "$HOME/.local/bin/update-ai-tools" << 'EOF'
#!/bin/bash
# Update all AI CLI tools

./scripts/package-manager.sh update all
EOF
    chmod +x "$HOME/.local/bin/update-ai-tools"
    log_success "Created update script: ~/.local/bin/update-ai-tools"

    # Create test script
    cat > "$HOME/.local/bin/test-ai-tools" << 'EOF'
#!/bin/bash
# Test all AI CLI tools

./scripts/quick-test.sh
EOF
    chmod +x "$HOME/.local/bin/test-ai-tools"
    log_success "Created test script: ~/.local/bin/test-ai-tools"

    # Ensure .local/bin is in PATH
    if ! echo "$PATH" | grep -q "$HOME/.local/bin"; then
        echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$SHELL_PROFILE"
        log_success "Added ~/.local/bin to PATH"
    fi
}

# Show setup options
show_setup_options() {
    echo -e "${PURPLE}================================${NC}"
    echo -e "${PURPLE}  AI Agent CLI Tools Setup${NC}"
    echo -e "${PURPLE}================================${NC}"
    echo
    echo -e "${CYAN}Choose your setup option:${NC}"
    echo
    echo "1. Install all AI agents (recommended for first-time setup)"
    echo "2. Select specific agents to install"
    echo "3. Show available agents and exit"
    echo "4. Exit"
    echo
}

# Main execution
main() {
    show_setup_options

    echo -e "${CYAN}Enter your choice (1-4):${NC}"
    read -r choice

    case $choice in
        1)
            echo -e "${GREEN}Installing all AI agents...${NC}"
            echo

            # Detect shell
            detect_shell

            # Check prerequisites
            check_prerequisites

            # Install Node.js
            install_nodejs

            # Install AI tools
            install_ai_tools

            # Setup environment
            setup_environment

            # Setup API keys
            setup_api_keys

            # Create helper scripts
            create_helper_scripts

            # Verify installations
            verify_installations

            echo
            echo -e "${GREEN}================================${NC}"
            echo -e "${GREEN}  Setup Complete!${NC}"
            echo -e "${GREEN}================================${NC}"
            echo
            echo -e "${CYAN}Next steps:${NC}"
            echo "1. Restart your terminal or run: source $SHELL_PROFILE"
            echo "2. Configure API keys in: ~/.ai-cli-env"
            echo "3. Test installations: test-ai-tools"
            echo "4. Update tools later: update-ai-tools"
            ;;
        2)
            echo -e "${GREEN}Starting agent selection...${NC}"
            echo
            if [ -f "./scripts/select-agents.sh" ]; then
                chmod +x ./scripts/select-agents.sh
                ./scripts/select-agents.sh
            else
                log_error "Agent selection script not found. Please run from the repository root."
                exit 1
            fi
            ;;
        3)
            echo -e "${CYAN}Available AI agents:${NC}"
            echo
            ./scripts/select-agents.sh -l
            ;;
        4)
            log_info "Exiting..."
            exit 0
            ;;
        *)
            log_error "Invalid choice. Please run the script again and select 1-4."
            exit 1
            ;;
    esac
}

# Run main function
main "$@"
