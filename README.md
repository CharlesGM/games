# Snake Game

A classic Snake game implementation in Python using Pygame. Control the snake to eat food and grow longer while avoiding walls and your own tail!

I developed this game using AWS Q CLI and python.

## Prerequisites

You need Python 3 and Pygame installed on your system.

### Installing Pygame

```bash
pip install pygame
```

Or if you're using Python 3 specifically:
```bash
pip3 install pygame
```

## How to Run

1. Navigate to the game directory:
   ```bash
   cd snakes/
   ```

2. Run the game:
   ```bash
   python snake_game.py
   ```
   
   Or:
   ```bash
   python3 snake_game.py
   ```

## How to Play

### Objective
- Control the snake to eat red food squares
- Each food eaten increases your score by 10 points
- The snake grows longer each time it eats food
- Avoid hitting the walls or the snake's own body

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

## Troubleshooting

### "No module named 'pygame'" error
Install Pygame using pip:
```bash
pip install pygame
```

### Game runs too fast/slow
The game speed is set to 10 FPS. You can modify the speed by changing the number in this line in `snake_game.py`:
```python
self.clock.tick(10)  # Change 10 to higher number for faster, lower for slower
```

### Permission denied error
Make sure the file is executable:
```bash
chmod +x snake_game.py
```

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

Enjoy playing Snake! Try to beat your high score!
