# Ollama CLI Installation Guide

Ollama's command-line interface for running local AI models (Llama, Mistral, CodeLlama, etc.).

## 🚀 Quick Install

```bash
# Install Ollama
curl -fsSL https://ollama.ai/install.sh | sh
```

## ✅ Verification

After installation, verify Ollama CLI is working:

```bash
# Check if ollama command is available
ollama --version

# Test with a simple command
ollama --help
```

Expected output should show version information and available commands.

## 🔧 Basic Usage

```bash
# List available models
ollama list

# Pull a model (e.g., Llama 2)
ollama pull llama2

# Run a model interactively
ollama run llama2

# Ask a question
ollama run llama2 "Explain quantum computing"

# Generate code
ollama run codellama "Write a Python function to sort a list"
```

## 🛠️ Prerequisites

- **curl** (for installation)
- **Internet connection** (for downloading models)
- **Sufficient disk space** (models can be several GB)

## 🔑 Authentication

Ollama runs locally, so no API keys are required. However, you may need to:

```bash
# Start the Ollama service
ollama serve

# Check if service is running
ollama ps
```

## 🐛 Troubleshooting

### Command not found
```bash
# If ollama command is not found, check your PATH
echo $PATH

# Add Ollama to PATH if needed
export PATH="$PATH:$HOME/.local/bin"
```

### Service not running
```bash
# Start Ollama service
ollama serve

# Check if it's running
ollama ps
```

### Model download issues
```bash
# Check available models
ollama list

# Try pulling a smaller model first
ollama pull tinyllama

# Check disk space
df -h
```

### Permission denied
```bash
# Fix permissions
sudo chown -R $(whoami) ~/.ollama
```

## 📚 Additional Resources

- [Ollama Website](https://ollama.ai/)
- [Model Library](https://ollama.ai/library)
- [GitHub Repository](https://github.com/ollama/ollama)

## 🔄 Updates

To update Ollama:

```bash
# Update Ollama
curl -fsSL https://ollama.ai/install.sh | sh

# Update models
ollama pull llama2:latest
```

## 💡 Popular Models

```bash
# Code generation
ollama pull codellama
ollama pull deepseek-coder

# General purpose
ollama pull llama2
ollama pull mistral

# Small and fast
ollama pull tinyllama
ollama pull phi

# Specialized
ollama pull starcoder
ollama pull wizardcoder
```

## 🔧 Advanced Usage

```bash
# Run with specific parameters
ollama run llama2 --temperature 0.7 --top-p 0.9

# Create custom models
ollama create mymodel -f Modelfile

# Export models
ollama export llama2 -o llama2.tar

# Import models
ollama import llama2.tar
```