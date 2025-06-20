# PowerShell script to set up and run the Snake game with automatic Python installation
# Run this script with: powershell -ExecutionPolicy Bypass -File run_snake.ps1

Write-Host "🐍 Snake Game Setup & Launch Script (PowerShell)" -ForegroundColor Green
Write-Host "=================================================" -ForegroundColor Green

# Navigate to the script directory
Set-Location -Path $PSScriptRoot

# Function to install Python using winget (Windows Package Manager)
function Install-Python {
    Write-Host "🔧 Python not found. Attempting to install..." -ForegroundColor Yellow
    
    # Check if winget is available (Windows 10 1809+ and Windows 11)
    if (Get-Command winget -ErrorAction SilentlyContinue) {
        Write-Host "📦 Using Windows Package Manager (winget) to install Python..." -ForegroundColor Cyan
        try {
            winget install Python.Python.3.11 --accept-package-agreements --accept-source-agreements
            Write-Host "✅ Python installation completed via winget!" -ForegroundColor Green
            
            # Refresh PATH
            $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
            
            return $true
        }
        catch {
            Write-Host "❌ winget installation failed. Trying alternative method..." -ForegroundColor Red
        }
    }
    
    # Alternative: Download and install Python directly
    Write-Host "📥 Downloading Python installer..." -ForegroundColor Cyan
    
    $tempDir = "$env:TEMP\snake_game_setup"
    if (!(Test-Path $tempDir)) {
        New-Item -ItemType Directory -Path $tempDir -Force | Out-Null
    }
    
    $pythonUrl = "https://www.python.org/ftp/python/3.11.9/python-3.11.9-amd64.exe"
    $installerPath = "$tempDir\python_installer.exe"
    
    try {
        # Enable TLS 1.2
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        
        # Download Python installer
        Invoke-WebRequest -Uri $pythonUrl -OutFile $installerPath -UseBasicParsing
        
        Write-Host "🚀 Installing Python... This may take a few minutes." -ForegroundColor Cyan
        Write-Host "The installer will run silently with recommended settings." -ForegroundColor Yellow
        
        # Install Python with recommended options
        Start-Process -FilePath $installerPath -ArgumentList "/quiet", "InstallAllUsers=1", "PrependPath=1", "Include_test=0" -Wait
        
        # Clean up
        Remove-Item $installerPath -Force -ErrorAction SilentlyContinue
        Remove-Item $tempDir -Force -Recurse -ErrorAction SilentlyContinue
        
        # Refresh PATH
        $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
        
        Write-Host "✅ Python installation completed!" -ForegroundColor Green
        return $true
    }
    catch {
        Write-Host "❌ Failed to download or install Python: $($_.Exception.Message)" -ForegroundColor Red
        Write-Host "Please download Python manually from https://python.org" -ForegroundColor Yellow
        return $false
    }
}

# Function to find Python command
function Get-PythonCommand {
    $pythonCommands = @("python", "py", "python3")
    
    foreach ($cmd in $pythonCommands) {
        try {
            $version = & $cmd --version 2>$null
            if ($LASTEXITCODE -eq 0) {
                Write-Host "✅ Python is available: $version" -ForegroundColor Green
                return $cmd
            }
        }
        catch {
            # Continue to next command
        }
    }
    
    return $null
}

# Check if Python is installed
$pythonCmd = Get-PythonCommand

if (-not $pythonCmd) {
    $installResult = Install-Python
    
    if ($installResult) {
        # Try to find Python again after installation
        Start-Sleep -Seconds 3
        $pythonCmd = Get-PythonCommand
        
        if (-not $pythonCmd) {
            Write-Host "❌ Python installation completed but Python command not found." -ForegroundColor Red
            Write-Host "Please restart your PowerShell session and try again." -ForegroundColor Yellow
            Read-Host "Press Enter to exit"
            exit 1
        }
    } else {
        Write-Host "❌ Failed to install Python automatically." -ForegroundColor Red
        Read-Host "Press Enter to exit"
        exit 1
    }
}

# Create virtual environment if it doesn't exist
if (!(Test-Path "snake_game_env")) {
    Write-Host "📦 Creating Python virtual environment..." -ForegroundColor Cyan
    & $pythonCmd -m venv snake_game_env
    Write-Host "✅ Virtual environment created successfully!" -ForegroundColor Green
} else {
    Write-Host "✅ Virtual environment already exists." -ForegroundColor Green
}

# Activate virtual environment
Write-Host "🔧 Activating virtual environment..." -ForegroundColor Cyan
& ".\snake_game_env\Scripts\Activate.ps1"

# Check if pygame is installed in the virtual environment, install if not
try {
    python -c "import pygame" 2>$null
    if ($LASTEXITCODE -ne 0) {
        throw "pygame not found"
    }
    Write-Host "✅ Pygame is already installed in virtual environment." -ForegroundColor Green
}
catch {
    Write-Host "📥 Installing pygame in virtual environment..." -ForegroundColor Cyan
    pip install pygame
    Write-Host "✅ Pygame installed successfully!" -ForegroundColor Green
}

# Check if snake_game.py exists and run the game
if (Test-Path "snake_game.py") {
    Write-Host "🚀 Starting Snake Game..." -ForegroundColor Green
    # Ensure we're using the virtual environment's Python
    & ".\snake_game_env\Scripts\Activate.ps1"
    python snake_game.py
} else {
    Write-Host "❌ Error: snake_game.py not found. Please ensure the game file exists." -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit 1
}

Read-Host "Press Enter to exit"
