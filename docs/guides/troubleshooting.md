# Troubleshooting Guide

This guide provides solutions to common issues you may encounter when using the AI Agent CLI Tools.

## General Issues

### Command Not Found

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

### Permission Denied

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

### API Key Issues

If you get an API key error, it is likely that your API key is not configured correctly.

**Solution:**

1.  **Make sure that you have a valid API key.** You can get API keys from the following sources:

    *   **Anthropic Claude:** [https://console.anthropic.com/](https://console.anthropic.com/)
    *   **Google Gemini:** [https://makersuite.google.com/app/apikey](https://makersuite.google.com/app/apikey)
    *   **OpenAI:** [https://platform.openai.com/api-keys](https://platform.openai.com/api-keys)
    *   **Perplexity AI:** [https://www.perplexity.ai/settings/api](https://www.perplexity.ai/settings/api)

2.  **Make sure that your API key is configured correctly.** You can configure your API key by adding it to the `~/.ai-cli-env` file.

    ```bash
    # Anthropic Claude API Key
    export ANTHROPIC_API_KEY="your-anthropic-api-key-here"

    # Google Gemini API Key
    export GOOGLE_API_KEY="your-google-api-key-here"

    # OpenAI API Key
    export OPENAI_API_KEY="your-openai-api-key-here"

    # Perplexity API Key
    export PERPLEXITY_API_KEY="your-perplexity-api-key-here"
    ```

## Tool-Specific Issues

### Claude CLI

*   **Issue:** `claude` command not found after npm install
*   **Solution:**

    ```bash
    # Check npm global installation
    npm list -g @anthropic-ai/claude-code

    # Reinstall if needed
    npm uninstall -g @anthropic-ai/claude-code
    npm install -g @anthropic-ai/claude-code
    ```

### Cursor CLI

*   **Issue:** Installation script fails
*   **Solution:**

    ```bash
    # Try with different approach
    wget https://cursor.com/install.sh
    chmod +x install.sh
    ./install.sh

    # Or with sudo
    curl https://cursor.com/install -fsSL | sudo bash
    ```

### Gemini CLI

*   **Issue:** API quota exceeded
*   **Solution:**

    *   Check your Google Cloud Console quota
    *   Wait for quota reset
    *   Upgrade your plan if needed

### Codex CLI

*   **Issue:** OpenAI API errors
*   **Solution:**

    *   Check your OpenAI account status
    *   Verify you have sufficient credits
    *   Check rate limits

## Getting Help

If you are still having issues, you can get help by:

*   **Opening an issue on GitHub:** [https://github.com/matrix-kloud/agent-cli/issues](https://github.com/matrix-kloud/agent-cli/issues)
*   **Asking a question in the discussions:** [https://github.com/matrix-kloud/agent-cli/discussions](https://github.com/matrix-kloud/agent-cli/discussions)
