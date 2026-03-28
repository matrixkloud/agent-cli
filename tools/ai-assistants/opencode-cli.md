# OpenCode CLI installation guide

OpenCode is an open source AI coding agent with a terminal-first interface.

## Quick install

```bash
# Recommended installer
curl -fsSL https://opencode.ai/install | bash

# npm alternative
npm install -g opencode-ai
```

## Verification

```bash
opencode --version
opencode --help
```

Expected behavior: the CLI prints version information and available commands.

## Basic usage

```bash
# Start the TUI in the current project
opencode

# Continue the last session
opencode --continue

# Run a one-off prompt
opencode run "Explain how closures work in JavaScript"
```

## Prerequisites

- A modern terminal emulator
- Node.js if using the npm installation path
- API keys for the LLM providers you plan to use

## Authentication

Configure your preferred provider in the CLI after installation. For environment-based setups:

```bash
export OPENAI_API_KEY="your-openai-api-key-here"
export ANTHROPIC_API_KEY="your-anthropic-api-key-here"
```

## Troubleshooting

### Command not found

```bash
export PATH="$HOME/.local/bin:$PATH"
export PATH="$(npm config get prefix)/bin:$PATH"
```

### Review commands and flags

```bash
opencode --help
opencode run --help
```

## Additional resources

- Documentation home: https://dev.opencode.ai/docs/
- CLI reference: https://dev.opencode.ai/docs/cli/
- GitHub repository: https://github.com/sst/opencode
