# gptme CLI installation guide

gptme is a terminal agent with built-in tools for shell execution, patching files, browsing, vision, plugins, and subagents.

## Quick install

```bash
# Recommended
pipx install gptme

# uv alternative
uv tool install gptme
```

## Verification

```bash
gptme --help
gptme-util tools list
```

Expected behavior: `gptme --help` prints the CLI usage, and `gptme-util tools list` shows the available tool set.

## Basic usage

```bash
# Start an interactive session
gptme

# Work on a specific task with files in context
gptme "fix TODOs" main.py

# Use only selected tools
gptme -t patch,save "fix typo" README.md

# Add subagent support
gptme -t +subagent "plan a refactor"
```

## Prerequisites

- Python with `pipx` or `uv`
- API keys for your selected LLM provider
- Optional extras such as Playwright, `gh`, or `tmux` for some tools

## Authentication

If no provider key is configured, gptme prompts for one on first run and stores it in configuration. Common environment-based setup:

```bash
export OPENAI_API_KEY="your-openai-api-key-here"
export ANTHROPIC_API_KEY="your-anthropic-api-key-here"
```

## Notes

- gptme includes tool commands like `/tools`, `/model`, `/commit`, `/compact`, and `/doctor`.
- Browser support can use Playwright or Lynx depending on your environment.
- The docs include plugin and hook systems if you want to extend it beyond the default coding workflow.

## Troubleshooting

### Command not found

```bash
export PATH="$HOME/.local/bin:$PATH"
```

### Browser tooling

Install the browser extra if you need full automation:

```bash
pipx install 'gptme[browser]'
```

## Additional resources

- Getting started: https://gptme.org/docs/getting-started.html
- CLI reference: https://gptme.org/docs/cli.html
- Tools overview: https://gptme.org/docs/tools.html
