# Tools index

This reference lists the tool guides currently documented in the repository.

## AI coding assistants

| Tool | Description | Quick install | Guide |
|---|---|---|---|
| **Claude CLI** | Anthropic's coding assistant | `npm install -g @anthropic-ai/claude-code` | [Guide](../../tools/ai-assistants/claude-cli.md) |
| **Cursor CLI** | Cursor's terminal agent workflow | `curl https://cursor.com/install -fsSL \| bash` | [Guide](../../tools/ai-assistants/cursor-cli.md) |
| **Gemini CLI** | Google's Gemini terminal assistant | `npm install -g @google/gemini-cli` | [Guide](../../tools/ai-assistants/gemini-cli.md) |
| **Codex CLI** | OpenAI's coding assistant CLI | `npm install -g @openai/codex` | [Guide](../../tools/ai-assistants/codex-cli.md) |
| **GitHub Copilot CLI** | GitHub CLI Copilot extension | `gh extension install github/gh-copilot` | [Guide](../../tools/ai-assistants/github-copilot-cli.md) |
| **Perplexity CLI** | Research-first AI assistant | `pip install perplexity-ai` | [Guide](../../tools/ai-assistants/perplexity-cli.md) |
| **Ollama CLI** | Local model runner | `curl -fsSL https://ollama.ai/install.sh \| sh` | [Guide](../../tools/ai-assistants/ollama-cli.md) |
| **Aider CLI** | AI pair programming agent | `pip install aider-chat` | [Guide](../../tools/ai-assistants/aider-cli.md) |
| **AI Shell** | Natural-language shell assistant | `pip install ai-shell` | [Guide](../../tools/ai-assistants/ai-shell.md) |
| **Qwen Code CLI** | Alibaba Cloud and Qwen coding agent | `npm install -g @qwen-code/qwen-code@latest` | [Guide](../../tools/ai-assistants/qwen-code-cli.md) |
| **Crush CLI** | Charmbracelet's terminal coding agent | `npm install -g @charmland/crush` | [Guide](../../tools/ai-assistants/crush-cli.md) |
| **Plandex CLI** | Open source agent for large coding tasks | `curl -sL https://plandex.ai/install.sh \| bash` | [Guide](../../tools/ai-assistants/plandex-cli.md) |
| **gptme CLI** | Terminal agent with built-in tools and plugins | `pipx install gptme` | [Guide](../../tools/ai-assistants/gptme-cli.md) |
| **Goose CLI** | Block's open source coding agent | `curl -fsSL https://github.com/block/goose/releases/download/stable/download_cli.sh \| bash` | [Guide](../../tools/ai-assistants/goose-cli.md) |
| **OpenCode CLI** | Open source terminal coding agent | `curl -fsSL https://opencode.ai/install \| bash` | [Guide](../../tools/ai-assistants/opencode-cli.md) |
| **OpenHands CLI** | Autonomous software engineering agent | `uvx --python 3.12 openhands` | [Guide](../../tools/ai-assistants/openhands-cli.md) |
| **Amp CLI** | Amp's terminal coding agent | `curl -fsSL https://ampcode.com/install.sh \| bash` | [Guide](../../tools/ai-assistants/amp-cli.md) |

## Development tools

| Tool | Description | Quick install | Guide |
|---|---|---|---|
| **Node.js** | JavaScript runtime with npm | `nvm install --lts` | [Guide](../../tools/development/nodejs-installer.md) |
| **Alibaba Cloud CLI** | Official CLI for Alibaba Cloud services | `/bin/bash -c "$(curl -fsSL https://aliyuncli.alicdn.com/install.sh)"` | [Guide](../../tools/development/alibaba-cloud-cli.md) |

## API keys

Store secrets in `~/.ai-cli-env`, then reload your shell or run `source ~/.ai-cli-env`.

```bash
export ANTHROPIC_API_KEY="your-anthropic-api-key-here"
export GOOGLE_API_KEY="your-google-api-key-here"
export OPENAI_API_KEY="your-openai-api-key-here"
export PERPLEXITY_API_KEY="your-perplexity-api-key-here"
export CODEX_API_URL="http://localhost:1455"   # optional for a forwarded Codex endpoint
```

### Provider consoles

- Anthropic Claude: https://console.anthropic.com/
- Google Gemini: https://aistudio.google.com/app/apikey
- OpenAI: https://platform.openai.com/api-keys
- Perplexity: https://www.perplexity.ai/settings/api
