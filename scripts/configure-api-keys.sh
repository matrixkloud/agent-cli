#!/bin/bash

# Interactive API key configuration for AI CLI tools.

set -e

BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

ENV_FILE="$HOME/.ai-cli-env"

log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

ensure_env_file() {
    if [ ! -f "$ENV_FILE" ]; then
        cat > "$ENV_FILE" <<'EOF'
# AI CLI Tools Environment Variables

# export ANTHROPIC_API_KEY=""
# export GOOGLE_API_KEY=""
# export OPENAI_API_KEY=""
# export PERPLEXITY_API_KEY=""
EOF
        log_success "Created $ENV_FILE"
    fi
}

set_env_value() {
    local key="$1"
    local value="$2"

    if grep -Eq "^[#[:space:]]*export ${key}=" "$ENV_FILE"; then
        sed -i "s|^[#[:space:]]*export ${key}=.*|export ${key}=\"${value}\"|" "$ENV_FILE"
    else
        printf 'export %s="%s"\n' "$key" "$value" >> "$ENV_FILE"
    fi
}

prompt_for_key() {
    local key="$1"
    local label="$2"
    local current_value=""
    local input_value=""

    current_value="$(grep -E "^[#[:space:]]*export ${key}=" "$ENV_FILE" | tail -n 1 | sed -E "s/^[#[:space:]]*export ${key}=\"?(.*)\"?/\1/")"

    if [ -n "$current_value" ]; then
        echo -e "${BLUE}${label}${NC} is currently configured. Press Enter to keep it, or paste a new value:"
    else
        echo -e "${BLUE}Enter ${label}${NC} (leave blank to skip):"
    fi

    read -r input_value

    if [ -z "$input_value" ]; then
        if [ -n "$current_value" ]; then
            log_info "Keeping existing ${label}"
        else
            log_warning "Skipped ${label}"
        fi
        return
    fi

    set_env_value "$key" "$input_value"
    log_success "Saved ${label}"
}

main() {
    ensure_env_file

    echo -e "${BLUE}Configuring API keys in ${ENV_FILE}${NC}"
    echo

    prompt_for_key "ANTHROPIC_API_KEY" "Anthropic API key"
    prompt_for_key "GOOGLE_API_KEY" "Google API key"
    prompt_for_key "OPENAI_API_KEY" "OpenAI API key"
    prompt_for_key "PERPLEXITY_API_KEY" "Perplexity API key"

    echo
    log_success "API key setup complete"
    log_info "Reload your shell or run: source \"$ENV_FILE\""
}

main "$@"
