# Qwen Code CLI installation guide

Qwen Code is Alibaba Cloud and Qwen's terminal coding agent optimized for Qwen3-Coder.

## Quick install

```bash
# macOS and Linux
curl -fsSL https://qwen-code-assets.oss-cn-hangzhou.aliyuncs.com/installation/install-qwen.sh | bash

# npm alternative
npm install -g @qwen-code/qwen-code@latest
```

## Verification

```bash
qwen --version
qwen
```

Expected behavior: `qwen --version` prints the installed version, and `qwen` starts the interactive terminal UI.

## Basic usage

```bash
# Start in the current project
qwen

# Open authentication settings from inside Qwen Code
/auth

# Initialize project context
/init

# Resume an earlier session
/resume
```

## Prerequisites

- Node.js 20 or later
- An Alibaba Cloud Model Studio API key or a Qwen OAuth login
- A project directory rather than a very large filesystem root

## Authentication

Qwen Code supports two main authentication flows:

1. Alibaba Cloud Model Studio API key
2. Qwen OAuth

For the Model Studio API-key path, create `~/.qwen/settings.json` and set `BAILIAN_API_KEY` plus an OpenAI-compatible DashScope endpoint:

```json
{
  "env": {
    "BAILIAN_API_KEY": "YOUR_API_KEY"
  },
  "modelProviders": {
    "openai": [
      {
        "id": "qwen3-coder-plus",
        "name": "[Bailian] qwen3-coder-plus",
        "baseUrl": "https://dashscope-intl.aliyuncs.com/compatible-mode/v1",
        "envKey": "BAILIAN_API_KEY"
      }
    ]
  },
  "security": {
    "auth": {
      "selectedType": "openai"
    }
  },
  "model": {
    "name": "qwen3-coder-plus"
  },
  "$version": 3
}
```

Regional endpoints from Alibaba Cloud Model Studio:

- Singapore: `https://dashscope-intl.aliyuncs.com/compatible-mode/v1`
- US (Virginia): `https://dashscope-us.aliyuncs.com/compatible-mode/v1`
- China (Beijing): `https://dashscope.aliyuncs.com/compatible-mode/v1`

For the OAuth path, start `qwen`, run `/auth`, then choose Qwen OAuth and complete browser sign-in.

## Troubleshooting

### Command not found

```bash
export PATH="$HOME/.local/bin:$PATH"
export PATH="$(npm config get prefix)/bin:$PATH"
```

### Wrong API region or 401 errors

Check that `BAILIAN_API_KEY`, `envKey`, and the selected `baseUrl` all match the same region.

### Token usage is too high

Run Qwen Code in the project directory only, and use `/compress` or set `sessionTokenLimit` in `.qwen/settings.json`.

## Additional resources

- Alibaba Cloud Qwen Code guide: https://www.alibabacloud.com/help/en/model-studio/qwen-code
- Coding Plan guide: https://www.alibabacloud.com/help/en/model-studio/qwen-code-coding-plan
- Official Qwen Code docs: https://qwenlm.github.io/qwen-code-docs/en/users/overview/
- GitHub repository: https://github.com/QwenLM/qwen-code
