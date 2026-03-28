# Crush CLI installation guide

Crush is Charmbracelet's terminal coding agent for multi-model, tool-enabled development workflows.

## Quick install

```bash
# npm
npm install -g @charmland/crush

# Homebrew
brew install charmbracelet/tap/crush
```

## Verification

```bash
crush --help
crush logs --tail 50
```

Expected behavior: `crush --help` prints the command reference, and `crush logs` works after you have started at least one session.

## Basic usage

```bash
# Start Crush in the current project
crush

# Run with full tool auto-approval very carefully
crush --yolo

# View recent logs
crush logs
```

## Prerequisites

- Node.js if using npm
- A supported LLM provider account
- Optional language servers if you want LSP-enriched context

## Authentication

Crush prompts for provider credentials on first run, or you can preconfigure environment variables such as:

```bash
export ANTHROPIC_API_KEY="your-anthropic-api-key-here"
export OPENAI_API_KEY="your-openai-api-key-here"
export OPENROUTER_API_KEY="your-openrouter-api-key-here"
export GEMINI_API_KEY="your-gemini-api-key-here"
```

## Configuration

Crush loads configuration from:

1. `.crush.json`
2. `crush.json`
3. `$HOME/.config/crush/crush.json`

It supports MCP servers, project ignores, permission rules, and optional Agent Skills packages.

## Troubleshooting

### Command not found

```bash
export PATH="$(npm config get prefix)/bin:$PATH"
```

### Enable project-wide allowed tools

Use `permissions.allowed_tools` in `.crush.json` instead of defaulting to `--yolo`.

### Add LSP context

Configure `gopls`, `typescript-language-server`, or other LSP binaries in the `lsp` section of `.crush.json`.

## Additional resources

- Official repository and install docs: https://github.com/charmbracelet/crush
- Charm site: https://charm.land/
