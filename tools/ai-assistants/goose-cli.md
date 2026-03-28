# Goose CLI installation guide

Goose is Block's open source coding agent for terminal and desktop workflows.

## Quick install

```bash
# Linux, macOS, and supported Windows shells
curl -fsSL https://github.com/block/goose/releases/download/stable/download_cli.sh | bash

# Homebrew alternative
brew install block-goose-cli
```

## Verification

```bash
goose --version
goose configure
```

Expected behavior: `goose --version` prints the installed version, and `goose configure` opens provider setup.

## Basic usage

```bash
# Start the interactive CLI
goose

# Reconfigure providers or models
goose configure

# Update to the latest stable release
goose update
```

## Prerequisites

- A modern terminal on macOS, Linux, or Windows
- Internet access for installation and model-provider access
- An LLM provider account or supported sign-in flow

## Authentication

On first run, Goose prompts you to configure a provider. Supported flows include direct API-key setup and provider-specific sign-in where available.

Common environment-based setup:

```bash
export OPENAI_API_KEY="your-openai-api-key-here"
export GOOGLE_API_KEY="your-google-api-key-here"
```

## Troubleshooting

### Command not found

```bash
export PATH="$HOME/.local/bin:$PATH"
```

### Re-run setup

```bash
goose configure
```

### Update the CLI

```bash
goose update
```

## Additional resources

- Official installation guide: https://block.github.io/goose/docs/getting-started/installation/
- Quickstart: https://block.github.io/goose/docs/quickstart
- GitHub repository: https://github.com/block/goose
