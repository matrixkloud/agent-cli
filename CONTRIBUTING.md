# Contributing to AI Agent CLI Tools

First off, thank you for considering contributing to this project! We welcome any contributions, from bug reports to new features.

## Code of Conduct

This project and everyone participating in it is governed by the [Code of Conduct](./CODE_OF_CONDUCT.md). By participating, you are expected to uphold this code. Please report unacceptable behavior to [INSERT CONTACT METHOD].

## How Can I Contribute?

### Reporting Bugs

If you find a bug, please open an issue on GitHub. Please include as much detail as possible, including:

*   A clear and descriptive title
*   A detailed description of the bug
*   Steps to reproduce the bug
*   Your operating system and version
*   Any relevant logs or screenshots

### Suggesting Enhancements

If you have an idea for a new feature or an enhancement to an existing one, please open an issue on GitHub. Please include as much detail as possible, including:

*   A clear and descriptive title
*   A detailed description of the enhancement
*   Any relevant mockups or screenshots

### Pull Requests

If you would like to contribute code, please open a pull request. Please make sure that your pull request:

*   Is well-documented
*   Follows the coding style of the project
*   Includes tests for any new features or bug fixes
*   Is up-to-date with the `main` branch

## Project Structure & Module Organization

The CLI installer lives around `setup-workstation.sh`, while automation lives in `scripts/`. Use `scripts/select-agents.sh` to update menu flows, and `scripts/quick-test.sh` for verification logic. Documentation is grouped under `tools/ai-assistants/` and `tools/development/` with one Markdown guide per tool following `docs/template.md`. Reference materials (usage, troubleshooting) sit in `docs/` and `USAGE.md`. Place shared assets in `docs/` or `tools/` subdirectories—avoid adding binaries.

## Build, Test, and Development Commands

Run `./setup-workstation.sh` to validate cross-platform setup routines end-to-end. Use `bash scripts/select-agents.sh` during development to confirm menu prompts when adding or renaming tools. Execute `bash scripts/quick-test.sh` before submitting changes; it detects missing CLIs and API keys. For deeper diagnostics, `bash scripts/health-monitor.sh` persists logs under `~/.local/log/ai-cli`.

## Coding Style & Naming Conventions

Markdown guides use sentence-case headings and the sections defined in `docs/template.md`; keep installer steps in fenced `bash` blocks and include verification snippets. Name new docs with kebab-case (e.g., `tools/ai-assistants/perplexity-cli.md`) and update indices. Shell scripts should remain POSIX-friendly bash with `set -e`, four-space indentation, and logging via `log_*` helpers. Utilities belong in `scripts/` and should expose self-describing function names like `install_nodejs`.

## Remote Access & Authentication

Codex users connecting to protected clusters should tunnel ports instead of exposing services. Forward the Codex API locally with `ssh -L 1455:localhost:1455 root@server_ip` and export `CODEX_API_URL="http://localhost:1455"`. Store API keys in `~/.ai-cli-env`, then re-run `bash scripts/quick-test.sh` to verify the forwarded endpoint responds. Document bespoke bastion workflows in the relevant tool guide when deviating from this pattern.

## Testing Guidelines

Treat every installer doc as executable instructions: manually run the commands you add, capture expected outputs, and call out prerequisites. Run `bash scripts/quick-test.sh` to ensure core tools resolve and API key checks pass. When touching network checks or telemetry, also run `bash scripts/health-monitor.sh` and confirm it handles missing credentials without exiting non-zero.

## Commit & Pull Request Guidelines

Follow Conventional Commits (`feat:`, `fix:`, `docs:`) as seen in `feat: Complete AI CLI Tools ecosystem with cross-platform support`. Limit subject lines to 72 characters and keep bodies focused on rationale. PRs should link related issues, summarize installer/tool changes, list affected scripts/docs, and note which validation commands were run. Include screenshots only when altering interactive prompts.
