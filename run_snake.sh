#!/bin/bash
# Script to run the Snake game with the virtual environment

# Navigate to the game directory
cd "$(dirname "$0")"

# Activate virtual environment and run the game
source snake_game_env/bin/activate && cd snakes && python snake_game.py
