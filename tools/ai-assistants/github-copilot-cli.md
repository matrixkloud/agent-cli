# GitHub Copilot CLI Installation Guide

Microsoft's GitHub Copilot command-line interface for AI-powered coding assistance.

## 🚀 Quick Install

### Option 1: GitHub CLI with Copilot extension (Recommended)
```bash
# Install GitHub CLI
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt update
sudo apt install gh

# Install Copilot CLI extension
gh extension install github/gh-copilot
```

### Option 2: npm install
```bash
npm install -g @githubnext/github-copilot-cli
```

## ✅ Verification

After installation, verify GitHub Copilot CLI is working:

```bash
# Check if gh command is available
gh --version

# Check if copilot extension is installed
gh copilot --help

# Test with a simple command
gh copilot suggest "How do I implement a binary search?"
```

Expected output should show version information and available commands.

## 🔧 Basic Usage

```bash
# Get AI suggestions for code
gh copilot suggest "implement a REST API endpoint"

# Explain code
gh copilot explain "function fibonacci(n) { return n <= 1 ? n : fibonacci(n-1) + fibonacci(n-2); }"

# Generate tests
gh copilot test "function add(a, b) { return a + b; }"

# Get help
gh copilot --help
```

## 🛠️ Prerequisites

- **GitHub CLI** (gh command)
- **Git** (for version control)
- **Internet connection** (for AI features)
- **GitHub account** with Copilot access

## 🔑 Authentication

You'll need to authenticate with GitHub and have Copilot access:

```bash
# Login to GitHub
gh auth login

# Check authentication status
gh auth status

# Check Copilot access
gh copilot status
```

**Note**: You need a GitHub Copilot subscription to use the CLI features.

## 🐛 Troubleshooting

### Command not found
```bash
# If gh command is not found, check your PATH
echo $PATH

# Add GitHub CLI to PATH if needed
export PATH="$PATH:/usr/bin"
```

### Copilot extension not found
```bash
# Reinstall the extension
gh extension remove github/gh-copilot
gh extension install github/gh-copilot
```

### Authentication issues
```bash
# Re-authenticate
gh auth logout
gh auth login

# Check your GitHub account has Copilot access
gh copilot status
```

### Permission denied
```bash
# Fix permissions
sudo chown -R $(whoami) /usr/share/keyrings/
sudo chown -R $(whoami) /etc/apt/sources.list.d/
```

## 📚 Additional Resources

- [GitHub CLI Documentation](https://cli.github.com/)
- [GitHub Copilot CLI Extension](https://github.com/github/gh-copilot)
- [GitHub Copilot Documentation](https://docs.github.com/en/copilot)

## 🔄 Updates

To update GitHub Copilot CLI:

```bash
# Update GitHub CLI
sudo apt update && sudo apt upgrade gh

# Update Copilot extension
gh extension upgrade github/gh-copilot

# Or if installed via npm
npm update -g @githubnext/github-copilot-cli
```

## 💡 Tips

- Use `gh copilot suggest` for code generation
- Use `gh copilot explain` to understand complex code
- Use `gh copilot test` to generate unit tests
- Combine with `gh` commands for full GitHub integration