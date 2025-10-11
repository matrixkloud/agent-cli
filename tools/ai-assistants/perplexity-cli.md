# Perplexity AI CLI Installation Guide

Perplexity AI's command-line interface for research and question-answering.

## 🚀 Quick Install

```bash
# Install via pip
pip install perplexity-ai

# Or via npm
npm install -g @perplexity-ai/cli
```

## ✅ Verification

After installation, verify Perplexity CLI is working:

```bash
# Check if perplexity command is available
perplexity --version

# Test with a simple command
perplexity --help
```

Expected output should show version information and available commands.

## 🔧 Basic Usage

```bash
# Ask a question
perplexity "What are the latest trends in AI development?"

# Research a topic
perplexity research "machine learning best practices 2024"

# Get help
perplexity --help
```

## 🛠️ Prerequisites

- **Python** (3.8 or higher) or **Node.js** (v18 or higher)
- **pip** or **npm** (depending on installation method)
- **Internet connection** (for AI features)

## 🔑 Authentication

You'll need to authenticate with your Perplexity API key:

```bash
# Set your API key
export PERPLEXITY_API_KEY="your-api-key-here"

# Or add to your shell profile
echo 'export PERPLEXITY_API_KEY="your-api-key-here"' >> ~/.bashrc
source ~/.bashrc
```

Get your API key from: https://www.perplexity.ai/settings/api

## 🐛 Troubleshooting

### Command not found
```bash
# If perplexity command is not found, check your PATH
echo $PATH

# Add pip bin to PATH if needed
export PATH="$PATH:$HOME/.local/bin"

# Or for npm
export PATH="$PATH:$(npm config get prefix)/bin"
```

### Permission denied
```bash
# Fix pip permissions
pip install --user perplexity-ai

# Or fix npm permissions
sudo chown -R $(whoami) $(npm config get prefix)/{lib/node_modules,bin,share}
```

### API key issues
- Verify your API key is correct
- Check if you have sufficient credits
- Ensure your account is active

## 📚 Additional Resources

- [Perplexity AI Website](https://www.perplexity.ai/)
- [API Documentation](https://docs.perplexity.ai/)
- [GitHub Repository](https://github.com/perplexity-ai/cli)

## 🔄 Updates

To update Perplexity CLI:

```bash
# If installed via pip
pip install --upgrade perplexity-ai

# If installed via npm
npm update -g @perplexity-ai/cli
```

## 💡 Tips

- Use for research and fact-checking
- Great for getting up-to-date information
- Combine with other AI tools for comprehensive answers