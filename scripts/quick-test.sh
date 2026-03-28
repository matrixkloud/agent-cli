#!/bin/bash

# Quick verification for AI CLI tools and common credentials.

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'

declare -A test_results

log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

record_result() {
    local name="$1"
    local status="$2"
    test_results["$name"]="$status"
}

load_environment() {
    if [ -f "$HOME/.ai-cli-env" ]; then
        # shellcheck disable=SC1090
        source "$HOME/.ai-cli-env"
        log_info "Loaded environment variables from ~/.ai-cli-env"
    else
        log_warning "Environment file not found: ~/.ai-cli-env"
    fi
}

test_command() {
    local name="$1"
    local cmd="$2"

    if command -v "$cmd" >/dev/null 2>&1; then
        local version
        version="$(timeout 5 "$cmd" --version 2>/dev/null | head -n 1)"
        if [ -z "$version" ]; then
            version="installed"
        fi
        record_result "$name" "ok:$version"
    else
        record_result "$name" "missing:not found"
    fi
}

test_help_command() {
    local name="$1"
    shift

    if timeout 5 "$@" >/dev/null 2>&1; then
        record_result "$name" "ok:working"
    else
        record_result "$name" "missing:failed"
    fi
}

test_api_key() {
    local label="$1"
    local env_var="$2"

    if [ -n "${!env_var:-}" ]; then
        record_result "$label" "ok:configured"
    else
        record_result "$label" "warn:not set"
    fi
}

test_copilot() {
    if ! command -v gh >/dev/null 2>&1; then
        record_result "GitHub Copilot CLI" "missing:gh not found"
        record_result "GitHub Copilot Help" "missing:gh not found"
        return
    fi

    if gh extension list 2>/dev/null | grep -q 'github/gh-copilot'; then
        local version
        version="$(gh --version 2>/dev/null | head -n 1)"
        record_result "GitHub Copilot CLI" "ok:${version:-installed}"
        test_help_command "GitHub Copilot Help" gh copilot --help
    else
        record_result "GitHub Copilot CLI" "missing:extension not found"
        record_result "GitHub Copilot Help" "missing:extension not found"
    fi
}

print_result() {
    local label="$1"
    local result="$2"
    local state="${result%%:*}"
    local detail="${result#*:}"

    case "$state" in
        ok)
            echo -e "  ${GREEN}$detail${NC} - $label"
            ;;
        warn)
            echo -e "  ${YELLOW}$detail${NC} - $label"
            ;;
        *)
            echo -e "  ${RED}$detail${NC} - $label"
            ;;
    esac
}

run_tests() {
    echo -e "${PURPLE}================================${NC}"
    echo -e "${PURPLE}  AI CLI Tools Quick Test${NC}"
    echo -e "${PURPLE}================================${NC}"
    echo

    load_environment

    echo -e "${CYAN}Testing CLI tools...${NC}"
    test_command "Node.js" "node"
    test_command "npm" "npm"
    test_command "Claude CLI" "claude"
    test_command "Cursor CLI" "cursor-agent"
    test_command "Gemini CLI" "gemini"
    test_command "Codex CLI" "codex"
    test_command "Perplexity CLI" "perplexity"
    test_command "Ollama CLI" "ollama"
    test_command "Aider CLI" "aider"
    test_command "AI Shell" "ai"
    test_copilot
    echo

    echo -e "${CYAN}Testing API keys...${NC}"
    test_api_key "Anthropic API Key" "ANTHROPIC_API_KEY"
    test_api_key "Google API Key" "GOOGLE_API_KEY"
    test_api_key "OpenAI API Key" "OPENAI_API_KEY"
    test_api_key "Perplexity API Key" "PERPLEXITY_API_KEY"
    echo

    echo -e "${CYAN}Testing basic functionality...${NC}"
    test_help_command "Claude Help" claude --help
    test_help_command "Cursor Help" cursor-agent --help
    test_help_command "Gemini Help" gemini --help
    test_help_command "Codex Help" codex --help
    test_help_command "Perplexity Help" perplexity --help
    test_help_command "Ollama Help" ollama --help
    test_help_command "Aider Help" aider --help
    test_help_command "AI Shell Help" ai --help
    echo
}

display_results() {
    echo -e "${PURPLE}================================${NC}"
    echo -e "${PURPLE}  Test Results${NC}"
    echo -e "${PURPLE}================================${NC}"
    echo

    echo -e "${CYAN}CLI Tools:${NC}"
    for tool in \
        "Node.js" "npm" "Claude CLI" "Cursor CLI" "Gemini CLI" "Codex CLI" \
        "GitHub Copilot CLI" "Perplexity CLI" "Ollama CLI" "Aider CLI" "AI Shell"
    do
        print_result "$tool" "${test_results[$tool]}"
    done
    echo

    echo -e "${CYAN}API Keys:${NC}"
    for key in \
        "Anthropic API Key" "Google API Key" "OpenAI API Key" "Perplexity API Key"
    do
        print_result "$key" "${test_results[$key]}"
    done
    echo

    echo -e "${CYAN}Functionality:${NC}"
    for func in \
        "Claude Help" "Cursor Help" "Gemini Help" "Codex Help" "GitHub Copilot Help" \
        "Perplexity Help" "Ollama Help" "Aider Help" "AI Shell Help"
    do
        print_result "$func" "${test_results[$func]}"
    done
    echo
}

provide_recommendations() {
    local issues=0

    echo -e "${CYAN}Recommendations:${NC}"

    for tool in \
        "Claude CLI" "Cursor CLI" "Gemini CLI" "Codex CLI" "GitHub Copilot CLI" \
        "Perplexity CLI" "Ollama CLI" "Aider CLI" "AI Shell"
    do
        case "${test_results[$tool]}" in
            missing:*)
                echo -e "  ${YELLOW}-${NC} Install $tool using the matching guide under ./tools/ai-assistants/"
                ((issues+=1))
                ;;
        esac
    done

    for key in \
        "Anthropic API Key" "Google API Key" "OpenAI API Key" "Perplexity API Key"
    do
        case "${test_results[$key]}" in
            warn:*)
                echo -e "  ${YELLOW}-${NC} Configure $key with ./scripts/configure-api-keys.sh"
                ((issues+=1))
                ;;
        esac
    done

    for func in \
        "Claude Help" "Cursor Help" "Gemini Help" "Codex Help" "GitHub Copilot Help" \
        "Perplexity Help" "Ollama Help" "Aider Help" "AI Shell Help"
    do
        case "${test_results[$func]}" in
            missing:*)
                echo -e "  ${YELLOW}-${NC} Recheck $func; the binary may be installed incorrectly or missing permissions"
                ((issues+=1))
                ;;
        esac
    done

    if [ "$issues" -eq 0 ]; then
        echo -e "  ${GREEN}-${NC} Core checks passed"
    else
        echo
        echo -e "${YELLOW}Total issues found: $issues${NC}"
    fi
}

main() {
    run_tests
    display_results
    provide_recommendations

    echo
    echo -e "${CYAN}Reference paths:${NC}"
    echo "  ./tools/ai-assistants/"
    echo "  ./tools/development/"
    echo "  ./scripts/configure-api-keys.sh"
}

main "$@"
