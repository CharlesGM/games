@echo off
REM Script to set up and run the Snake game with virtual environment on Windows

echo 🐍 Snake Game Setup ^& Launch Script
echo ==================================

REM Navigate to the game directory
cd /d "%~dp0"

REM Function to install Python on Windows
:install_python
echo 🔧 Python not found. Attempting to install...
echo 📥 Downloading Python installer...

REM Create temp directory for download
if not exist "%TEMP%\snake_game_setup" mkdir "%TEMP%\snake_game_setup"

REM Download Python installer using PowerShell
powershell -Command "& {[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri 'https://www.python.org/ftp/python/3.11.9/python-3.11.9-amd64.exe' -OutFile '%TEMP%\snake_game_setup\python_installer.exe'}"

if not exist "%TEMP%\snake_game_setup\python_installer.exe" (
    echo ❌ Failed to download Python installer.
    echo Please download Python manually from https://python.org
    pause
    exit /b 1
)

echo 🚀 Installing Python... This may take a few minutes.
echo Please follow the installer prompts and make sure to check "Add Python to PATH"

REM Run the installer with recommended options
"%TEMP%\snake_game_setup\python_installer.exe" /quiet InstallAllUsers=1 PrependPath=1 Include_test=0

REM Wait for installation to complete
timeout /t 10 /nobreak >nul

REM Clean up
del "%TEMP%\snake_game_setup\python_installer.exe" >nul 2>&1
rmdir "%TEMP%\snake_game_setup" >nul 2>&1

echo ✅ Python installation completed!
echo 🔄 Please restart your command prompt or terminal for PATH changes to take effect.
echo Then run this script again.
pause
exit /b 0

REM Check if Python is installed (try python first, then py launcher)
python --version >nul 2>&1
if errorlevel 1 (
    py --version >nul 2>&1
    if errorlevel 1 (
        REM Try python3 command
        python3 --version >nul 2>&1
        if errorlevel 1 (
            goto install_python
        ) else (
            set PYTHON_CMD=python3
        )
    ) else (
        set PYTHON_CMD=py
    )
) else (
    set PYTHON_CMD=python
)

echo ✅ Python is available: 
%PYTHON_CMD% --version

REM Create virtual environment if it doesn't exist
if not exist "snake_game_env" (
    echo 📦 Creating Python virtual environment...
    %PYTHON_CMD% -m venv snake_game_env
    echo ✅ Virtual environment created successfully!
) else (
    echo ✅ Virtual environment already exists.
)

REM Activate virtual environment
echo 🔧 Activating virtual environment...
call snake_game_env\Scripts\activate.bat

REM Check if pygame is installed, install if not
python -c "import pygame" >nul 2>&1
if errorlevel 1 (
    echo 📥 Installing pygame...
    pip install pygame
    echo ✅ Pygame installed successfully!
) else (
    echo ✅ Pygame is already installed.
)

REM Check if snake_game.py exists
if exist "snake_game.py" (
    echo 🚀 Starting Snake Game...
    python snake_game.py
) else (
    echo ❌ Error: snake_game.py not found. Please ensure the game file exists.
    pause
    exit /b 1
)

pause
