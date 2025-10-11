#!/bin/bash

# AI Agent CLI Tools Workstation Setup Script
# This script prepares your workstation to use all AI agent CLI tools

set -e  # Exit on any error

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
    
    # Update npm to latest version
    log_info "Updating npm to latest version..."
    npm install -g npm@latest
    
    # Install Claude CLI
    log_info "Installing Claude CLI..."
    if npm install -g @anthropic-ai/claude-code; then
        log_success "Claude CLI installed successfully"
    else
        log_warning "Failed to install Claude CLI via npm, trying alternative method..."
        curl -fsSL https://claude.ai/install.sh | bash || log_warning "Claude CLI installation failed"
    fi
    
    # Install Gemini CLI
    log_info "Installing Gemini CLI..."
    if npm install -g @google/gemini-cli; then
        log_success "Gemini CLI installed successfully"
    else
        log_warning "Gemini CLI installation failed"
    fi
    
    # Install Codex CLI
    log_info "Installing Codex CLI..."
    if npm install -g @openai/codex; then
        log_success "Codex CLI installed successfully"
    else
        log_warning "Codex CLI installation failed"
    fi
    
    # Install Cursor CLI
    log_info "Installing Cursor CLI..."
    if curl https://cursor.com/install -fsSL | bash; then
        log_success "Cursor CLI installed successfully"
    else
        log_warning "Cursor CLI installation failed"
    fi
    
    # Install GitHub Copilot CLI
    log_info "Installing GitHub Copilot CLI..."
    if command_exists gh; then
        if gh extension install github/gh-copilot; then
            log_success "GitHub Copilot CLI installed successfully"
        else
            log_warning "GitHub Copilot CLI installation failed"
        fi
    else
        log_warning "GitHub CLI not found, skipping Copilot CLI installation"
    fi
    
    # Install Perplexity CLI
    log_info "Installing Perplexity CLI..."
    if command_exists pip; then
        if pip install --user perplexity-ai; then
            log_success "Perplexity CLI installed successfully"
        else
            log_warning "Perplexity CLI installation failed"
        fi
    else
        log_warning "pip not found, skipping Perplexity CLI installation"
    fi
    
    # Install Ollama CLI
    log_info "Installing Ollama CLI..."
    if curl -fsSL https://ollama.ai/install.sh | sh; then
        log_success "Ollama CLI installed successfully"
    else
        log_warning "Ollama CLI installation failed"
    fi
    
    # Install Aider CLI
    log_info "Installing Aider CLI..."
    if command_exists pip; then
        if pip install --user aider-chat; then
            log_success "Aider CLI installed successfully"
        else
            log_warning "Aider CLI installation failed"
        fi
    else
        log_warning "pip not found, skipping Aider CLI installation"
    fi
    
    # Install AI Shell
    log_info "Installing AI Shell..."
    if command_exists pip; then
        if pip install --user ai-shell; then
            log_success "AI Shell installed successfully"
        else
            log_warning "AI Shell installation failed"
        fi
    else
        log_warning "pip not found, skipping AI Shell installation"
    fi
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
    
    local env_file="$HOME/.ai-cli-env"
    
    echo -e "${CYAN}Would you like to set up API keys now? (y/n)${NC}"
    read -r response
    
    if [[ "$response" =~ ^[Yy]$ ]]; then
        log_info "Setting up API keys..."
        
        # Anthropic API Key
        echo -e "${CYAN}Enter your Anthropic API key (or press Enter to skip):${NC}"
        read -r anthropic_key
        if [ -n "$anthropic_key" ]; then
            sed -i "s/# export ANTHROPIC_API_KEY=.*/export ANTHROPIC_API_KEY=\"$anthropic_key\"/" "$env_file"
            log_success "Anthropic API key configured"
        fi
        
        # Google API Key
        echo -e "${CYAN}Enter your Google API key (or press Enter to skip):${NC}"
        read -r google_key
        if [ -n "$google_key" ]; then
            sed -i "s/# export GOOGLE_API_KEY=.*/export GOOGLE_API_KEY=\"$google_key\"/" "$env_file"
            log_success "Google API key configured"
        fi
        
        # OpenAI API Key
        echo -e "${CYAN}Enter your OpenAI API key (or press Enter to skip):${NC}"
        read -r openai_key
        if [ -n "$openai_key" ]; then
            sed -i "s/# export OPENAI_API_KEY=.*/export OPENAI_API_KEY=\"$openai_key\"/" "$env_file"
            log_success "OpenAI API key configured"
        fi
        
        # Source the environment file
        source "$env_file"
        log_success "API keys configured and loaded"
    else
        log_info "Skipping API key setup. You can configure them later by editing $env_file"
    fi
}

