#!/bin/bash

# Quick Test Script for AI CLI Tools
# This script quickly tests all installed AI CLI tools

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Test results
declare -A test_results

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

# Test if command exists and get version
test_command() {
    local cmd="$1"
    local name="$2"
    
    if command -v "$cmd" >/dev/null 2>&1; then
        local version
        version=$($cmd --version 2>/dev/null || echo "installed")
        test_results["$name"]="✓ $version"
        return 0
    else
        test_results["$name"]="✗ not found"
        return 1
    fi
}

# Test API key availability
test_api_key() {
    local key_name="$1"
    local env_var="$2"
    
    if [ -n "${!env_var}" ]; then
        test_results["$key_name API Key"]="✓ configured"
        return 0
    else
        test_results["$key_name API Key"]="✗ not set"
        return 1
    fi
}

# Test basic functionality
test_basic_functionality() {
    local cmd="$1"
    local name="$2"
    
    if command -v "$cmd" >/dev/null 2>&1; then
        if $cmd --help >/dev/null 2>&1; then
            test_results["$name Help"]="✓ working"
            return 0
        else
            test_results["$name Help"]="✗ help failed"
            return 1
        fi
    else
        test_results["$name Help"]="✗ not found"
        return 1
    fi
}

# Main test function
run_tests() {
    echo -e "${PURPLE}================================${NC}"
    echo -e "${PURPLE}  AI CLI Tools Quick Test${NC}"
    echo -e "${PURPLE}================================${NC}"
    echo
    
    # Source environment variables
    if [ -f "$HOME/.ai-cli-env" ]; then
        source "$HOME/.ai-cli-env"
        log_info "Loaded environment variables"
    else
        log_warning "Environment file not found: ~/.ai-cli-env"
    fi
    
    echo -e "${CYAN}Testing CLI Tools...${NC}"
    echo
    
    # Test Node.js and npm
    test_command "node" "Node.js"
    test_command "npm" "npm"
    echo
    
    # Test AI CLI tools
    echo -e "${CYAN}Testing AI CLI Tools...${NC}"
    test_command "claude" "Claude CLI"
    test_command "cursor-agent" "Cursor CLI"
    test_command "gemini" "Gemini CLI"
    test_command "codex" "Codex CLI"
    echo
    
    # Test API keys
    echo -e "${CYAN}Testing API Keys...${NC}"
    test_api_key "Anthropic" "ANTHROPIC_API_KEY"
    test_api_key "Google" "GOOGLE_API_KEY"
    test_api_key "OpenAI" "OPENAI_API_KEY"
    echo
    
    # Test basic functionality
    echo -e "${CYAN}Testing Basic Functionality...${NC}"
    test_basic_functionality "claude" "Claude"
    test_basic_functionality "cursor-agent" "Cursor"
    test_basic_functionality "gemini" "Gemini"
    test_basic_functionality "codex" "Codex"
    echo
}

# Display results
display_results() {
    echo -e "${PURPLE}================================${NC}"
    echo -e "${PURPLE}  Test Results${NC}"
    echo -e "${PURPLE}================================${NC}"
    echo
    
    # CLI Tools
    echo -e "${CYAN}CLI Tools:${NC}"
    for tool in "Node.js" "npm" "Claude CLI" "Cursor CLI" "Gemini CLI" "Codex CLI"; do
        if [[ "${test_results[$tool]}" == ✓* ]]; then
            echo -e "  ${GREEN}${test_results[$tool]}${NC} - $tool"
        else
            echo -e "  ${RED}${test_results[$tool]}${NC} - $tool"
        fi
    done
    echo
    
    # API Keys
    echo -e "${CYAN}API Keys:${NC}"
    for key in "Anthropic API Key" "Google API Key" "OpenAI API Key"; do
        if [[ "${test_results[$key]}" == ✓* ]]; then
            echo -e "  ${GREEN}${test_results[$key]}${NC} - $key"
        else
            echo -e "  ${YELLOW}${test_results[$key]}${NC} - $key"
        fi
    done
    echo
    
    # Functionality
    echo -e "${CYAN}Functionality:${NC}"
    for func in "Claude Help" "Cursor Help" "Gemini Help" "Codex Help"; do
        if [[ "${test_results[$func]}" == ✓* ]]; then
            echo -e "  ${GREEN}${test_results[$func]}${NC} - $func"
        else
            echo -e "  ${RED}${test_results[$func]}${NC} - $func"
        fi
    done
    echo
}

# Provide recommendations
provide_recommendations() {
    local issues=0
    
    echo -e "${CYAN}Recommendations:${NC}"
    
    # Check for missing CLI tools
    for tool in "Claude CLI" "Cursor CLI" "Gemini CLI" "Codex CLI"; do
        if [[ "${test_results[$tool]}" == ✗* ]]; then
            echo -e "  ${YELLOW}•${NC} Install $tool: Check the installation guide"
            ((issues++))
        fi
    done
    
    # Check for missing API keys
    for key in "Anthropic API Key" "Google API Key" "OpenAI API Key"; do
        if [[ "${test_results[$key]}" == ✗* ]]; then
            echo -e "  ${YELLOW}•${NC} Configure $key: Run configure-api-keys.sh"
            ((issues++))
        fi
    done
    
    # Check for functionality issues
    for func in "Claude Help" "Cursor Help" "Gemini Help" "Codex Help"; do
        if [[ "${test_results[$func]}" == ✗* ]]; then
            echo -e "  ${YELLOW}•${NC} Fix $func: Check installation and permissions"
            ((issues++))
        fi
    done
    
    if [ $issues -eq 0 ]; then
        echo -e "  ${GREEN}•${NC} All systems are working correctly!"
    else
        echo
        echo -e "${YELLOW}Total issues found: $issues${NC}"
    fi
}

# Main execution
main() {
    run_tests
    display_results
    provide_recommendations
    
    echo
    echo -e "${CYAN}For detailed installation guides, see:${NC}"
    echo "  ./tools/ai-assistants/"
    echo "  ./tools/development/"
    echo
    echo -e "${CYAN}To configure API keys:${NC}"
    echo "  ./scripts/configure-api-keys.sh"
}

# Run main function
main "$@"