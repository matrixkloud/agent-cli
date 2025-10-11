# Tools Index

Quick reference for all available tools in this repository.

## 🤖 AI Coding Assistants

| Tool | Description | Install Command | Documentation |
|------|-------------|----------------|---------------|
| **Claude CLI** | Anthropic's Claude AI assistant | `curl -fsSL https://claude.ai/install.sh \| bash` | [Guide](../tools/ai-assistants/claude-cli.md) |
| **Cursor CLI** | Cursor's AI-powered editor CLI | `curl https://cursor.com/install -fsSL \| bash` | [Guide](../tools/ai-assistants/cursor-cli.md) |
| **Gemini CLI** | Google's Gemini AI assistant | `npm install -g @google/gemini-cli` | [Guide](../tools/ai-assistants/gemini-cli.md) |
| **Codex CLI** | OpenAI's Codex AI assistant | `npm install -g @openai/codex` | [Guide](../tools/ai-assistants/codex-cli.md) |
| **GitHub Copilot CLI** | Microsoft's GitHub Copilot CLI | `gh extension install github/gh-copilot` | [Guide](../tools/ai-assistants/github-copilot-cli.md) |
| **Perplexity CLI** | Perplexity AI research assistant | `pip install perplexity-ai` | [Guide](../tools/ai-assistants/perplexity-cli.md) |
| **Ollama CLI** | Local AI models (Llama, Mistral) | `curl -fsSL https://ollama.ai/install.sh \| sh` | [Guide](../tools/ai-assistants/ollama-cli.md) |
| **Aider CLI** | AI pair programming tool | `pip install aider-chat` | [Guide](../tools/ai-assistants/aider-cli.md) |
| **AI Shell** | Terminal AI assistant | `pip install ai-shell` | [Guide](../tools/ai-assistants/ai-shell.md) |

## 🛠️ Development Tools

| Tool | Description | Install Command | Documentation |
|------|-------------|----------------|---------------|
| **Node.js** | JavaScript runtime with npm | `curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh \| bash` | [Guide](../tools/development/nodejs-installer.md) |

## 📋 Prerequisites

All tools require:
- **Node.js** (v18 or higher)
- **npm** (comes with Node.js)
- **curl** or **wget**
- **Internet connection**

## 🔑 API Keys Required

| Tool | API Key Source | Environment Variable |
|------|----------------|---------------------|
| Claude CLI | [Anthropic Console](https://console.anthropic.com/) | `ANTHROPIC_API_KEY` |
| Gemini CLI | [Google AI Studio](https://makersuite.google.com/app/apikey) | `GOOGLE_API_KEY` |
| Codex CLI | [OpenAI Platform](https://platform.openai.com/api-keys) | `OPENAI_API_KEY` |
| Cursor CLI | [Cursor Account](https://cursor.com/) | (Login via CLI) |
| GitHub Copilot CLI | [GitHub Copilot](https://github.com/features/copilot) | (GitHub Account) |
| Perplexity CLI | [Perplexity AI](https://www.perplexity.ai/settings/api) | `PERPLEXITY_API_KEY` |
| Ollama CLI | (Local - No API key needed) | N/A |
| Aider CLI | [OpenAI](https://platform.openai.com/api-keys) | `OPENAI_API_KEY` |
| AI Shell | [OpenAI](https://platform.openai.com/api-keys) | `OPENAI_API_KEY` |

## 🚀 Quick Start Commands

```bash
# Install all prerequisites
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
source ~/.bashrc
nvm install --lts

# Install AI assistants
npm install -g @anthropic-ai/claude-code
npm install -g @google/gemini-cli
npm install -g @openai/codex
curl https://cursor.com/install -fsSL | bash

# Set up API keys
export ANTHROPIC_API_KEY="your-key-here"
export GOOGLE_API_KEY="your-key-here"
export OPENAI_API_KEY="your-key-here"
```

## 🔍 Verification Commands

```bash
# Check installations
node --version
npm --version
claude --version
cursor-agent --version
gemini --version
codex --version
```

## 📚 Additional Resources

- [Troubleshooting Guide](troubleshooting.md)
- [Main README](../README.md)
- [Repository Structure](../README.md#-repository-structure)