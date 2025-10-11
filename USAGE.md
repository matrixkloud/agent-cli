# Usage Guide

This guide explains how to use the AI Agent CLI Tools repository and its setup scripts.

## 🚀 Quick Start

### 1. Run the Setup Script

The main setup script offers interactive options for installing AI CLI tools:

```bash
# Make the script executable (if not already)
chmod +x setup-workstation.sh

# Run the setup script
./setup-workstation.sh
```

**Setup Options:**
1. **Install all AI agents** - Complete setup with all 9 tools
2. **Select specific agents** - Choose only the tools you need
3. **Show available agents** - List all available tools
4. **Exit** - Cancel setup

**What the script does:**
- Checks system prerequisites
- Installs Node.js via nvm
- Installs your selected AI CLI tools
- Sets up environment variables
- Creates helper scripts
- Verifies installations

### 2. Configure API Keys

After setup, configure your API keys:

```bash
# Interactive API key configuration
./scripts/configure-api-keys.sh

# Or manually edit the environment file
nano ~/.ai-cli-env
```

### 3. Test Your Installation

Verify everything is working:

```bash
# Quick test of all tools
./scripts/quick-test.sh

# Or use the helper script
test-ai-tools
```

## 📋 Available Scripts

### Main Scripts

| Script | Purpose | Usage |
|--------|---------|-------|
| `setup-workstation.sh` | Interactive setup with agent selection | `./setup-workstation.sh` |
| `scripts/select-agents.sh` | Select specific agents to install | `./scripts/select-agents.sh` |
| `scripts/configure-api-keys.sh` | Configure API keys | `./scripts/configure-api-keys.sh` |
| `scripts/quick-test.sh` | Test all installations | `./scripts/quick-test.sh` |

### Helper Scripts (Created by setup)

| Script | Purpose | Usage |
|--------|---------|-------|
| `~/.local/bin/update-ai-tools` | Update all tools | `update-ai-tools` |
| `~/.local/bin/test-ai-tools` | Test installations | `test-ai-tools` |

## 🎯 Agent Selection

### Interactive Selection

Use the agent selector to choose specific tools:

```bash
# Run the agent selector
./scripts/select-agents.sh
```

**Selection Features:**
- Toggle agents on/off with numbers (1-9)
- Select all agents with 'a'
- Deselect all agents with 'n'
- View agent details with 'i'
- Show selected agents with 's'
- Continue with 'c' or quit with 'q'

### Available Agents

1. **Claude CLI** - Anthropic's Claude AI assistant
2. **Cursor CLI** - Cursor's AI-powered code editor CLI
3. **Gemini CLI** - Google's Gemini AI assistant
4. **Codex CLI** - OpenAI's Codex AI assistant
5. **GitHub Copilot CLI** - Microsoft's GitHub Copilot CLI
6. **Perplexity CLI** - Perplexity AI research assistant
7. **Ollama CLI** - Local AI models (Llama, Mistral, etc.)
8. **Aider CLI** - AI pair programming tool
9. **AI Shell** - Terminal AI assistant

## 🔧 Manual Setup

If you prefer to set up tools manually, follow these guides:

### Prerequisites
- [Node.js Installer](./tools/development/nodejs-installer.md)

### AI Tools
- [Claude CLI](./tools/ai-assistants/claude-cli.md)
- [Cursor CLI](./tools/ai-assistants/cursor-cli.md)
- [Gemini CLI](./tools/ai-assistants/gemini-cli.md)
- [Codex CLI](./tools/ai-assistants/codex-cli.md)

## 🔑 API Key Configuration

### Environment File

API keys are stored in `~/.ai-cli-env`:

```bash
# Anthropic Claude API Key
export ANTHROPIC_API_KEY="your-anthropic-api-key-here"

# Google Gemini API Key
export GOOGLE_API_KEY="your-google-api-key-here"

# OpenAI API Key
export OPENAI_API_KEY="your-openai-api-key-here"
```

### Getting API Keys

1. **Anthropic Claude**: https://console.anthropic.com/
2. **Google Gemini**: https://makersuite.google.com/app/apikey
3. **OpenAI**: https://platform.openai.com/api-keys

## 🛠️ Daily Usage

### Basic Commands

```bash
# Claude CLI
claude chat
claude ask "How do I implement a binary search?"

# Cursor CLI
cursor-agent chat "find one bug and fix it"
cursor-agent open

# Gemini CLI
gemini chat
gemini ask "Explain machine learning concepts"

# Codex CLI
codex chat
codex ask "How do I create a REST API?"
```

### Helper Commands

```bash
# Update all tools
update-ai-tools

# Test all installations
test-ai-tools

# Check specific tool version
claude --version
cursor-agent --version
gemini --version
codex --version
```

## 🔄 Maintenance

### Updating Tools

```bash
# Update all tools at once
update-ai-tools

# Or update individually
npm update -g @anthropic-ai/claude-code
npm update -g @google/gemini-cli
npm update -g @openai/codex
curl https://cursor.com/install -fsSL | bash
```

### Troubleshooting

1. **Check the troubleshooting guide**: [docs/troubleshooting.md](./docs/troubleshooting.md)
2. **Run the test script**: `./scripts/quick-test.sh`
3. **Check environment**: `source ~/.ai-cli-env && env | grep API`
4. **Verify PATH**: `echo $PATH`

## 📁 Repository Structure

```
agent-cli/
├── setup-workstation.sh          # Main setup script
├── USAGE.md                      # This file
├── README.md                     # Main documentation
├── tools/                        # Installation guides
│   ├── ai-assistants/           # AI tool guides
│   └── development/             # Dev tool guides
├── scripts/                      # Utility scripts
│   ├── configure-api-keys.sh    # API key configuration
│   └── quick-test.sh            # Installation testing
└── docs/                        # Additional documentation
    ├── tools-index.md           # Quick reference
    ├── troubleshooting.md       # Common issues
    └── template.md              # Template for new tools
```

## 🆘 Getting Help

### Common Issues

1. **Command not found**: Check your PATH and restart terminal
2. **Permission denied**: Fix npm permissions or use sudo
3. **API key issues**: Verify keys are correct and have sufficient credits
4. **Installation failed**: Check internet connection and try again

### Resources

- [Troubleshooting Guide](./docs/troubleshooting.md)
- [Tools Index](./docs/tools-index.md)
- [Individual Tool Guides](./tools/)

### Support

If you encounter issues:

1. Check the troubleshooting guide
2. Run the test script to identify problems
3. Check the tool's official documentation
4. Create an issue with:
   - Your operating system
   - Node.js version
   - Error messages
   - Steps to reproduce

## 🔄 Uninstalling

To remove all tools:

```bash
# Remove AI CLI tools
npm uninstall -g @anthropic-ai/claude-code
npm uninstall -g @google/gemini-cli
npm uninstall -g @openai/codex

# Remove Cursor CLI
sudo rm -f /usr/local/bin/cursor-agent

# Remove nvm and Node.js
rm -rf ~/.nvm

# Remove environment file
rm -f ~/.ai-cli-env

# Remove helper scripts
rm -f ~/.local/bin/update-ai-tools
rm -f ~/.local/bin/test-ai-tools
```