# Tool Installation Template

Use this template when adding new tools to the repository.

## Tool Name

Brief description of what the tool does.

## Quick Install

```bash
# Primary installation command
command-to-install

# Alternative installation method (if applicable)
alternative-command
```

## Verification

After installation, verify the tool is working:

```bash
# Check if command is available
tool-name --version

# Test with a simple command
tool-name --help
```

Expected output should show version information and available commands.

## Basic Usage

```bash
# Basic usage example 1
tool-name command1

# Basic usage example 2
tool-name command2 "parameter"

# Get help
tool-name --help
```

## Advanced Usage

```bash
# Advanced usage example 1
tool-name command1 --option1 --option2

# Advanced usage example 2
tool-name command2 --option3 "parameter"
```

## Prerequisites

- **Node.js** (v18 or higher) - if applicable
- **npm** (comes with Node.js) - if applicable
- **Other prerequisites**
- **Internet connection** (if applicable)

## Authentication

Many of the AI tools require an API key to function. An API key is a secret token that is used to authenticate you with the tool's API. You can get an API key from the tool's website.

Once you have an API key, you need to configure it on your system. The recommended way to do this is to add the API key to the `~/.ai-cli-env` file.

```bash
# Set your API key
export TOOL_API_KEY="your-api-key-here"

# Or add to your shell profile
echo 'export TOOL_API_KEY="your-api-key-here"' >> ~/.bashrc
source ~/.bashrc
```

Get your API key from: [API Key Source URL]

## Troubleshooting

### Command not found

If you get a "command not found" error after installing a tool, it is likely that the tool's installation directory is not in your system's `PATH`.

**Solution:**

1.  **Check your `PATH`:**

    ```bash
    echo $PATH
    ```

2.  **Add the installation directory to your `PATH`:**

    *   For npm packages, the installation directory is usually `$(npm config get prefix)/bin`.
    *   For pip packages, the installation directory is usually `~/.local/bin`.

    You can add the installation directory to your `PATH` by adding the following line to your shell's configuration file (e.g., `~/.bashrc`, `~/.zshrc`):

    ```bash
    export PATH="$PATH:/path/to/installation/directory"
    ```

3.  **Reload your shell's configuration file:**

    ```bash
    source ~/.bashrc
    ```

### Permission denied

If you get a "permission denied" error when installing or using a tool, it is likely that you do not have the necessary permissions to access the tool's files.

**Solution:**

*   **For npm packages, you can fix this by running the following command:**

    ```bash
    sudo chown -R $(whoami) $(npm config get prefix)/{lib/node_modules,bin,share}
    ```

*   **For pip packages, you can fix this by running the following command:**

    ```bash
    pip install --user <package-name>
    ```

### Common issues

- Issue 1: Solution 1
- Issue 2: Solution 2

## Additional Resources

- [Official Documentation](https://tool-website.com/docs)
- [GitHub Repository](https://github.com/tool/tool-repo)
- [API Reference](https://tool-website.com/api)

## Updates

To update the tool:

```bash
# Update command
update-command-here
```

## Notes

- Any additional notes about the tool
- Special considerations
- Platform-specific information