# Verify installations
verify_installations() {
    log_step "Verifying installations..."
    
    local all_good=true
    
    # Check Node.js
    if command_exists node; then
        log_success "Node.js: $(node --version)"
    else
        log_error "Node.js not found"
        all_good=false
    fi
    
    # Check npm
    if command_exists npm; then
        log_success "npm: $(npm --version)"
    else
        log_error "npm not found"
        all_good=false
    fi
    
    # Check Claude CLI
    if command_exists claude; then
        log_success "Claude CLI: $(claude --version 2>/dev/null || echo 'installed')"
    else
        log_warning "Claude CLI not found"
    fi
    
    # Check Cursor CLI
    if command_exists cursor-agent; then
        log_success "Cursor CLI: $(cursor-agent --version 2>/dev/null || echo 'installed')"
    else
        log_warning "Cursor CLI not found"
    fi
    
    # Check Gemini CLI
    if command_exists gemini; then
        log_success "Gemini CLI: $(gemini --version 2>/dev/null || echo 'installed')"
    else
        log_warning "Gemini CLI not found"
    fi
    
    # Check Codex CLI
    if command_exists codex; then
        log_success "Codex CLI: $(codex --version 2>/dev/null || echo 'installed')"
    else
        log_warning "Codex CLI not found"
    fi
    
    # Check GitHub Copilot CLI
    if command_exists gh && gh extension list | grep -q "github/gh-copilot"; then
        log_success "GitHub Copilot CLI: installed"
    else
        log_warning "GitHub Copilot CLI not found"
    fi
    
    # Check Perplexity CLI
    if command_exists perplexity; then
        log_success "Perplexity CLI: $(perplexity --version 2>/dev/null || echo 'installed')"
    else
        log_warning "Perplexity CLI not found"
    fi
    
    # Check Ollama CLI
    if command_exists ollama; then
        log_success "Ollama CLI: $(ollama --version 2>/dev/null || echo 'installed')"
    else
        log_warning "Ollama CLI not found"
    fi
    
    # Check Aider CLI
    if command_exists aider; then
        log_success "Aider CLI: $(aider --version 2>/dev/null || echo 'installed')"
    else
        log_warning "Aider CLI not found"
    fi
    
    # Check AI Shell
    if command_exists ai; then
        log_success "AI Shell: $(ai --version 2>/dev/null || echo 'installed')"
    else
        log_warning "AI Shell not found"
    fi
    
    if [ "$all_good" = true ]; then
        log_success "Core installations verified successfully"
    else
        log_warning "Some installations may have issues"
    fi
}

