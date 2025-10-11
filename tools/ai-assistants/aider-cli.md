# Aider CLI Installation Guide

Aider's command-line interface for AI pair programming and code editing.

## 🚀 Quick Install

```bash
# Install via pip
pip install aider-chat

# Or via pipx (recommended)
pipx install aider-chat
```

## ✅ Verification

After installation, verify Aider CLI is working:

```bash
# Check if aider command is available
aider --version

# Test with a simple command
aider --help
```

Expected output should show version information and available commands.

## 🔧 Basic Usage

```bash
# Start aider in a project directory
aider

# Start aider with specific files
aider main.py utils.py

# Start aider with a specific model
aider --model gpt-4

# Start aider with a specific API provider
aider --api-provider openai
```

## 🛠️ Prerequisites

- **Python** (3.8 or higher)
- **pip** or **pipx**
- **Git** (for version control)
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
# If aider command is not found, check your PATH
echo $PATH

# Add pip bin to PATH if needed
export PATH="$PATH:$HOME/.local/bin"

# Or for pipx
export PATH="$PATH:$HOME/.local/bin"
```

### Permission denied
```bash
# Fix pip permissions
pip install --user aider-chat

# Or use pipx (recommended)
pipx install aider-chat
```

### API key issues
- Verify your API key is correct
- Check if you have sufficient credits
- Ensure your account is active

## 📚 Additional Resources

- [Aider Website](https://aider.chat/)
- [GitHub Repository](https://github.com/paul-gauthier/aider)
- [Documentation](https://aider.chat/docs/)

## 🔄 Updates

To update Aider CLI:

```bash
# If installed via pip
pip install --upgrade aider-chat

# If installed via pipx
pipx upgrade aider-chat
```

## 💡 Tips

- Use `aider` in a Git repository for best results
- Aider can edit multiple files simultaneously
- Use `aider --help` to see all available options
- Combine with version control for safe AI-assisted coding