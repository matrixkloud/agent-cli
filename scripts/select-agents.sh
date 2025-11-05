#!/bin/bash

# AI Agent Selection Script
# This script allows users to select which AI agents they want to install

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Agent definitions
declare -A AGENTS
AGENTS[claude]="Claude CLI|Anthropic's Claude AI assistant|curl -fsSL https://claude.ai/install.sh | bash|npm install -g @anthropic-ai/claude-code|ANTHROPIC_API_KEY"
AGENTS[cursor]="Cursor CLI|Cursor's AI-powered code editor CLI|curl https://cursor.com/install -fsSL | bash||"
AGENTS[gemini]="Gemini CLI|Google's Gemini AI assistant||npm install -g @google/gemini-cli|GOOGLE_API_KEY"
AGENTS[codex]="Codex CLI|OpenAI's Codex AI assistant||npm install -g @openai/codex|OPENAI_API_KEY"
AGENTS[copilot]="GitHub Copilot CLI|Microsoft's GitHub Copilot CLI||gh extension install github/gh-copilot|"
AGENTS[perplexity]="Perplexity CLI|Perplexity AI research assistant||pip install perplexity-ai|PERPLEXITY_API_KEY"
AGENTS[ollama]="Ollama CLI|Local AI models (Llama, Mistral, etc.)|curl -fsSL https://ollama.ai/install.sh | sh||"
AGENTS[aider]="Aider CLI|AI pair programming tool||pip install aider-chat|OPENAI_API_KEY"
AGENTS[ai_shell]="AI Shell|Terminal AI assistant||pip install ai-shell|OPENAI_API_KEY"

# Selected agents
declare -a SELECTED_AGENTS=()

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

# Display agent information
display_agent_info() {
    local agent_key="$1"
    local agent_info="${AGENTS[$agent_key]}"
    IFS='|' read -r name description install_cmd1 install_cmd2 api_key <<< "$agent_info"
    
    echo -e "${CYAN}$name${NC}"
    echo "  Description: $description"
    if [ -n "$install_cmd1" ]; then
        echo "  Install: $install_cmd1"
    fi
    if [ -n "$install_cmd2" ]; then
        echo "  Install: $install_cmd2"
    fi
    if [ -n "$api_key" ]; then
        echo "  API Key: $api_key"
    else
        echo "  API Key: Not required"
    fi
    echo
}

# Show all available agents
show_available_agents() {
    echo -e "${PURPLE}================================${NC}"
    echo -e "${PURPLE}  Available AI Agents${NC}"
    echo -e "${PURPLE}================================${NC}"
    echo
    
    local i=1
    for agent_key in "${!AGENTS[@]}"; do
        local agent_info="${AGENTS[$agent_key]}"
        IFS='|' read -r name description install_cmd1 install_cmd2 api_key <<< "$agent_info"
        
        echo -e "${CYAN}$i. $name${NC}"
        echo "   $description"
        if [ -n "$api_key" ]; then
            echo -e "   ${YELLOW}Requires API key: $api_key${NC}"
        fi
        echo
        ((i++))
    done
}

# Show selection menu
show_selection_menu() {
    echo -e "${PURPLE}================================${NC}"
    echo -e "${PURPLE}  Agent Selection Menu${NC}"
    echo -e "${PURPLE}================================${NC}"
    echo
    
    local i=1
    for agent_key in "${!AGENTS[@]}"; do
        local agent_info="${AGENTS[$agent_key]}"
        IFS='|' read -r name description install_cmd1 install_cmd2 api_key <<< "$agent_info"
        
        local status=""
        if [[ " ${SELECTED_AGENTS[@]} " =~ " $agent_key " ]]; then
            status=" ✓"
        fi
        
        echo -e "${CYAN}$i.${NC} $name$status"
        ((i++))
    done
    
    echo
    echo -e "${YELLOW}Commands:${NC}"
    echo "  [1-9] - Toggle agent selection"
    echo "  a     - Select all agents"
    echo "  n     - Select none"
    echo "  i     - Show agent information"
    echo "  s     - Show selected agents"
    echo "  c     - Continue with selection"
    echo "  q     - Quit"
    echo
}

# Toggle agent selection
toggle_agent() {
    local choice="$1"
    local agent_keys=($(printf '%s\n' "${!AGENTS[@]}" | sort))
    local agent_key="${agent_keys[$((choice-1))]}"
    
    if [[ " ${SELECTED_AGENTS[@]} " =~ " $agent_key " ]]; then
        # Remove from selection
        SELECTED_AGENTS=($(printf '%s\n' "${SELECTED_AGENTS[@]}" | grep -v "^$agent_key$"))
        log_info "Deselected $agent_key"
    else
        # Add to selection
        SELECTED_AGENTS+=("$agent_key")
        log_success "Selected $agent_key"
    fi
}

# Select all agents
select_all() {
    SELECTED_AGENTS=($(printf '%s\n' "${!AGENTS[@]}" | sort))
    log_success "Selected all agents"
}

# Select none
select_none() {
    SELECTED_AGENTS=()
    log_info "Deselected all agents"
}

