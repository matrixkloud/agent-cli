# Alibaba Cloud CLI installation guide

Alibaba Cloud CLI is the official command-line tool for managing Alibaba Cloud APIs, resources, and OSS workflows.

## Quick install

```bash
# Linux and macOS script install
/bin/bash -c "$(curl -fsSL https://aliyuncli.alicdn.com/install.sh)"

# macOS Homebrew alternative
brew install aliyun-cli
```

## Verification

```bash
aliyun version
aliyun help
```

Expected behavior: `aliyun version` returns the installed version, and `aliyun help` shows the top-level command tree.

## Basic usage

```bash
# Configure a profile
aliyun configure

# Show configured profiles
aliyun configure list

# List ECS instances in a region
aliyun ecs DescribeInstances --RegionId ap-southeast-1

# Use integrated ossutil commands
aliyun ossutil ls
```

## Prerequisites

- Linux, macOS, or Windows AMD64 for the standard installers
- An Alibaba Cloud account
- Access credentials such as an AccessKey pair, RAM role, or CloudSSO setup

## Authentication

Configure credentials before running service commands:

```bash
aliyun configure
```

Typical interactive configuration requires:

- `AccessKey ID`
- `AccessKey Secret`
- `RegionId`
- Output format

For multi-account setups, Alibaba Cloud also documents CloudSSO-based access through the CLI.

## Troubleshooting

### Re-run install help

```bash
/bin/bash -c "$(curl -fsSL https://aliyuncli.alicdn.com/install.sh)" -- -h
```

### Install a specific version

```bash
/bin/bash -c "$(curl -fsSL https://aliyuncli.alicdn.com/install.sh)" -- -V 3.0.277
```

### Manual TGZ install on Linux

```bash
curl https://aliyuncli.alicdn.com/aliyun-cli-linux-latest-amd64.tgz -o aliyun-cli-linux-latest.tgz
tar xzvf aliyun-cli-linux-latest.tgz
sudo mv ./aliyun /usr/local/bin/
```

## Additional resources

- User guide: https://www.alibabacloud.com/help/en/openapi/developer-reference/new-cli-guide
- Linux install: https://www.alibabacloud.com/help/en/cli/install-cli-on-linux
- macOS install: https://www.alibabacloud.com/help/en/cli/install-cli-on-macos
- CLI overview: https://www.alibabacloud.com/help/en/cli/overview
