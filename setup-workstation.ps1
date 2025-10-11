# AI Agent CLI Tools Workstation Setup Script for Windows PowerShell
# This script prepares your Windows workstation to use all AI agent CLI tools

param(
    [switch]$All,
    [switch]$Select,
    [switch]$List,
    [switch]$Help
)

# Colors for output
$Red = "Red"
$Green = "Green"
$Yellow = "Yellow"
$Blue = "Blue"
$Magenta = "Magenta"
$Cyan = "Cyan"

# Logging functions
function Log-Info {
    param([string]$Message)
    Write-Host "[INFO] $Message" -ForegroundColor $Blue
}

function Log-Success {
    param([string]$Message)
    Write-Host "[SUCCESS] $Message" -ForegroundColor $Green
}

function Log-Warning {
    param([string]$Message)
    Write-Host "[WARNING] $Message" -ForegroundColor $Yellow
}

function Log-Error {
    param([string]$Message)
    Write-Host "[ERROR] $Message" -ForegroundColor $Red
}

# Check if command exists
function Test-Command {
    param([string]$Command)
    $null = Get-Command $Command -ErrorAction SilentlyContinue
    return $?
}

# Check prerequisites
function Test-Prerequisites {
    Log-Info "Checking system prerequisites..."
    
    $missingDeps = @()
    
    # Check for winget
    if (-not (Test-Command "winget")) {
        $missingDeps += "winget"
    } else {
        Log-Success "winget is installed"
    }
    
    # Check for git
    if (-not (Test-Command "git")) {
        $missingDeps += "git"
    } else {
        Log-Success "git is installed"
    }
    
    if ($missingDeps.Count -gt 0) {
        Log-Error "Missing required dependencies: $($missingDeps -join ', ')"
        Log-Info "Please install them using:"
        Log-Info "  winget install Microsoft.Git"
        Log-Info "  winget install Microsoft.WindowsAppRuntime"
        exit 1
    }
}

# Install Node.js
function Install-NodeJS {
    Log-Info "Installing Node.js..."
    
    if (Test-Command "node") {
        Log-Info "Node.js is already installed"
        return
    }
    
    try {
        winget install OpenJS.NodeJS
        Log-Success "Node.js installed successfully"
    } catch {
        Log-Error "Failed to install Node.js"
        exit 1
    }
}

# Install AI tools
function Install-AITools {
    param([string[]]$SelectedAgents)
    
    Log-Info "Installing selected AI tools..."
    
    foreach ($agent in $SelectedAgents) {
        switch ($agent) {
            "claude" {
                Log-Info "Installing Claude CLI..."
                npm install -g @anthropic-ai/claude-code
            }
            "gemini" {
                Log-Info "Installing Gemini CLI..."
                npm install -g @google/gemini-cli
            }
            "codex" {
                Log-Info "Installing Codex CLI..."
                npm install -g @openai/codex
            }
            "perplexity" {
                Log-Info "Installing Perplexity CLI..."
                pip install perplexity-ai
            }
            "aider" {
                Log-Info "Installing Aider CLI..."
                pip install aider-chat
            }
            "ai_shell" {
                Log-Info "Installing AI Shell..."
                pip install ai-shell
            }
        }
    }
}

# Main execution
function Main {
    Write-Host "=================================" -ForegroundColor $Magenta
    Write-Host "  AI Agent CLI Tools Setup" -ForegroundColor $Magenta
    Write-Host "=================================" -ForegroundColor $Magenta
    Write-Host ""
    
    if ($Help) {
        Show-Help
        return
    }
    
    if ($List) {
        Show-AvailableAgents
        return
    }
    
    Test-Prerequisites
    Install-NodeJS
    
    if ($All) {
        $agents = @("claude", "gemini", "codex", "perplexity", "aider", "ai_shell")
        Install-AITools -SelectedAgents $agents
    } elseif ($Select) {
        # Interactive selection would go here
        Log-Info "Interactive selection not yet implemented for PowerShell"
    } else {
        Show-Menu
    }
}

function Show-Menu {
    Write-Host "Choose your setup option:" -ForegroundColor $Cyan
    Write-Host ""
    Write-Host "1. Install all AI agents"
    Write-Host "2. Select specific agents"
    Write-Host "3. Show available agents"
    Write-Host "4. Exit"
    Write-Host ""
    
    $choice = Read-Host "Enter your choice (1-4)"
    
    switch ($choice) {
        "1" { 
            $agents = @("claude", "gemini", "codex", "perplexity", "aider", "ai_shell")
            Install-AITools -SelectedAgents $agents
        }
        "2" { Log-Info "Selection mode not yet implemented" }
        "3" { Show-AvailableAgents }
        "4" { Log-Info "Exiting..."; exit 0 }
        default { Log-Error "Invalid choice" }
    }
}

function Show-AvailableAgents {
    Write-Host "Available AI agents:" -ForegroundColor $Cyan
    Write-Host ""
    Write-Host "1. Claude CLI - Anthropic's Claude AI assistant"
    Write-Host "2. Gemini CLI - Google's Gemini AI assistant"
    Write-Host "3. Codex CLI - OpenAI's Codex AI assistant"
    Write-Host "4. Perplexity CLI - Perplexity AI research assistant"
    Write-Host "5. Aider CLI - AI pair programming tool"
    Write-Host "6. AI Shell - Terminal AI assistant"
    Write-Host ""
}

function Show-Help {
    Write-Host "AI Agent CLI Tools Setup for Windows" -ForegroundColor $Cyan
    Write-Host ""
    Write-Host "Usage: .\setup-workstation.ps1 [options]"
    Write-Host ""
    Write-Host "Options:"
    Write-Host "  -All     Install all AI agents"
    Write-Host "  -Select  Interactive agent selection"
    Write-Host "  -List    Show available agents"
    Write-Host "  -Help    Show this help message"
    Write-Host ""
}

# Run main function
Main