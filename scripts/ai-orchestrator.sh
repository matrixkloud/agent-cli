#!/bin/bash

# AI Agent Orchestrator
# Unified interface for managing multiple AI agents

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
CONFIG_DIR="$HOME/.config/ai-orchestrator"
AGENTS_FILE="$CONFIG_DIR/agents.json"
SESSIONS_DIR="$CONFIG_DIR/sessions"

# Agent definitions
declare -A AGENT_COMMANDS
AGENT_COMMANDS[claude]="claude"
AGENT_COMMANDS[cursor]="cursor-agent"
AGENT_COMMANDS[gemini]="gemini"
AGENT_COMMANDS[codex]="codex"
AGENT_COMMANDS[perplexity]="perplexity"
AGENT_COMMANDS[ollama]="ollama"
AGENT_COMMANDS[aider]="aider"
AGENT_COMMANDS[ai_shell]="ai"

# Agent capabilities
declare -A AGENT_CAPABILITIES
AGENT_CAPABILITIES[claude]="coding,analysis,reasoning"
AGENT_CAPABILITIES[cursor]="code_editing,ide_integration"
AGENT_CAPABILITIES[gemini]="multimodal,research,analysis"
AGENT_CAPABILITIES[codex]="code_generation,completion"
AGENT_CAPABILITIES[perplexity]="research,fact_checking"
AGENT_CAPABILITIES[ollama]="local_models,privacy"
AGENT_CAPABILITIES[aider]="pair_programming,code_editing"
AGENT_CAPABILITIES[ai_shell]="terminal_assistance,system_tasks"

log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
log_warning() { echo -e "${YELLOW}[WARNING]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }

# Initialize orchestrator
init_orchestrator() {
    mkdir -p "$CONFIG_DIR"
    mkdir -p "$SESSIONS_DIR"
    
    if [ ! -f "$AGENTS_FILE" ]; then
        create_default_config
    fi
}

# Create default configuration
create_default_config() {
    cat > "$AGENTS_FILE" << 'EOF'
{
  "agents": {
    "claude": {
      "enabled": true,
      "priority": 1,
      "capabilities": ["coding", "analysis", "reasoning"],
      "max_tokens": 4000,
      "temperature": 0.7
    },
    "gemini": {
      "enabled": true,
      "priority": 2,
      "capabilities": ["multimodal", "research", "analysis"],
      "max_tokens": 4000,
      "temperature": 0.7
    },
    "codex": {
      "enabled": true,
      "priority": 3,
      "capabilities": ["code_generation", "completion"],
      "max_tokens": 4000,
      "temperature": 0.7
    },
    "perplexity": {
      "enabled": true,
      "priority": 4,
      "capabilities": ["research", "fact_checking"],
      "max_tokens": 4000,
      "temperature": 0.7
    },
    "ollama": {
      "enabled": false,
      "priority": 5,
      "capabilities": ["local_models", "privacy"],
      "max_tokens": 4000,
      "temperature": 0.7
    },
    "aider": {
      "enabled": false,
      "priority": 6,
      "capabilities": ["pair_programming", "code_editing"],
      "max_tokens": 4000,
      "temperature": 0.7
    },
    "ai_shell": {
      "enabled": false,
      "priority": 7,
      "capabilities": ["terminal_assistance", "system_tasks"],
      "max_tokens": 4000,
      "temperature": 0.7
    }
  },
  "routing": {
    "strategy": "capability_based",
    "fallback": "claude",
    "timeout": 30
  }
}
EOF
    
    log_success "Default configuration created"
}

# Check agent availability
check_agent_availability() {
    local agent="$1"
    local command="${AGENT_COMMANDS[$agent]}"
    
    if [ -z "$command" ]; then
        return 1
    fi
    
    command -v "$command" >/dev/null 2>&1
}

# Get available agents
get_available_agents() {
    local available=()
    
    for agent in "${!AGENT_COMMANDS[@]}"; do
        if check_agent_availability "$agent"; then
            available+=("$agent")
        fi
    done
    
    echo "${available[@]}"
}

# Route query to appropriate agent
route_query() {
    local query="$1"
    local capability="$2"
    local agent=""
    
    # Get available agents
    local available_agents=($(get_available_agents))
    
    if [ ${#available_agents[@]} -eq 0 ]; then
        log_error "No AI agents available"
        return 1
    fi
    
    # Simple routing based on capability
    case "$capability" in
        "coding"|"code_generation")
            for a in "${available_agents[@]}"; do
                if [[ "${AGENT_CAPABILITIES[$a]}" == *"coding"* ]] || [[ "${AGENT_CAPABILITIES[$a]}" == *"code_generation"* ]]; then
                    agent="$a"
                    break
                fi
            done
            ;;
        "research"|"fact_checking")
            for a in "${available_agents[@]}"; do
                if [[ "${AGENT_CAPABILITIES[$a]}" == *"research"* ]] || [[ "${AGENT_CAPABILITIES[$a]}" == *"fact_checking"* ]]; then
                    agent="$a"
                    break
                fi
            done
            ;;
        "multimodal")
            for a in "${available_agents[@]}"; do
                if [[ "${AGENT_CAPABILITIES[$a]}" == *"multimodal"* ]]; then
                    agent="$a"
                    break
                fi
            done
            ;;
        "local"|"privacy")
            for a in "${available_agents[@]}"; do
                if [[ "${AGENT_CAPABILITIES[$a]}" == *"local_models"* ]] || [[ "${AGENT_CAPABILITIES[$a]}" == *"privacy"* ]]; then
                    agent="$a"
                    break
                fi
            done
            ;;
        *)
            # Default to first available agent
            agent="${available_agents[0]}"
            ;;
    esac
    
    # Fallback to first available agent
    if [ -z "$agent" ]; then
        agent="${available_agents[0]}"
    fi
    
    echo "$agent"
}

