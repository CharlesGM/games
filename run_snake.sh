#!/bin/bash
# Script to set up and run the Snake game with virtual environment

set -e  # Exit on any error

# Navigate to the game directory
cd "$(dirname "$0")"

echo "🐍 Snake Game Setup & Launch Script"
echo "=================================="

# Check if Python 3 is installed
if ! command -v python3 &> /dev/null; then
    echo "❌ Error: Python 3 is not installed. Please install Python 3 and try again."
    exit 1
fi

# Create virtual environment if it doesn't exist
if [ ! -d "snake_game_env" ]; then
    echo "📦 Creating Python virtual environment..."
    python3 -m venv snake_game_env
    echo "✅ Virtual environment created successfully!"
else
    echo "✅ Virtual environment already exists."
fi

# Activate virtual environment
echo "🔧 Activating virtual environment..."
source snake_game_env/bin/activate

# Check if pygame is installed, install if not
if ! python -c "import pygame" &> /dev/null; then
    echo "📥 Installing pygame..."
    pip install pygame
    echo "✅ Pygame installed successfully!"
else
    echo "✅ Pygame is already installed."
fi

# Check if snake_game.py exists in the expected location
if [ -f "snakes/snake_game.py" ]; then
    echo "🚀 Starting Snake Game..."
    cd snakes && python snake_game.py
elif [ -f "snake_game.py" ]; then
    echo "🚀 Starting Snake Game..."
    python snake_game.py
else
    echo "❌ Error: snake_game.py not found. Please ensure the game file exists."
    exit 1
fi
