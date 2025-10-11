# AI Agent CLI Tools Installer Guide

A comprehensive collection of installation guides for AI coding assistants and development tools.

## 🚀 Quick Start

### Automated Setup (Recommended)

Get everything set up with interactive options:

```bash
# Run the automated setup script
./setup-workstation.sh
```

**Setup Options:**
1. **Install all AI agents** - Complete setup with all 9 tools
2. **Select specific agents** - Choose only the tools you need
3. **Show available agents** - List all available tools
4. **Exit** - Cancel setup

This will install your selected tools, configure your environment, and set up API keys interactively.

### Manual Setup

This repository contains installation instructions for various AI-powered coding assistants and essential development tools. Each tool is organized by category with standardized installation steps, verification commands, and troubleshooting tips.

## 🛠️ Setup Scripts

| Script | Purpose | Usage |
|--------|---------|-------|
| **setup-workstation.sh** | Interactive setup with agent selection | `./setup-workstation.sh` |
| **scripts/select-agents.sh** | Select specific agents to install | `./scripts/select-agents.sh` |
| **scripts/configure-api-keys.sh** | Configure API keys | `./scripts/configure-api-keys.sh` |
| **scripts/quick-test.sh** | Test all installations | `./scripts/quick-test.sh` |

## 📋 Available Tools

### AI Coding Assistants
- **[Claude CLI](./tools/ai-assistants/claude-cli.md)** - Anthropic's Claude command-line interface
- **[Cursor CLI](./tools/ai-assistants/cursor-cli.md)** - Cursor's AI-powered code editor CLI
- **[Gemini CLI](./tools/ai-assistants/gemini-cli.md)** - Google's Gemini AI command-line tool
- **[Codex CLI](./tools/ai-assistants/codex-cli.md)** - OpenAI's Codex command-line interface
- **[GitHub Copilot CLI](./tools/ai-assistants/github-copilot-cli.md)** - Microsoft's GitHub Copilot CLI
- **[Perplexity CLI](./tools/ai-assistants/perplexity-cli.md)** - Perplexity AI research assistant
- **[Ollama CLI](./tools/ai-assistants/ollama-cli.md)** - Local AI models (Llama, Mistral, etc.)
- **[Aider CLI](./tools/ai-assistants/aider-cli.md)** - AI pair programming tool
- **[AI Shell](./tools/ai-assistants/ai-shell.md)** - Terminal AI assistant

### Development Tools
- **[Node.js Installer](./tools/development/nodejs-installer.md)** - Node.js and npm installation via nvm

## 🗂️ Repository Structure

```
agent-cli/
├── README.md                           # This file
├── tools/
│   ├── ai-assistants/                 # AI coding assistant tools
│   │   ├── claude-cli.md
│   │   ├── cursor-cli.md
│   │   ├── gemini-cli.md
│   │   └── codex-cli.md
│   └── development/                   # Development tools
│       └── nodejs-installer.md
└── docs/                              # Additional documentation
    └── troubleshooting.md
```

## 🛠️ Installation Categories

### AI Assistants
All AI coding assistants are grouped together for easy access. Each guide includes:
- One-line installation commands
- Verification steps
- Basic usage examples
- Troubleshooting tips

### Development Tools
Essential development tools that support the AI assistants, including:
- Node.js and npm (required for most AI CLI tools)
- Package managers
- Version managers

## 📖 How to Use

1. **Choose your tool**: Browse the categories above or check the [Tools Index](./docs/tools-index.md)
2. **Follow the guide**: Each tool has a dedicated markdown file with step-by-step instructions
3. **Verify installation**: Use the provided verification commands
4. **Troubleshoot**: Check the troubleshooting section if you encounter issues

## 🔧 Prerequisites

Most AI CLI tools require:
- **Node.js** (v18 or higher recommended)
- **npm** (comes with Node.js)
- **curl** or **wget** for downloading installers
- **bash** shell (Linux/macOS) or **PowerShell** (Windows)

## 📖 Documentation

- **[Usage Guide](./USAGE.md)** - Complete usage instructions
- **[Tools Index](./docs/tools-index.md)** - Quick reference for all tools
- **[Troubleshooting](./docs/troubleshooting.md)** - Common issues and solutions
- **[Template](./docs/template.md)** - Template for adding new tools

## 🤝 Contributing

To add a new tool:
1. Create a new markdown file in the appropriate category directory
2. Follow the standardized format (see [Template](./docs/template.md))
3. Include installation, verification, and troubleshooting sections
4. Update this README and the tools index
5. Add the tool to the setup script if it should be auto-installed

## 📝 License

This project is open source and available under the [MIT License](LICENSE).

---

**Need help?** Check the [troubleshooting guide](./docs/troubleshooting.md) or open an issue.