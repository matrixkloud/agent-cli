# Tool Installation Template

Use this template when adding new tools to the repository.

## Tool Name

Brief description of what the tool does.

## 🚀 Quick Install

```bash
# Primary installation command
command-to-install

# Alternative installation method (if applicable)
alternative-command
```

## ✅ Verification

After installation, verify the tool is working:

```bash
# Check if command is available
tool-name --version

# Test with a simple command
tool-name --help
```

Expected output should show version information and available commands.

## 🔧 Basic Usage

```bash
# Basic usage example 1
tool-name command1

# Basic usage example 2
tool-name command2 "parameter"

# Get help
tool-name --help
```

## 🛠️ Prerequisites

- **Node.js** (v18 or higher) - if applicable
- **npm** (comes with Node.js) - if applicable
- **Other prerequisites**
- **Internet connection** (if applicable)

## 🔑 Authentication

If the tool requires authentication:

```bash
# Set your API key
export TOOL_API_KEY="your-api-key-here"

# Or add to your shell profile
echo 'export TOOL_API_KEY="your-api-key-here"' >> ~/.bashrc
source ~/.bashrc
```

Get your API key from: [API Key Source URL]

## 🐛 Troubleshooting

### Command not found
```bash
# If command is not found, check your PATH
echo $PATH

# Add to PATH if needed
export PATH="$PATH:/path/to/tool/bin"
```

### Permission denied
```bash
# Fix permissions (adjust as needed)
sudo chown -R $(whoami) /path/to/tool
```

### Common issues
- Issue 1: Solution 1
- Issue 2: Solution 2

## 📚 Additional Resources

- [Official Documentation](https://tool-website.com/docs)
- [GitHub Repository](https://github.com/tool/tool-repo)
- [API Reference](https://tool-website.com/api)

## 🔄 Updates

To update the tool:

```bash
# Update command
update-command-here
```

## 📝 Notes

- Any additional notes about the tool
- Special considerations
- Platform-specific information