# Create helper scripts
create_helper_scripts() {
    log_step "Creating helper scripts..."
    
    # Create update script
    cat > "$HOME/.local/bin/update-ai-tools" << 'EOF'
#!/bin/bash
# Update all AI CLI tools

echo "Updating AI CLI tools..."

# Update npm
npm install -g npm@latest

# Update AI tools via npm
npm update -g @anthropic-ai/claude-code
npm update -g @google/gemini-cli
npm update -g @openai/codex

# Update AI tools via pip
pip install --upgrade perplexity-ai aider-chat ai-shell

# Update Cursor CLI
curl https://cursor.com/install -fsSL | bash

# Update Ollama CLI
curl -fsSL https://ollama.ai/install.sh | sh

# Update GitHub Copilot CLI
if command -v gh >/dev/null 2>&1; then
    gh extension upgrade github/gh-copilot
fi

echo "Update complete!"
EOF
    chmod +x "$HOME/.local/bin/update-ai-tools"
    log_success "Created update script: ~/.local/bin/update-ai-tools"
    
    # Create test script
    cat > "$HOME/.local/bin/test-ai-tools" << 'EOF'
#!/bin/bash
# Test all AI CLI tools

echo "Testing AI CLI tools..."

# Test Claude CLI
if command -v claude >/dev/null 2>&1; then
    echo "✓ Claude CLI: $(claude --version 2>/dev/null || echo 'installed')"
else
    echo "✗ Claude CLI: not found"
fi

# Test Cursor CLI
if command -v cursor-agent >/dev/null 2>&1; then
    echo "✓ Cursor CLI: $(cursor-agent --version 2>/dev/null || echo 'installed')"
else
    echo "✗ Cursor CLI: not found"
fi

# Test Gemini CLI
if command -v gemini >/dev/null 2>&1; then
    echo "✓ Gemini CLI: $(gemini --version 2>/dev/null || echo 'installed')"
else
    echo "✗ Gemini CLI: not found"
fi

# Test Codex CLI
if command -v codex >/dev/null 2>&1; then
    echo "✓ Codex CLI: $(codex --version 2>/dev/null || echo 'installed')"
else
    echo "✗ Codex CLI: not found"
fi

# Test GitHub Copilot CLI
if command -v gh >/dev/null 2>&1 && gh extension list | grep -q "github/gh-copilot"; then
    echo "✓ GitHub Copilot CLI: installed"
else
    echo "✗ GitHub Copilot CLI: not found"
fi

# Test Perplexity CLI
if command -v perplexity >/dev/null 2>&1; then
    echo "✓ Perplexity CLI: $(perplexity --version 2>/dev/null || echo 'installed')"
else
    echo "✗ Perplexity CLI: not found"
fi

# Test Ollama CLI
if command -v ollama >/dev/null 2>&1; then
    echo "✓ Ollama CLI: $(ollama --version 2>/dev/null || echo 'installed')"
else
    echo "✗ Ollama CLI: not found"
fi

# Test Aider CLI
if command -v aider >/dev/null 2>&1; then
    echo "✓ Aider CLI: $(aider --version 2>/dev/null || echo 'installed')"
else
    echo "✗ Aider CLI: not found"
fi

# Test AI Shell
if command -v ai >/dev/null 2>&1; then
    echo "✓ AI Shell: $(ai --version 2>/dev/null || echo 'installed')"
else
    echo "✗ AI Shell: not found"
fi
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
            echo
            echo -e "${CYAN}Available commands:${NC}"
            echo "  claude --help"
            echo "  cursor-agent --help"
            echo "  gemini --help"
            echo "  codex --help"
            echo "  gh copilot --help"
            echo "  perplexity --help"
            echo "  ollama --help"
            echo "  aider --help"
            echo "  ai --help"
            echo
            echo -e "${YELLOW}Note: Some tools may require API keys to function properly.${NC}"
            echo -e "${YELLOW}Edit ~/.ai-cli-env to configure your API keys.${NC}"
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
            echo "1. Claude CLI - Anthropic's Claude AI assistant"
            echo "2. Cursor CLI - Cursor's AI-powered code editor CLI"
            echo "3. Gemini CLI - Google's Gemini AI assistant"
            echo "4. Codex CLI - OpenAI's Codex AI assistant"
            echo "5. GitHub Copilot CLI - Microsoft's GitHub Copilot CLI"
            echo "6. Perplexity CLI - Perplexity AI research assistant"
            echo "7. Ollama CLI - Local AI models (Llama, Mistral, etc.)"
            echo "8. Aider CLI - AI pair programming tool"
            echo "9. AI Shell - Terminal AI assistant"
            echo
            echo -e "${CYAN}Run './scripts/select-agents.sh' to select specific agents.${NC}"
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