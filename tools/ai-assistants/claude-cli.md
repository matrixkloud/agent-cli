# Claude CLI Installation Guide

Anthropic's Claude command-line interface for AI-powered coding assistance.

## 🚀 Quick Install

### Option 1: One-line installer (Recommended)
```bash
curl -fsSL https://claude.ai/install.sh | bash
```

### Option 2: npm install
```bash
npm install -g @anthropic-ai/claude-code
```

## ✅ Verification

After installation, verify Claude CLI is working:

```bash
# Check if claude command is available
claude --version

# Test with a simple command
claude --help
```

Expected output should show version information and available commands.

## 🔧 Basic Usage

```bash
# Start an interactive chat session
claude chat

# Ask a specific question
claude ask "How do I implement a binary search in Python?"

# Get help
claude --help
```

## 🛠️ Prerequisites

- **Node.js** (v18 or higher)
- **npm** (comes with Node.js)
- **curl** (for the installer script)
- **Internet connection** (for API calls)

## 🔑 Authentication

You'll need to authenticate with your Anthropic API key:

```bash
# Set your API key
export ANTHROPIC_API_KEY="your-api-key-here"

# Or add to your shell profile
echo 'export ANTHROPIC_API_KEY="your-api-key-here"' >> ~/.bashrc
source ~/.bashrc
```

Get your API key from: https://console.anthropic.com/

## 🐛 Troubleshooting

### Command not found
```bash
# If claude command is not found, check your PATH
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

- [Official Documentation](https://docs.anthropic.com/)
- [GitHub Repository](https://github.com/anthropics/claude-cli)
- [API Reference](https://docs.anthropic.com/api)

## 🔄 Updates

To update Claude CLI:

```bash
# If installed via npm
npm update -g @anthropic-ai/claude-code

# If installed via script, re-run the installer
curl -fsSL https://claude.ai/install.sh | bash
```