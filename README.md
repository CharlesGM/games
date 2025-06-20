# It's a Python written snakes game 😉 😜 <pun-tastic>

A classic Snake game implementation in Python using Pygame. Control the snake to eat food and grow longer while avoiding walls and your own tail! This game is absolutely *hiss-terical* and will have you *python-ing* for hours! 🐍

I developed this game using AWS Q CLI and Python - it's a real *scale-able* solution! 😄

## Quick Start <slither-right-in>

### Option 1: Automated Setup (Recommended) <no-hassssle>
The easiest way to get started is using the provided setup script - it's *fang-tastic*:

**For macOS/Linux:**
```bash
# Clone the repository
git clone <your-repo-url>
cd <repo-name>

# Make the script executable (if needed)
chmod +x run_snake.sh

# Run the setup and launch script (handles everything automatically)
./run_snake.sh
```

**For Windows:**
```cmd
# Clone the repository
git clone <your-repo-url>
cd <repo-name>

# Run the Windows batch script
run_snake.bat
```

The script will automatically:
- Check for Python installation (*no need to be a charmer* 🐍)
- Create a virtual environment (*your own snake pit*)
- Install pygame (*get ready to rattle and roll*)
- Launch the game (*time to shed some stress*)

### Option 2: Manual Setup <for-the-adventurous-ssssoul>

#### Prerequisites
- Python 3.6 or higher
- Git (for cloning)

#### Step-by-Step Installation

1. **Clone the repository:**
   ```bash
   git clone <your-repo-url>
   cd <repo-name>
   ```

2. **Create a virtual environment:**
   ```bash
   python3 -m venv snake_game_env
   ```

3. **Activate the virtual environment:**
   ```bash
   # On macOS/Linux:
   source snake_game_env/bin/activate
   
   # On Windows:
   snake_game_env\Scripts\activate
   ```

4. **Install pygame:**
   ```bash
   pip install pygame
   # Or use the requirements file:
   pip install -r requirements.txt
   ```

5. **Run the game:**
   ```bash
   python snake_game.py
   ```

## How to Play <time-to-get-your-game-on>

### Objective <what's-the-point>
- Control the snake to eat red food squares (*nom nom nom*)
- Each food eaten increases your score by 10 points (*ssss-core!*)
- The snake grows longer each time it eats food (*growing like a weed... or snake*)
- Avoid hitting the walls or the snake's own body (*don't be a knot-head*)

### Controls
- **Arrow Keys**: Move the snake (Up, Down, Left, Right)
- **P**: Pause/Unpause the game
- **Space**: Restart the game (when game over)
- **Q**: Quit the game (when game over)
- **Close Window**: Exit the game

### Game Rules
1. The snake moves continuously in the direction you choose
2. You cannot move directly backwards into yourself
3. The game ends if you hit a wall or your own body
4. Food appears randomly on the grid after being eaten
5. Your score increases by 10 points for each food eaten

### Tips for High Scores
- Plan your path to avoid trapping yourself
- Use the edges of the screen strategically
- Don't rush - the snake moves at a steady pace
- Try to create open spaces as you grow longer

## Game Features

- Classic snake gameplay mechanics
- Score tracking
- Pause functionality
- Game over screen with restart option
- Smooth grid-based movement
- Visual distinction between snake head and body
- Collision detection for walls and self

## Project Structure

```
snake-game/
├── README.md              # This file
├── run_snake.sh          # Automated setup and launch script (macOS/Linux)
├── run_snake.bat         # Automated setup and launch script (Windows)
├── requirements.txt      # Python dependencies
├── snake_game.py         # Main game file
└── snake_game_env/       # Virtual environment (created automatically)
```

## Troubleshooting

### Common Issues

#### "Permission denied" when running ./run_snake.sh
Make the script executable:
```bash
chmod +x run_snake.sh
```

#### "No module named 'pygame'" error
This usually means pygame isn't installed in your current environment:
```bash
# Activate virtual environment first
source snake_game_env/bin/activate
# Then install pygame
pip install pygame
```

#### "python3: command not found"
Install Python 3:
- **macOS**: `brew install python3` or download from [python.org](https://python.org)
- **Ubuntu/Debian**: `sudo apt update && sudo apt install python3 python3-venv`
- **Windows**: Download from [python.org](https://python.org)

#### Game runs too fast/slow
Modify the game speed by changing this line in `snake_game.py`:
```python
self.clock.tick(10)  # Change 10 to higher number for faster, lower for slower
```

#### Virtual environment issues
Delete the virtual environment and recreate it:
```bash
rm -rf snake_game_env
python3 -m venv snake_game_env
source snake_game_env/bin/activate
pip install pygame
```

## Development

### Running in Development Mode
If you want to modify the game:

1. Activate the virtual environment:
   ```bash
   source snake_game_env/bin/activate
   ```

2. Make your changes to `snake_game.py`

3. Run the game:
   ```bash
   python snake_game.py
   ```

### Adding New Features
The game is structured to make it easy to add new features:
- Game logic is in the main game loop
- Display functions are separated for easy modification
- Game state is managed through class variables

## Game Controls Summary

| Key | Action |
|-----|--------|
| ↑ | Move Up |
| ↓ | Move Down |
| ← | Move Left |
| → | Move Right |
| P | Pause/Unpause |
| Space | Restart (Game Over) |
| Q | Quit (Game Over) |

## Contributing

Feel free to fork this repository and submit pull requests for improvements!

## License

This project is open source. Feel free to use and modify as needed.

---

Enjoy playing Snake! Try to beat your high score! 🐍🎮
