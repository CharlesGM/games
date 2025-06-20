#!/bin/bash

# Navigate to the directory where the script is located
cd "$(dirname "$0")"

# Activate the virtual environment if it exists
if [ -d "venv" ]; then
  source "venv/bin/activate"
fi

# Run the game
python3 tetris.py 