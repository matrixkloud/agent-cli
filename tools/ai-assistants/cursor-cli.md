# Cursor CLI Installation Guide

Cursor's AI-powered code editor command-line interface for enhanced coding productivity.

## 🚀 Quick Install

```bash
# Install Cursor
curl https://cursor.com/install -fsSL | bash
```

## ✅ Verification

After installation, verify Cursor CLI is working:

```bash
# Check if cursor-agent command is available
cursor-agent --version

# Test with a simple command
cursor-agent --help
```

Expected output should show version information and available commands.

## 🔧 Basic Usage

```bash
# Start CLI with a prompt
cursor-agent chat "find one bug and fix it"

# Open Cursor editor
cursor-agent open

# Get help
cursor-agent --help
```

## 🛠️ Prerequisites

- **Node.js** (v18 or higher)
- **npm** (comes with Node.js)
- **curl** (for the installer script)
- **Internet connection** (for AI features)

## 🔑 Authentication

You may need to authenticate with your Cursor account:

```bash
# Login to Cursor
cursor-agent login

# Check authentication status
cursor-agent auth status
```

## 🐛 Troubleshooting

### Command not found
```bash
# If cursor-agent command is not found, check your PATH
echo $PATH

# Add to PATH if needed
export PATH="$PATH:/usr/local/bin"
```

### Permission denied
```bash
# Fix permissions
sudo chown -R $(whoami) /usr/local/bin/cursor-agent
```

### Installation failed
```bash
# Try with sudo if needed
curl https://cursor.com/install -fsSL | sudo bash

# Or download manually
wget https://cursor.com/install.sh
chmod +x install.sh
./install.sh
```

## 📚 Additional Resources

- [Official Website](https://cursor.com/)
- [Documentation](https://cursor.com/docs)
- [GitHub Repository](https://github.com/getcursor/cursor)

## 🔄 Updates

To update Cursor CLI:

```bash
# Re-run the installer (it will update if already installed)
curl https://cursor.com/install -fsSL | bash
```