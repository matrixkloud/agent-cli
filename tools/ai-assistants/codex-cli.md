# Codex CLI Installation Guide

OpenAI's Codex command-line interface for AI-powered coding assistance.

## 🚀 Quick Install

```bash
npm install -g @openai/codex
```

## ✅ Verification

After installation, verify Codex CLI is working:

```bash
# Check if codex command is available
codex --version

# Test with a simple command
codex --help
```

Expected output should show version information and available commands.

## 🔧 Basic Usage

```bash
# Start an interactive chat session
codex chat

# Ask a specific question
codex ask "How do I implement a REST API in Node.js?"

# Get help
codex --help
```

## 🛠️ Prerequisites

- **Node.js** (v18 or higher)
- **npm** (comes with Node.js)
- **Internet connection** (for API calls)

## 🔑 Authentication

You'll need to authenticate with your OpenAI API key:

```bash
# Set your API key
export OPENAI_API_KEY="your-api-key-here"

# Or add to your shell profile
echo 'export OPENAI_API_KEY="your-api-key-here"' >> ~/.bashrc
source ~/.bashrc
```

Get your API key from: https://platform.openai.com/api-keys

### Remote tunnel workflow
When Codex runs on a remote server, tunnel the API port instead of exposing it publicly:

```bash
# Forward Codex service on port 1455 to your workstation
ssh -L 1455:localhost:1455 root@server_ip

# Point the CLI at the forwarded endpoint
export CODEX_API_URL="http://localhost:1455"
codex chat
```

Keep the SSH session open while using Codex, and store permanent environment overrides in `~/.ai-cli-env` or your shell profile. Re-run `bash scripts/quick-test.sh` locally to confirm the tunnel resolves before closing the session.

## 🐛 Troubleshooting

### Command not found
```bash
# If codex command is not found, check your PATH
echo $PATH

# Add npm global bin to PATH if needed
export PATH="$PATH:$(npm config get prefix)/bin"
```

### Permission denied
```bash
# Fix npm permissions
sudo chown -R $(whoami) $(npm config get prefix)/{lib/node_modules,bin,share}
```

### API key issues
- Verify your API key is correct
- Check if you have sufficient credits
- Ensure your account is active

## 📚 Additional Resources

- [OpenAI Documentation](https://platform.openai.com/docs)
- [GitHub Repository](https://github.com/openai/codex-cli)
- [API Reference](https://platform.openai.com/docs/api-reference)

## 🔄 Updates

To update Codex CLI:

```bash
# Update to latest version
npm update -g @openai/codex

# Or reinstall
npm uninstall -g @openai/codex
npm install -g @openai/codex
```
