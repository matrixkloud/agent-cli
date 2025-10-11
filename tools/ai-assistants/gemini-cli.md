# Gemini CLI Installation Guide

Google's Gemini AI command-line interface for AI-powered coding assistance.

## 🚀 Quick Install

```bash
npm install -g @google/gemini-cli
```

## ✅ Verification

After installation, verify Gemini CLI is working:

```bash
# Check if gemini command is available
gemini --version

# Test with a simple command
gemini --help
```

Expected output should show version information and available commands.

## 🔧 Basic Usage

```bash
# Start an interactive chat session
gemini chat

# Ask a specific question
gemini ask "Explain machine learning concepts"

# Get help
gemini --help
```

## 🛠️ Prerequisites

- **Node.js** (v18 or higher)
- **npm** (comes with Node.js)
- **Internet connection** (for API calls)

## 🔑 Authentication

You'll need to authenticate with your Google API key:

```bash
# Set your API key
export GOOGLE_API_KEY="your-api-key-here"

# Or add to your shell profile
echo 'export GOOGLE_API_KEY="your-api-key-here"' >> ~/.bashrc
source ~/.bashrc
```

Get your API key from: https://makersuite.google.com/app/apikey

## 🐛 Troubleshooting

### Command not found
```bash
# If gemini command is not found, check your PATH
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
- Check if you have sufficient quota
- Ensure your account is active

## 📚 Additional Resources

- [Official Documentation](https://ai.google.dev/docs)
- [GitHub Repository](https://github.com/google/gemini-cli)
- [API Reference](https://ai.google.dev/api)

## 🔄 Updates

To update Gemini CLI:

```bash
# Update to latest version
npm update -g @google/gemini-cli

# Or reinstall
npm uninstall -g @google/gemini-cli
npm install -g @google/gemini-cli
```