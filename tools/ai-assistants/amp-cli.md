# Amp CLI installation guide

Amp is a terminal-first coding agent with interactive and execute modes.

## Quick install

```bash
# Recommended installer
curl -fsSL https://ampcode.com/install.sh | bash

# Start the CLI after install
amp
```

## Verification

```bash
amp --help
amp permissions list --builtin
```

Expected behavior: `amp --help` prints command usage, and the permissions command lists builtin execution rules.

## Basic usage

```bash
# Start an interactive session
amp

# Run one task and exit
amp -x "what files in this folder are markdown files? Print only the filenames."

# Stream JSON output for scripting
amp --execute "summarize this repository" --stream-json
```

## Prerequisites

- Supported macOS, Linux, or WSL environment
- Amp account sign-in for interactive use
- `AMP_API_KEY` for non-interactive environments

## Authentication

Interactive mode prompts for login on first run. For CI or scripts:

```bash
export AMP_API_KEY="your-access-token-here"
```

## Troubleshooting

### Command not found

```bash
export PATH="$HOME/.local/bin:$PATH"
```

### Check builtin permission behavior

```bash
amp permissions list --builtin
```

### Connect to supported IDEs

```bash
amp --jetbrains
```

## Additional resources

- Owner's manual: https://ampcode.com/manual
- Appendix and CLI details: https://ampcode.com/manual/appendix
