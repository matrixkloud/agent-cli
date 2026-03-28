# AI Agent CLI Tools

This repository collects installation guides, environment setup helpers, and verification scripts for agentic coding CLIs and related developer tooling.

## Getting Started

To get started, you can use the automated setup script to install all the tools and configure your environment. The script will guide you through the process of selecting the tools you want to install and configuring your API keys.

```bash
# Run the automated setup script
./setup-workstation.sh
```

Alternatively, you can manually install tools by following the guides in `tools/`.

## Tools

The following tools are included in this repository:

| Tool | Description | Guide |
|---|---|---|
| **Claude CLI** | Anthropic's Claude command-line interface | [Guide](./tools/ai-assistants/claude-cli.md) |
| **Cursor CLI** | Cursor's AI-powered code editor CLI | [Guide](./tools/ai-assistants/cursor-cli.md) |
| **Gemini CLI** | Google's Gemini AI command-line tool | [Guide](./tools/ai-assistants/gemini-cli.md) |
| **Codex CLI** | OpenAI's Codex command-line interface | [Guide](./tools/ai-assistants/codex-cli.md) |
| **GitHub Copilot CLI** | Microsoft's GitHub Copilot CLI | [Guide](./tools/ai-assistants/github-copilot-cli.md) |
| **Perplexity CLI** | Perplexity AI research assistant | [Guide](./tools/ai-assistants/perplexity-cli.md) |
| **Ollama CLI** | Local AI models (Llama, Mistral, etc.) | [Guide](./tools/ai-assistants/ollama-cli.md) |
| **Aider CLI** | AI pair programming tool | [Guide](./tools/ai-assistants/aider-cli.md) |
| **AI Shell** | Terminal AI assistant | [Guide](./tools/ai-assistants/ai-shell.md) |
| **Qwen Code CLI** | Alibaba Cloud / Qwen terminal coding agent | [Guide](./tools/ai-assistants/qwen-code-cli.md) |
| **Crush CLI** | Charmbracelet's terminal coding agent | [Guide](./tools/ai-assistants/crush-cli.md) |
| **Plandex CLI** | Open source coding agent for large tasks | [Guide](./tools/ai-assistants/plandex-cli.md) |
| **gptme CLI** | Tool-using terminal agent with browser and shell support | [Guide](./tools/ai-assistants/gptme-cli.md) |
| **Goose CLI** | Block's open source coding agent | [Guide](./tools/ai-assistants/goose-cli.md) |
| **OpenCode CLI** | Open source terminal coding agent | [Guide](./tools/ai-assistants/opencode-cli.md) |
| **OpenHands CLI** | Autonomous software engineering agent in the terminal | [Guide](./tools/ai-assistants/openhands-cli.md) |
| **Amp CLI** | Amp's terminal-first coding agent | [Guide](./tools/ai-assistants/amp-cli.md) |
| **Node.js Installer** | Node.js and npm installation via nvm | [Guide](./tools/development/nodejs-installer.md) |
| **Alibaba Cloud CLI** | Official CLI for Alibaba Cloud APIs and OSS workflows | [Guide](./tools/development/alibaba-cloud-cli.md) |

## Automation coverage

The setup and verification scripts currently automate the core install/test flow for:

- Claude CLI
- Cursor CLI
- Gemini CLI
- Codex CLI
- GitHub Copilot CLI
- Perplexity CLI
- Ollama CLI
- Aider CLI
- AI Shell

Additional guides such as Qwen Code, Crush, Plandex, gptme, Goose, OpenCode, OpenHands, Amp, and Alibaba Cloud CLI are documented and indexed here even when their installation flow is still manual.

## Documentation

- [Usage Guide](./USAGE.md)
- [Tools Index](./docs/reference/tools-index.md)
- [Selection Guide](./docs/guides/selection-guide.md)
- [Troubleshooting](./docs/guides/troubleshooting.md)
- [Template](./docs/reference/template.md)

## Contributing

Contributions are welcome! Please see the [Contributing Guide](./CONTRIBUTING.md) for more information.

## Code of Conduct

This project is governed by the [Code of Conduct](./CODE_OF_CONDUCT.md). By participating, you are expected to uphold this code.

## License

This project is open source and available under the [MIT License](LICENSE).
