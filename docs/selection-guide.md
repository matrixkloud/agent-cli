# Agent Selection Guide

Quick reference for selecting and installing AI agents.

## 🚀 Quick Start

### Option 1: Interactive Setup
```bash
./setup-workstation.sh
```
Choose option 2 for agent selection.

### Option 2: Direct Selection
```bash
./scripts/select-agents.sh
```

## 🎯 Selection Interface

### Main Menu
```
================================
  Agent Selection Menu
================================

1. Claude CLI ✓
2. Cursor CLI
3. Gemini CLI ✓
4. Codex CLI
5. GitHub Copilot CLI
6. Perplexity CLI
7. Ollama CLI ✓
8. Aider CLI
9. AI Shell

Commands:
  [1-9] - Toggle agent selection
  a     - Select all agents
  n     - Select none
  i     - Show agent information
  s     - Show selected agents
  c     - Continue with selection
  q     - Quit
```

### Selection Commands

| Command | Action |
|---------|--------|
| `1-9` | Toggle specific agent on/off |
| `a` | Select all agents |
| `n` | Deselect all agents |
| `i` | Show detailed agent information |
| `s` | Display currently selected agents |
| `c` | Continue with selected agents |
| `q` | Quit without installing |

## 🤖 Available Agents

### Cloud-Based AI Assistants
| Agent | Provider | API Key | Best For |
|-------|----------|---------|----------|
| **Claude CLI** | Anthropic | Required | General coding, analysis |
| **Cursor CLI** | Cursor | Account | Code editing, IDE integration |
| **Gemini CLI** | Google | Required | Multimodal tasks, research |
| **Codex CLI** | OpenAI | Required | Code generation, completion |
| **GitHub Copilot CLI** | Microsoft | Account | GitHub integration, coding |
| **Perplexity CLI** | Perplexity | Required | Research, fact-checking |

### Local AI Models
| Agent | Provider | API Key | Best For |
|-------|----------|---------|----------|
| **Ollama CLI** | Local | None | Privacy, offline use, custom models |

### Specialized Tools
| Agent | Provider | API Key | Best For |
|-------|----------|---------|----------|
| **Aider CLI** | OpenAI | Required | Pair programming, code editing |
| **AI Shell** | OpenAI | Required | Terminal assistance, system tasks |

## 💡 Selection Recommendations

### For Beginners
- **Claude CLI** - Easy to use, good documentation
- **Ollama CLI** - No API keys needed, local privacy

### For Developers
- **Cursor CLI** - Best IDE integration
- **GitHub Copilot CLI** - Industry standard
- **Aider CLI** - Advanced pair programming

### For Researchers
- **Perplexity CLI** - Best for research and fact-checking
- **Gemini CLI** - Multimodal capabilities

### For Privacy-Conscious Users
- **Ollama CLI** - Runs locally, no data sent to cloud

### For Terminal Users
- **AI Shell** - Terminal-specific assistance
- **Claude CLI** - Good terminal integration

## 🔧 Installation Process

### After Selection
1. **Confirmation** - Review selected agents
2. **Prerequisites** - Check system requirements
3. **Installation** - Install selected agents
4. **Configuration** - Set up API keys
5. **Verification** - Test installations

### Generated Files
- `~/.local/bin/install-selected-agents` - Custom installation script
- `~/.ai-cli-env` - Environment variables for API keys
- `~/.local/bin/test-ai-tools` - Test script
- `~/.local/bin/update-ai-tools` - Update script

## 🐛 Troubleshooting

### Common Issues
1. **Agent not found** - Check if it was selected and installed
2. **API key errors** - Configure API keys in `~/.ai-cli-env`
3. **Permission denied** - Fix npm/pip permissions
4. **Command not found** - Check PATH and restart terminal

### Getting Help
```bash
# Test all installations
test-ai-tools

# Check specific agent
claude --help
cursor-agent --help
gemini --help

# View environment
cat ~/.ai-cli-env
```

## 🔄 Adding More Agents Later

### Install Additional Agents
```bash
# Run selection again
./scripts/select-agents.sh

# Or install manually
npm install -g @anthropic-ai/claude-code
pip install perplexity-ai
```

### Update Existing Agents
```bash
# Update all installed agents
update-ai-tools

# Or update individually
npm update -g @anthropic-ai/claude-code
pip install --upgrade perplexity-ai
```

## 📚 Next Steps

After selection and installation:

1. **Configure API Keys** - Set up authentication
2. **Test Installations** - Verify everything works
3. **Read Documentation** - Learn how to use each tool
4. **Start Coding** - Begin using your AI assistants

For detailed usage instructions, see the individual tool guides in `tools/ai-assistants/`.