# Execute query with agent
execute_query() {
    local agent="$1"
    local query="$2"
    local command="${AGENT_COMMANDS[$agent]}"
    
    log_info "Executing query with $agent..."
    
    case "$agent" in
        "claude")
            echo "$query" | "$command" chat
            ;;
        "cursor")
            "$command" chat "$query"
            ;;
        "gemini")
            echo "$query" | "$command" chat
            ;;
        "codex")
            echo "$query" | "$command" chat
            ;;
        "perplexity")
            "$command" "$query"
            ;;
        "ollama")
            echo "$query" | "$command" run llama2
            ;;
        "aider")
            "$command" --query "$query"
            ;;
        "ai_shell")
            "$command" "$query"
            ;;
        *)
            log_error "Unknown agent: $agent"
            return 1
            ;;
    esac
}

# Interactive chat mode
chat_mode() {
    log_info "Starting interactive chat mode..."
    echo "Type 'exit' to quit, 'help' for commands"
    echo
    
    local session_id="session-$(date +%s)"
    local session_file="$SESSIONS_DIR/$session_id.log"
    
    while true; do
        echo -n "You: "
        read -r input
        
        case "$input" in
            "exit"|"quit")
                log_info "Exiting chat mode"
                break
                ;;
            "help")
                show_help
                ;;
            "agents")
                show_available_agents
                ;;
            "switch")
                echo -n "Enter agent name: "
                read -r agent
                if check_agent_availability "$agent"; then
                    log_success "Switched to $agent"
                else
                    log_error "Agent $agent not available"
                fi
                ;;
            "")
                continue
                ;;
            *)
                # Route and execute query
                local agent=$(route_query "$input")
                if [ -n "$agent" ]; then
                    echo "AI ($agent): "
                    execute_query "$agent" "$input" | tee -a "$session_file"
                    echo
                else
                    log_error "No suitable agent found"
                fi
                ;;
        esac
    done
}

# Show available agents
show_available_agents() {
    log_info "Available AI agents:"
    echo
    
    local available_agents=($(get_available_agents))
    
    for agent in "${available_agents[@]}"; do
        local capabilities="${AGENT_CAPABILITIES[$agent]}"
        echo "  $agent: $capabilities"
    done
    echo
}

# Show help
show_help() {
    echo "AI Agent Orchestrator Commands:"
    echo "  exit, quit    - Exit chat mode"
    echo "  help          - Show this help"
    echo "  agents        - List available agents"
    echo "  switch        - Switch to specific agent"
    echo "  <query>       - Send query to AI agents"
    echo
}

# Batch processing
batch_process() {
    local input_file="$1"
    local output_file="$2"
    
    if [ ! -f "$input_file" ]; then
        log_error "Input file not found: $input_file"
        return 1
    fi
    
    log_info "Processing batch file: $input_file"
    
    local agent=$(route_query "batch processing")
    local temp_output="/tmp/ai-orchestrator-batch-$$.txt"
    
    while IFS= read -r line; do
        if [ -n "$line" ]; then
            echo "Processing: $line"
            execute_query "$agent" "$line" >> "$temp_output"
            echo "---" >> "$temp_output"
        fi
    done < "$input_file"
    
    if [ -n "$output_file" ]; then
        mv "$temp_output" "$output_file"
        log_success "Batch processing complete: $output_file"
    else
        cat "$temp_output"
        rm "$temp_output"
    fi
}

# Main execution
main() {
    init_orchestrator
    
    case "${1:-chat}" in
        "chat")
            chat_mode
            ;;
        "query")
            if [ -z "$2" ]; then
                log_error "Query required"
                exit 1
            fi
            local agent=$(route_query "$2")
            execute_query "$agent" "$2"
            ;;
        "agents")
            show_available_agents
            ;;
        "batch")
            batch_process "$2" "$3"
            ;;
        "help"|*)
            echo "AI Agent Orchestrator"
            echo
            echo "Usage: $0 <command> [args...]"
            echo
            echo "Commands:"
            echo "  chat              Start interactive chat mode"
            echo "  query <text>      Send single query"
            echo "  agents            List available agents"
            echo "  batch <file> [out] Process batch file"
            echo "  help              Show this help"
            ;;
    esac
}

# Run main function
main "$@"