# Plandex CLI installation guide

Plandex is an open source terminal coding agent built for long-running, multi-step implementation work.

## Quick install

```bash
curl -sL https://plandex.ai/install.sh | bash
```

## Verification

```bash
plandex help
pdx --help
```

Expected behavior: both commands print the Plandex CLI command tree.

## Basic usage

```bash
# Start the REPL in the current project
plandex

# Start directly in implementation mode
plandex --tell

# Start a new plan with more autonomy
plandex new --full

# Show current or recent streams
plandex ps
```

## Prerequisites

- Linux, macOS, or WSL on Windows
- A model provider account or Plandex-compatible hosting mode
- A project directory to work in

## Authentication

Plandex supports integrated and bring-your-own-provider workflows. The simplest BYO route in the docs is OpenRouter:

```bash
export OPENROUTER_API_KEY="your-openrouter-api-key-here"
plandex
```

Plandex also supports direct providers and can connect a Claude Pro or Max subscription with:

```bash
plandex connect-claude
plandex claude-status
```

## Notes

- `pdx` is a built-in alias for `plandex`.
- Plandex plans can continue in the background and later reconnect with `plandex connect`.
- The docs note that Plandex Cloud is winding down for new users, so BYO/self-hosted workflows are the safer default going forward.

## Troubleshooting

### Check commands

```bash
plandex help
plandex [command] --help
```

### Windows support

Use WSL rather than native CMD or PowerShell.

## Additional resources

- Install docs: https://docs.plandex.ai/install
- Quickstart: https://docs.plandex.ai/quick-start
- CLI reference: https://docs.plandex.ai/cli-reference
- Model providers: https://docs.plandex.ai/models/model-providers/