# Show agent information
show_agent_info() {
    echo -e "${CYAN}Enter agent number (1-9) to see details:${NC}"
    read -r choice

    if [[ "$choice" =~ ^[1-9]$ ]]; then
        local agent_keys=($(printf '%s\n' "${!AGENTS[@]}" | sort))
        local agent_key="${agent_keys[$((choice-1))]}"
        display_agent_info "$agent_key"
    else
        log_error "Invalid choice. Please enter 1-9."
    fi
}

# Show selected agents
show_selected() {
    if [ ${#SELECTED_AGENTS[@]} -eq 0 ]; then
        log_warning "No agents selected"
    else
        echo -e "${GREEN}Selected agents:${NC}"
        for agent_key in "${SELECTED_AGENTS[@]}"; do
            local agent_info="${AGENTS[$agent_key]}"
            IFS='|' read -r name description install_cmd1 install_cmd2 api_key <<< "$agent_info"
            echo "  - $name"
        done
    fi
    echo
}

# Generate installation script
generate_installation_script() {
    local script_file="$HOME/.local/bin/install-selected-agents"
    
    cat > "$script_file" << 'EOF'
#!/bin/bash
# Install selected AI agents

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check prerequisites
check_prerequisites() {
    log_info "Checking prerequisites..."
    
    # Check for Node.js
    if ! command -v node >/dev/null 2>&1; then
        log_error "Node.js not found. Please install Node.js first."
        exit 1
    fi
    
    # Check for pip
    if ! command -v pip >/dev/null 2>&1; then
        log_error "pip not found. Please install Python and pip first."
        exit 1
    fi
    
    log_success "Prerequisites check passed"
}

# Install agents
install_agents() {
    log_info "Installing selected agents..."
    
EOF

    # Add installation commands for selected agents
    for agent_key in "${SELECTED_AGENTS[@]}"; do
        local agent_info="${AGENTS[$agent_key]}"
        IFS='|' read -r name description install_cmd1 install_cmd2 api_key <<< "$agent_info"
        
        echo "    # Install $name" >> "$script_file"
        if [ -n "$install_cmd1" ]; then
            echo "    log_info \"Installing $name...\"" >> "$script_file"
            echo "    if $install_cmd1; then" >> "$script_file"
            echo "        log_success \"$name installed successfully\"" >> "$script_file"
            echo "    else" >> "$script_file"
            echo "        log_error \"Failed to install $name\"" >> "$script_file"
            echo "    fi" >> "$script_file"
        fi
        if [ -n "$install_cmd2" ]; then
            echo "    log_info \"Installing $name...\"" >> "$script_file"
            echo "    if $install_cmd2; then" >> "$script_file"
            echo "        log_success \"$name installed successfully\"" >> "$script_file"
            echo "    else" >> "$script_file"
            echo "        log_error \"Failed to install $name\"" >> "$script_file"
            echo "    fi" >> "$script_file"
        fi
        echo "" >> "$script_file"
    done

    cat >> "$script_file" << 'EOF'
    log_success "Installation complete!"
}

# Main execution
main() {
    check_prerequisites
    install_agents
}

main "$@"
EOF

    chmod +x "$script_file"
    log_success "Generated installation script: $script_file"
}

# Main selection loop
main_selection() {
    while true; do
        clear
        show_selection_menu
        
        echo -e "${CYAN}Enter your choice:${NC}"
        read -r choice
        
        case $choice in
            [1-9])
                toggle_agent "$choice"
                ;;
            a|A)
                select_all
                ;;
            n|N)
                select_none
                ;;
            i|I)
                show_agent_info
                ;;
            s|S)
                show_selected
                ;;
            c|C)
                if [ ${#SELECTED_AGENTS[@]} -eq 0 ]; then
                    log_warning "No agents selected. Please select at least one agent."
                    echo -e "${YELLOW}Press Enter to continue...${NC}"
                    read -r
                    continue
                fi
                break
                ;;
            q|Q)
                log_info "Exiting..."
                exit 0
                ;;
            *)
                log_error "Invalid choice. Please try again."
                echo -e "${YELLOW}Press Enter to continue...${NC}"
                read -r
                ;;
        esac
    done
}

# Show final selection and confirm
confirm_selection() {
    clear
    echo -e "${PURPLE}================================${NC}"
    echo -e "${PURPLE}  Final Selection${NC}"
    echo -e "${PURPLE}================================${NC}"
    echo
    
    show_selected
    
    echo -e "${CYAN}Do you want to proceed with this selection? (y/n):${NC}"
    read -r confirm
    
    if [[ "$confirm" =~ ^[Yy]$ ]]; then
        log_success "Proceeding with selected agents..."
        generate_installation_script
        echo
        echo -e "${GREEN}Next steps:${NC}"
        echo "1. Run: ~/.local/bin/install-selected-agents"
        echo "2. Configure API keys as needed"
        echo "3. Test your installations"
    else
        log_info "Selection cancelled."
        exit 0
    fi
}

# Main execution
main() {
    echo -e "${PURPLE}================================${NC}"
    echo -e "${PURPLE}  AI Agent Selector${NC}"
    echo -e "${PURPLE}================================${NC}"
    echo
    
    show_available_agents
    echo -e "${YELLOW}Press Enter to start selection...${NC}"
    read -r
    
    main_selection
    confirm_selection
}

# Run main function
main "$@"
