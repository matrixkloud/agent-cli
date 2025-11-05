# Tools Index

This file provides a quick reference for all the available tools in this repository.

## AI Coding Assistants

| Tool | Description | Installation | Guide |
|---|---|---|---|
| **Claude CLI** | Anthropic's Claude AI assistant | `npm install -g @anthropic-ai/claude-code` | [Guide](../tools/ai-assistants/claude-cli.md) |
| **Cursor CLI** | Cursor's AI-powered editor CLI | `curl https://cursor.com/install -fsSL | bash` | [Guide](../tools/ai-assistants/cursor-cli.md) |
| **Gemini CLI** | Google's Gemini AI assistant | `npm install -g @google/gemini-cli` | [Guide](../tools/ai-assistants/gemini-cli.md) |
| **Codex CLI** | OpenAI's Codex AI assistant | `npm install -g @openai/codex` | [Guide](../tools/ai-assistants/codex-cli.md) |
| **GitHub Copilot CLI** | Microsoft's GitHub Copilot CLI | `gh extension install github/gh-copilot` | [Guide](../tools/ai-assistants/github-copilot-cli.md) |
| **Perplexity CLI** | Perplexity AI research assistant | `pip install perplexity-ai` | [Guide](../tools/ai-assistants/perplexity-cli.md) |
| **Ollama CLI** | Local AI models (Llama, Mistral) | `curl -fsSL https://ollama.ai/install.sh | sh` | [Guide](../tools/ai-assistants/ollama-cli.md) |
| **Aider CLI** | AI pair programming tool | `pip install aider-chat` | [Guide](../tools/ai-assistants/aider-cli.md) |
| **AI Shell** | Terminal AI assistant | `pip install ai-shell` | [Guide](../tools/ai-assistants/ai-shell.md) |

## Development Tools

| Tool | Description | Installation | Guide |
|---|---|---|---|
| **Node.js** | JavaScript runtime with npm | `nvm install --lts` | [Guide](../tools/development/nodejs-installer.md) |

## API Keys

Some of the tools require API keys to function. You can get API keys from the following sources:

*   **Anthropic Claude:** [https://console.anthropic.com/](https://console.anthropic.com/)
*   **Google Gemini:** [https://makersuite.google.com/app/apikey](https://makersuite.google.com/app/apikey)
*   **OpenAI:** [https://platform.openai.com/api-keys](https://platform.openai.com/api-keys)
*   **Perplexity AI:** [https://www.perplexity.ai/settings/api](https://www.perplexity.ai/settings/api)

Once you have your API keys, you can add them to the `~/.ai-cli-env` file.

```bash
# Anthropic Claude API Key
export ANTHROPIC_API_KEY="your-anthropic-api-key-here"

# Google Gemini API Key
export GOOGLE_API_KEY="your-google-api-key-here"

# OpenAI API Key
export OPENAI_API_KEY="your-openai-api-key-here"

# Perplexity API Key
export PERPLEXITY_API_KEY="your-perplexity-api-key-here"
```
