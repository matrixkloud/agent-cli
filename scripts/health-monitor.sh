#!/bin/bash

# AI CLI Tools Health Monitor
# Comprehensive health monitoring and diagnostics

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
LOG_DIR="$HOME/.local/log/ai-cli"
HEALTH_LOG="$LOG_DIR/health.log"
METRICS_FILE="$LOG_DIR/metrics.json"

# Health status
declare -A HEALTH_STATUS
HEALTH_STATUS[overall]="unknown"
HEALTH_STATUS[tool-availability]="unknown"
HEALTH_STATUS[api-keys]="unknown"
HEALTH_STATUS[network-connectivity]="unknown"
HEALTH_STATUS[system-resources]="unknown"

# Logging functions
log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
log_warning() { echo -e "${YELLOW}[WARNING]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }

# Initialize monitoring
init_monitoring() {
    mkdir -p "$LOG_DIR"
    touch "$HEALTH_LOG"
    touch "$METRICS_FILE"
}

# Check the availability of a single tool
check_tool() {
    local tool_name="$1"
    local command_name="$2"

    if command -v "$command_name" >/dev/null 2>&1; then
        log_success "$tool_name: available"
        return 0
    else
        log_warning "$tool_name: not found"
        return 1
    fi
}

# Check the availability of all tools
check_all_tools() {
    log_info "Checking tool availability..."

    local tools=("claude:claude" "cursor:cursor-agent" "gemini:gemini" "codex:codex" "perplexity:perplexity" "ollama:ollama" "aider:aider" "ai_shell:ai")
    local available_tools=0
    local missing_tools=0

    for tool in "${tools[@]}"; do
        IFS=':' read -ra parts <<< "$tool"
        local tool_name="${parts[0]}"
        local command_name="${parts[1]}"

        if check_tool "$tool_name" "$command_name"; then
            ((available_tools++))
        else
            ((missing_tools++))
        fi
    done

    if [ $missing_tools -eq 0 ]; then
        HEALTH_STATUS[tool-availability]="healthy"
    elif [ $available_tools -gt 0 ]; then
        HEALTH_STATUS[tool-availability]="degraded"
    else
        HEALTH_STATUS[tool-availability]="unhealthy"
    fi

    echo "Available: $available_tools/${#tools[@]}"
    echo "Missing: $missing_tools"
}

# Check API keys
check_api_keys() {
    log_info "Checking API key configuration..."

    # Source environment
    if [ -f "$HOME/.ai-cli-env" ]; then
        source "$HOME/.ai-cli-env"
    fi

    local api_keys=("ANTHROPIC_API_KEY" "OPENAI_API_KEY" "GOOGLE_API_KEY" "PERPLEXITY_API_KEY")
    local configured_keys=0
    local missing_keys=0

    for key in "${api_keys[@]}"; do
        if [ -n "${!key}" ]; then
            log_success "$key: configured"
            ((configured_keys++))
        else
            log_warning "$key: not set"
            ((missing_keys++))
        fi
    done

    if [ $missing_keys -eq 0 ]; then
        HEALTH_STATUS[api-keys]="healthy"
    elif [ $configured_keys -gt 0 ]; then
        HEALTH_STATUS[api-keys]="degraded"
    else
        HEALTH_STATUS[api-keys]="unhealthy"
    fi

    echo "Configured: $configured_keys/${#api_keys[@]}"
    echo "Missing: $missing_keys"
}

# Test API connectivity
test_api_connectivity() {
    log_info "Testing API connectivity..."

    local api_tests=0
    local api_success=0

    # Test Anthropic API
    if [ -n "$ANTHROPIC_API_KEY" ]; then
        ((api_tests++))
        if curl -s -H "Authorization: Bearer $ANTHROPIC_API_KEY" \
               -H "Content-Type: application/json" \
               -d '{"model":"claude-3-sonnet-20240229","max_tokens":10,"messages":[{"role":"user","content":"test"}]}' \
               https://api.anthropic.com/v1/messages >/dev/null 2>&1; then
            log_success "Anthropic API: accessible"
            ((api_success++))
        else
            log_warning "Anthropic API: connection failed"
        fi
    fi

    # Test OpenAI API
    if [ -n "$OPENAI_API_KEY" ]; then
        ((api_tests++))
        if curl -s -H "Authorization: Bearer $OPENAI_API_KEY" \
               -H "Content-Type: application/json" \
               -d '{"model":"gpt-3.5-turbo","max_tokens":10,"messages":[{"role":"user","content":"test"}]}' \
               https://api.openai.com/v1/chat/completions >/dev/null 2>&1; then
            log_success "OpenAI API: accessible"
            ((api_success++))
        else
            log_warning "OpenAI API: connection failed"
        fi
    fi

    # Test Google API
    if [ -n "$GOOGLE_API_KEY" ]; then
        ((api_tests++))
        if curl -s -H "Content-Type: application/json" \
               -d '{"contents":[{"parts":[{"text":"test"}]}]}' \
               "https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=$GOOGLE_API_KEY" >/dev/null 2>&1; then
            log_success "Google API: accessible"
            ((api_success++))
        else
            log_warning "Google API: connection failed"
        fi
    fi

    if [ $api_tests -eq 0 ]; then
        HEALTH_STATUS[network-connectivity]="unknown"
    elif [ $api_success -eq $api_tests ]; then
        HEALTH_STATUS[network-connectivity]="healthy"
    elif [ $api_success -gt 0 ]; then
        HEALTH_STATUS[network-connectivity]="degraded"
    else
        HEALTH_STATUS[network-connectivity]="unhealthy"
    fi

    echo "API Tests: $api_success/$api_tests successful"
}

# Check system resources
check_system_resources() {
    log_info "Checking system resources..."

    local issues=0

    # Check disk space
    local disk_usage=$(df -h "$HOME" | awk 'NR==2 {print $5}' | sed 's/%//')
    if [ "$disk_usage" -gt 90 ]; then
        log_warning "Disk usage: ${disk_usage}% (high)"
        ((issues++))
    else
        log_success "Disk usage: ${disk_usage}%"
    fi

    # Check memory
    local mem_usage=$(free | awk 'NR==2{printf "%.0f", $3*100/$2}')
    if [ "$mem_usage" -gt 90 ]; then
        log_warning "Memory usage: ${mem_usage}% (high)"
        ((issues++))
    else
        log_success "Memory usage: ${mem_usage}%"
    fi

    # Check CPU load
    local cpu_load=$(uptime | awk -F'load average:' '{print $2}' | awk '{print $1}' | sed 's/,//')
    local cpu_cores=$(nproc)
    local cpu_usage=$(echo "scale=0; $cpu_load * 100 / $cpu_cores" | bc)
    if [ "$cpu_usage" -gt 90 ]; then
        log_warning "CPU load: ${cpu_usage}% (high)"
        ((issues++))
    else
        log_success "CPU load: ${cpu_usage}%"
    fi

    if [ $issues -eq 0 ]; then
        HEALTH_STATUS[system-resources]="healthy"
    elif [ $issues -le 2 ]; then
        HEALTH_STATUS[system-resources]="degraded"
    else
        HEALTH_STATUS[system-resources]="unhealthy"
    fi
}

# Test tool functionality
test_tool_functionality() {
    log_info "Testing tool functionality..."

    local tests=0
    local passed=0

    # Test Claude CLI
    if command -v claude >/dev/null 2>&1; then
        ((tests++))
        if claude --help >/dev/null 2>&1; then
            log_success "Claude CLI: functional"
            ((passed++))
        else
            log_warning "Claude CLI: not functional"
        fi
    fi

    # Test Cursor CLI
    if command -v cursor-agent >/dev/null 2>&1; then
        ((tests++))
        if cursor-agent --help >/dev/null 2>&1; then
            log_success "Cursor CLI: functional"
            ((passed++))
        else
            log_warning "Cursor CLI: not functional"
        fi
    fi

    # Test Gemini CLI
    if command -v gemini >/dev/null 2>&1; then
        ((tests++))
        if gemini --help >/dev/null 2>&1; then
            log_success "Gemini CLI: functional"
            ((passed++))
        else
            log_warning "Gemini CLI: not functional"
        fi
    fi

    # Test Ollama CLI
    if command -v ollama >/dev/null 2>&1; then
        ((tests++))
        if ollama --help >/dev/null 2>&1; then
            log_success "Ollama CLI: functional"
            ((passed++))
        else
            log_warning "Ollama CLI: not functional"
        fi
    fi

    echo "Functionality tests: $passed/$tests passed"
}

# Generate health report
generate_health_report() {
    log_info "Generating health report..."

    local report_file="$LOG_DIR/health-report-$(date +%Y%m%d-%H%M%S).txt"

    {
        echo "AI CLI Tools Health Report"
        echo "Generated: $(date)"
        echo "=================================="
        echo

        echo "Overall Status: ${HEALTH_STATUS[overall]}"
        echo "Tool Availability: ${HEALTH_STATUS[tool-availability]}"
        echo "API Keys: ${HEALTH_STATUS[api-keys]}"
        echo "Network Connectivity: ${HEALTH_STATUS[network-connectivity]}"
        echo "System Resources: ${HEALTH_STATUS[system-resources]}"
        echo

        echo "Tool Availability:"
        check_all_tools
        echo

        echo "API Key Configuration:"
        check_api_keys
        echo

        echo "System Resources:"
        check_system_resources
        echo

        echo "Tool Functionality:"
        test_tool_functionality
        echo

    } > "$report_file"

    log_success "Health report saved to: $report_file"
}

# Calculate overall health
calculate_overall_health() {
    local healthy_count=0
    local total_count=0

    for status in "${HEALTH_STATUS[@]}"; do
        if [ "$status" != "unknown" ]; then
            ((total_count++))
            if [ "$status" = "healthy" ]; then
                ((healthy_count++))
            fi
        fi
    done

    if [ $total_count -eq 0 ]; then
        HEALTH_STATUS[overall]="unknown"
    elif [ $healthy_count -eq $total_count ]; then
        HEALTH_STATUS[overall]="healthy"
    elif [ $healthy_count -gt 0 ]; then
        HEALTH_STATUS[overall]="degraded"
    else
        HEALTH_STATUS[overall]="unhealthy"
    fi
}

# Show health dashboard
show_dashboard() {
    echo -e "${PURPLE}================================${NC}"
    echo -e "${PURPLE}  AI CLI Tools Health Dashboard${NC}"
    echo -e "${PURPLE}================================${NC}"
    echo

    # Overall status with color
    case "${HEALTH_STATUS[overall]}" in
        "healthy") echo -e "Overall Status: ${GREEN}✓ HEALTHY${NC}" ;; 
        "degraded") echo -e "Overall Status: ${YELLOW}⚠ DEGRADED${NC}" ;; 
        "unhealthy") echo -e "Overall Status: ${RED}✗ UNHEALTHY${NC}" ;; 
        *) echo -e "Overall Status: ${BLUE}? UNKNOWN${NC}" ;; 
    esac

    echo
    echo "Component Status:"
    echo "  Tool Availability: ${HEALTH_STATUS[tool-availability]}"
    echo "  API Keys: ${HEALTH_STATUS[api-keys]}"
    echo "  Network Connectivity: ${HEALTH_STATUS[network-connectivity]}"
    echo "  System Resources: ${HEALTH_STATUS[system-resources]}"
    echo
}

