# OpenHands CLI installation guide

OpenHands provides an autonomous software engineering agent that can run in CLI mode or launch a local GUI server.

## Quick install

```bash
# Recommended with uv
uvx --python 3.12 openhands

# Install as a persistent tool
uv tool install --python 3.12 openhands-ai
```

## Verification

```bash
openhands --help
openhands serve --help
```

Expected behavior: the CLI prints usage details for interactive and server modes.

## Basic usage

```bash
# Start the interactive CLI
openhands

# Launch the local GUI server
openhands serve

# Use the same tool without a global install
uvx --python 3.12 openhands
```

## Prerequisites

- Python 3.12
- `uv` for the recommended install path
- Docker for workflows that launch the local GUI server
- Access to a supported model provider

## Authentication

The first CLI run guides you through LLM configuration and stores settings in `~/.openhands`.

You can also set provider credentials in your shell:

```bash
export OPENAI_API_KEY="your-openai-api-key-here"
export ANTHROPIC_API_KEY="your-anthropic-api-key-here"
```

## Troubleshooting

### `uvx` not found

```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
```

### GUI mode needs Docker

```bash
docker info
openhands serve
```

## Additional resources

- CLI mode docs: https://docs.all-hands.dev/usage/how-to/cli-mode
- GUI mode docs: https://docs.all-hands.dev/modules/usage/how-to/gui-mode
- GitHub repository: https://github.com/All-Hands-AI/OpenHands
