# Usage Guide

This guide explains how to use the AI Agent CLI Tools repository and its setup scripts.

## Quick Start

The quickest way to get started is to use the automated setup script. This script will guide you through the process of installing the tools and configuring your environment.

```bash
# Run the automated setup script
./setup-workstation.sh
```

## Scripts

This repository includes a number of scripts to help you manage your AI tools.

### `setup-workstation.sh`

This is the main setup script. It will guide you through the process of installing the tools and configuring your environment. The script will:

*   Check for prerequisites
*   Install Node.js and nvm
*   Install the selected AI tools
*   Configure your environment variables
*   Create helper scripts
*   Verify the installation

### `scripts/select-agents.sh`

This script allows you to select which AI agents you want to install. Use `bash scripts/select-agents.sh` for the interactive menu or `bash scripts/select-agents.sh -l` to print the current catalog.

### `scripts/configure-api-keys.sh`

This script guides you through configuring API keys in `~/.ai-cli-env`. It preserves existing values unless you explicitly replace them.

### `scripts/quick-test.sh`

This script runs a quick test of the installed tools, checks the expected API keys, and confirms that each CLI responds to a basic help command.

### `scripts/health-monitor.sh`

This script will run a more comprehensive health check of all the installed tools. The script will check for:

*   Tool availability
*   API key validation
*   Network connectivity
*   System resources
*   Tool functionality

### `scripts/package-manager.sh`

This script is a unified package manager that can be used to install, update, and uninstall the AI tools.

### `scripts/ai-orchestrator.sh`

This script is an AI agent orchestrator that can be used to manage and interact with the various AI agents.

## Manual Setup

If you prefer to install tools manually, follow the guides in `tools/`. The repository now includes additional agentic CLI references for Goose, OpenCode, OpenHands, and Amp alongside the existing core tool guides.

## Contributing

Contributions are welcome! Please see the [Contributing Guide](./CONTRIBUTING.md) for more information.
