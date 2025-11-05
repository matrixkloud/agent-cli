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

This script allows you to select which AI agents you want to install. You can run this script to install new agents or to remove existing ones.

### `scripts/configure-api-keys.sh`

This script will guide you through the process of configuring your API keys. The script will create a `~/.ai-cli-env` file with your API keys.

### `scripts/quick-test.sh`

This script will run a quick test of all the installed tools to make sure that they are working correctly.

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

If you prefer to install the tools manually, you can follow the guides in the `tools` directory.

## Contributing

Contributions are welcome! Please see the [Contributing Guide](./CONTRIBUTING.md) for more information.
