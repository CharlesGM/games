#!/bin/bash
# Script to set up and run the Snake game with virtual environment

set -e  # Exit on any error

# Navigate to the game directory
cd "$(dirname "$0")"

echo "🐍 Snake Game Setup & Launch Script"
echo "=================================="

# Function to install Python on different systems
install_python() {
    echo "🔧 Python 3 not found. Attempting to install..."
    
    # Detect the operating system
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        echo "📱 Detected macOS. Installing Python 3..."
        if command -v brew &> /dev/null; then
            echo "🍺 Using Homebrew to install Python 3..."
            brew install python3
        else
            echo "❌ Homebrew not found. Please install Homebrew first or download Python from https://python.org"
            echo "To install Homebrew, run:"
            echo '/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'
            exit 1
        fi
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        # Linux
        echo "🐧 Detected Linux. Installing Python 3..."
        if command -v apt-get &> /dev/null; then
            # Debian/Ubuntu
            echo "📦 Using apt-get to install Python 3..."
            sudo apt-get update
            sudo apt-get install -y python3 python3-venv python3-pip
        elif command -v yum &> /dev/null; then
            # RHEL/CentOS/Fedora (older)
            echo "📦 Using yum to install Python 3..."
            sudo yum install -y python3 python3-venv python3-pip
        elif command -v dnf &> /dev/null; then
            # Fedora (newer)
            echo "📦 Using dnf to install Python 3..."
            sudo dnf install -y python3 python3-venv python3-pip
        elif command -v pacman &> /dev/null; then
            # Arch Linux
            echo "📦 Using pacman to install Python 3..."
            sudo pacman -S python python-pip
        else
            echo "❌ Unsupported Linux distribution. Please install Python 3 manually from https://python.org"
            exit 1
        fi
    else
        echo "❌ Unsupported operating system: $OSTYPE"
        echo "Please install Python 3 manually from https://python.org"
        exit 1
    fi
    
    echo "✅ Python 3 installation completed!"
}

# Check if Python 3 is installed
if ! command -v python3 &> /dev/null; then
    # Try to install Python automatically
    install_python
    
    # Verify installation
    if ! command -v python3 &> /dev/null; then
        echo "❌ Error: Python 3 installation failed. Please install Python 3 manually and try again."
        echo "Download from: https://python.org"
        exit 1
    fi
fi

echo "✅ Python 3 is available: $(python3 --version)"

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

# Check if snake_game.py exists
if [ -f "snake_game.py" ]; then
    echo "🚀 Starting Snake Game..."
    # Ensure we're using the virtual environment's Python
    source snake_game_env/bin/activate
    python snake_game.py
else
    echo "❌ Error: snake_game.py not found. Please ensure the game file exists."
    exit 1
fi
