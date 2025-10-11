# Troubleshooting Guide

Common issues and solutions for AI agent CLI tools.

## 🔧 General Issues

### Command Not Found

**Problem**: After installation, the command is not recognized.

**Solutions**:
```bash
# Check if the command exists
which claude
which cursor-agent
which gemini
which codex

# Check your PATH
echo $PATH

# Add npm global bin to PATH
export PATH="$PATH:$(npm config get prefix)/bin"

# Reload your shell
source ~/.bashrc
# OR
source ~/.zshrc
```

### Permission Denied

**Problem**: Permission errors during installation or usage.

**Solutions**:
```bash
# Fix npm permissions
sudo chown -R $(whoami) $(npm config get prefix)/{lib/node_modules,bin,share}

# Or use a different npm directory
mkdir ~/.npm-global
npm config set prefix '~/.npm-global'
echo 'export PATH=~/.npm-global/bin:$PATH' >> ~/.bashrc
source ~/.bashrc
```

### API Key Issues

**Problem**: Authentication errors or API key not working.

**Solutions**:
1. **Verify API key format**:
   ```bash
   echo $OPENAI_API_KEY
   echo $ANTHROPIC_API_KEY
   echo $GOOGLE_API_KEY
   ```

2. **Check API key validity**:
   - OpenAI: https://platform.openai.com/api-keys
   - Anthropic: https://console.anthropic.com/
   - Google: https://makersuite.google.com/app/apikey

3. **Set environment variables**:
   ```bash
   # Add to your shell profile
   echo 'export OPENAI_API_KEY="your-key-here"' >> ~/.bashrc
   echo 'export ANTHROPIC_API_KEY="your-key-here"' >> ~/.bashrc
   echo 'export GOOGLE_API_KEY="your-key-here"' >> ~/.bashrc
   source ~/.bashrc
   ```

## 🐛 Tool-Specific Issues

### Claude CLI

**Issue**: Claude command not found after npm install
```bash
# Check npm global installation
npm list -g @anthropic-ai/claude-code

# Reinstall if needed
npm uninstall -g @anthropic-ai/claude-code
npm install -g @anthropic-ai/claude-code
```

### Cursor CLI

**Issue**: Installation script fails
```bash
# Try with different approach
wget https://cursor.com/install.sh
chmod +x install.sh
./install.sh

# Or with sudo
curl https://cursor.com/install -fsSL | sudo bash
```

### Gemini CLI

**Issue**: API quota exceeded
- Check your Google Cloud Console quota
- Wait for quota reset
- Upgrade your plan if needed

### Codex CLI

**Issue**: OpenAI API errors
- Check your OpenAI account status
- Verify you have sufficient credits
- Check rate limits

## 🔍 Debugging Steps

1. **Check installation**:
   ```bash
   # For npm packages
   npm list -g | grep tool-name
   
   # For system packages
   which tool-name
   ```

2. **Check environment**:
   ```bash
   # Node.js version
   node --version
   
   # npm version
   npm --version
   
   # Environment variables
   env | grep API
   ```

3. **Check logs**:
   ```bash
   # Run with verbose output
   tool-name --verbose
   
   # Check system logs
   journalctl -u service-name
   ```

## 📞 Getting Help

If you're still having issues:

1. **Check the tool's documentation**
2. **Search GitHub issues**
3. **Check the tool's community forums**
4. **Create a new issue with**:
   - Your operating system
   - Node.js version
   - Error messages
   - Steps to reproduce

## 🔄 Fresh Installation

If all else fails, try a fresh installation:

```bash
# Remove all tools
npm uninstall -g @anthropic-ai/claude-code
npm uninstall -g @google/gemini-cli
npm uninstall -g @openai/codex

# Clean npm cache
npm cache clean --force

# Reinstall Node.js
nvm uninstall 22
nvm install 22

# Reinstall tools
npm install -g @anthropic-ai/claude-code
npm install -g @google/gemini-cli
npm install -g @openai/codex
```