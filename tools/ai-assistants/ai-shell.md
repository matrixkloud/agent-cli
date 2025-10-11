# AI Shell Installation Guide

AI Shell's command-line interface for terminal-based AI assistance.

## 🚀 Quick Install

```bash
# Install via pip
pip install ai-shell

# Or via npm
npm install -g ai-shell
```

## ✅ Verification

After installation, verify AI Shell is working:

```bash
# Check if ai command is available
ai --version

# Test with a simple command
ai --help
```

Expected output should show version information and available commands.

## 🔧 Basic Usage

```bash
# Start AI shell
ai

# Ask a question
ai "How do I find large files in Linux?"

# Execute a command with AI help
ai "create a Python script to parse JSON"

# Get help
ai --help
```

## 🛠️ Prerequisites

- **Python** (3.8 or higher) or **Node.js** (v18 or higher)
- **pip** or **npm** (depending on installation method)
- **Internet connection** (for AI features)

## 🔑 Authentication

You'll need to authenticate with your AI provider:

```bash
# Set your API key (OpenAI)
export OPENAI_API_KEY="your-api-key-here"

# Or set for other providers
export ANTHROPIC_API_KEY="your-api-key-here"
export GOOGLE_API_KEY="your-api-key-here"

# Or add to your shell profile
echo 'export OPENAI_API_KEY="your-api-key-here"' >> ~/.bashrc
source ~/.bashrc
```

Get your API key from:
- OpenAI: https://platform.openai.com/api-keys
- Anthropic: https://console.anthropic.com/
- Google: https://makersuite.google.com/app/apikey

## 🐛 Troubleshooting

### Command not found
```bash
# If ai command is not found, check your PATH
echo $PATH

# Add pip bin to PATH if needed
export PATH="$PATH:$HOME/.local/bin"

# Or for npm
export PATH="$PATH:$(npm config get prefix)/bin"
```

### Permission denied
```bash
# Fix pip permissions
pip install --user ai-shell

# Or fix npm permissions
sudo chown -R $(whoami) $(npm config get prefix)/{lib/node_modules,bin,share}
```

### API key issues
- Verify your API key is correct
- Check if you have sufficient credits
- Ensure your account is active

## 📚 Additional Resources

- [AI Shell Website](https://ai-shell.com/)
- [GitHub Repository](https://github.com/ai-shell/ai-shell)
- [Documentation](https://ai-shell.com/docs/)

## 🔄 Updates

To update AI Shell:

```bash
# If installed via pip
pip install --upgrade ai-shell

# If installed via npm
npm update -g ai-shell
```

## 💡 Tips

- Use `ai` for quick terminal assistance
- Great for system administration tasks
- Combine with other terminal tools for powerful workflows
- Use `ai --help` to see all available options