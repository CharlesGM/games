@echo off
REM Script to set up and run the Snake game with virtual environment on Windows

echo 🐍 Snake Game Setup ^& Launch Script
echo ==================================

REM Navigate to the game directory
cd /d "%~dp0"

REM Check if Python is installed
python --version >nul 2>&1
if errorlevel 1 (
    echo ❌ Error: Python is not installed. Please install Python and try again.
    pause
    exit /b 1
)

REM Create virtual environment if it doesn't exist
if not exist "snake_game_env" (
    echo 📦 Creating Python virtual environment...
    python -m venv snake_game_env
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
