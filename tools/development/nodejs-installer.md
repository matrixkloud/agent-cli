# Node.js Installer Guide

Complete Node.js and npm installation using nvm (Node Version Manager) for better version management.

## 🚀 Quick Install

### Step 1: Install nvm
```bash
# Download and install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash

# Reload your shell configuration
source ~/.bashrc
# OR
source ~/.zshrc
```

### Step 2: Install Node.js
```bash
# Install the latest LTS version of Node.js
nvm install --lts

# Or install a specific version (e.g., v22)
nvm install 22

# Use the installed version
nvm use 22
```

## ✅ Verification

After installation, verify Node.js and npm are working:

```bash
# Check Node.js version
node --version
# Should print: v22.20.0 (or similar)

# Check npm version
npm --version
# Should print: 10.9.3 (or similar)

# Check nvm version
nvm --version
# Should print: 0.40.3 (or similar)
```

## 🔧 Basic Usage

```bash
# List available Node.js versions
nvm list-remote

# Install a specific version
nvm install 18.19.0

# Switch to a version
nvm use 18.19.0

# Set default version
nvm alias default 22

# List installed versions
nvm list

# Uninstall a version
nvm uninstall 18.19.0
```

## 🛠️ Prerequisites

- **curl** or **wget** (for downloading nvm)
- **bash** or **zsh** shell
- **Internet connection**

## 🔑 Environment Setup

Add nvm to your shell profile for automatic loading:

```bash
# For bash
echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.bashrc
echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> ~/.bashrc
echo '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"' >> ~/.bashrc

# For zsh
echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.zshrc
echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> ~/.zshrc
echo '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"' >> ~/.zshrc
```

## 🐛 Troubleshooting

### nvm command not found
```bash
# Reload your shell configuration
source ~/.bashrc
# OR
source ~/.zshrc

# Or manually source nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
```

### Permission denied
```bash
# Fix npm permissions
sudo chown -R $(whoami) $(npm config get prefix)/{lib/node_modules,bin,share}

# Or configure npm to use a different directory
mkdir ~/.npm-global
npm config set prefix '~/.npm-global'
export PATH=~/.npm-global/bin:$PATH
```

### Installation failed
```bash
# Try with different shell
bash -c "curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash"

# Or download manually
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
```

## 📚 Additional Resources

- [nvm GitHub Repository](https://github.com/nvm-sh/nvm)
- [Node.js Official Website](https://nodejs.org/)
- [npm Documentation](https://docs.npmjs.com/)

## 🔄 Updates

To update Node.js and npm:

```bash
# Update nvm itself
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash

# Install latest Node.js LTS
nvm install --lts

# Switch to latest
nvm use --lts
```