# Continuous monitoring
start_monitoring() {
    local interval="${1:-300}" # Default 5 minutes

    log_info "Starting continuous monitoring (interval: ${interval}s)"

    while true; do
        echo "$(date): Running health check..." >> "$HEALTH_LOG"

        check_all_tools >> "$HEALTH_LOG" 2>&1
        check_api_keys >> "$HEALTH_LOG" 2>&1
        test_api_connectivity >> "$HEALTH_LOG" 2>&1
        check_system_resources >> "$HEALTH_LOG" 2>&1

        calculate_overall_health

        if [ "${HEALTH_STATUS[overall]}" = "unhealthy" ]; then
            log_error "System health degraded - check logs"
        fi

        sleep "$interval"
    done
}

# Main execution
main() {
    init_monitoring

    case "${1:-dashboard}" in
        "dashboard")
            check_all_tools
            check_api_keys
            test_api_connectivity
            check_system_resources
            test_tool_functionality
            calculate_overall_health
            show_dashboard
            ;; 
        "report")
            generate_health_report
            ;; 
        "monitor")
            start_monitoring "$2"
            ;; 
        "tools")
            check_all_tools
            ;; 
        "api")
            check_api_keys
            test_api_connectivity
            ;; 
        "system")
            check_system_resources
            ;; 
        "test")
            test_tool_functionality
            ;; 
        *)
            echo "Usage: $0 [dashboard|report|monitor|tools|api|system|test]"
            echo "  dashboard - Show health dashboard (default)"
            echo "  report    - Generate health report"
            echo "  monitor   - Start continuous monitoring"
            echo "  tools     - Check tool availability"
            echo "  api       - Check API keys and connectivity"
            echo "  system    - Check system resources"
            echo "  test      - Test tool functionality"
            ;; 
    esac
}

# Run main function
main "$@"
