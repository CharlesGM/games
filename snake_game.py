#!/usr/bin/env python3
"""
Snake Game - Classic arcade game implementation
Use arrow keys to control the snake and eat food to grow!
"""

import pygame
import random
import sys

# Initialize Pygame
pygame.init()

# Game constants
WINDOW_WIDTH = 1200
WINDOW_HEIGHT = 700
GRID_SIZE = 20
GRID_WIDTH = WINDOW_WIDTH // GRID_SIZE
GRID_HEIGHT = WINDOW_HEIGHT // GRID_SIZE

# Colors (RGB)
BLACK = (0, 0, 0)
WHITE = (255, 255, 255)
GREEN = (0, 255, 0)
RED = (255, 0, 0)
BLUE = (0, 0, 255)
DARK_GREEN = (0, 150, 0)

# Directions
UP = (0, -1)
DOWN = (0, 1)
LEFT = (-1, 0)
RIGHT = (1, 0)

class Snake:
    def __init__(self):
        self.positions = [(GRID_WIDTH // 2, GRID_HEIGHT // 2)]
        self.direction = RIGHT
        self.grow = False
    
    def move(self):
        head_x, head_y = self.positions[0]
        new_head = (head_x + self.direction[0], head_y + self.direction[1])
        
        # Check wall collision
        if (new_head[0] < 0 or new_head[0] >= GRID_WIDTH or 
            new_head[1] < 0 or new_head[1] >= GRID_HEIGHT):
            return False
        
        # Check self collision
        if new_head in self.positions:
            return False
        
        self.positions.insert(0, new_head)
        
        if not self.grow:
            self.positions.pop()
        else:
            self.grow = False
        
        return True
    
    def change_direction(self, new_direction):
        # Prevent moving in opposite direction
        if (self.direction[0] * -1, self.direction[1] * -1) != new_direction:
            self.direction = new_direction
    
    def eat_food(self):
        self.grow = True
    
    def draw(self, screen):
        for i, pos in enumerate(self.positions):
            x, y = pos[0] * GRID_SIZE, pos[1] * GRID_SIZE
            color = DARK_GREEN if i == 0 else GREEN  # Head is darker
            pygame.draw.rect(screen, color, (x, y, GRID_SIZE, GRID_SIZE))
            pygame.draw.rect(screen, BLACK, (x, y, GRID_SIZE, GRID_SIZE), 1)

class Food:
    def __init__(self):
        self.position = self.generate_position()
    
    def generate_position(self):
        return (random.randint(0, GRID_WIDTH - 1), 
                random.randint(0, GRID_HEIGHT - 1))
    
    def respawn(self, snake_positions):
        while True:
            self.position = self.generate_position()
            if self.position not in snake_positions:
                break
    
    def draw(self, screen):
        x, y = self.position[0] * GRID_SIZE, self.position[1] * GRID_SIZE
        pygame.draw.rect(screen, RED, (x, y, GRID_SIZE, GRID_SIZE))

class Game:
    def __init__(self):
        self.screen = pygame.display.set_mode((WINDOW_WIDTH, WINDOW_HEIGHT))
        pygame.display.set_caption("Snake Game")
        self.clock = pygame.time.Clock()
        self.font = pygame.font.Font(None, 36)
        self.reset_game()
    
    def reset_game(self):
        self.snake = Snake()
        self.food = Food()
        self.score = 0
        self.game_over = False
        self.paused = False
    
    def handle_events(self):
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                return False
            
            elif event.type == pygame.KEYDOWN:
                if self.game_over:
                    if event.key == pygame.K_SPACE:
                        self.reset_game()
                    elif event.key == pygame.K_q:
                        return False
                
                elif event.key == pygame.K_p:
                    self.paused = not self.paused
                
                elif not self.paused:
                    if event.key == pygame.K_UP:
                        self.snake.change_direction(UP)
                    elif event.key == pygame.K_DOWN:
                        self.snake.change_direction(DOWN)
                    elif event.key == pygame.K_LEFT:
                        self.snake.change_direction(LEFT)
                    elif event.key == pygame.K_RIGHT:
                        self.snake.change_direction(RIGHT)
        
        return True
    
    def update(self):
        if self.game_over or self.paused:
            return
        
        # Move snake
        if not self.snake.move():
            self.game_over = True
            return
        
        # Check food collision
        if self.snake.positions[0] == self.food.position:
            self.snake.eat_food()
            self.food.respawn(self.snake.positions)
            self.score += 10
    
    def draw(self):
        self.screen.fill(BLACK)
        
        if not self.game_over:
            self.snake.draw(self.screen)
            self.food.draw(self.screen)
        
        # Draw score
        score_text = self.font.render(f"Score: {self.score}", True, WHITE)
        self.screen.blit(score_text, (10, 10))
        
        # Draw game over screen
        if self.game_over:
            game_over_text = self.font.render("GAME OVER!", True, WHITE)
            restart_text = self.font.render("Press SPACE to restart or Q to quit", True, WHITE)
            
            game_over_rect = game_over_text.get_rect(center=(WINDOW_WIDTH//2, WINDOW_HEIGHT//2 - 30))
            restart_rect = restart_text.get_rect(center=(WINDOW_WIDTH//2, WINDOW_HEIGHT//2 + 10))
            
            self.screen.blit(game_over_text, game_over_rect)
            self.screen.blit(restart_text, restart_rect)
        
        # Draw pause screen
        elif self.paused:
            pause_text = self.font.render("PAUSED - Press P to continue", True, WHITE)
            pause_rect = pause_text.get_rect(center=(WINDOW_WIDTH//2, WINDOW_HEIGHT//2))
            self.screen.blit(pause_text, pause_rect)
        
        pygame.display.flip()
    
    def run(self):
        running = True
        while running:
            running = self.handle_events()
            self.update()
            self.draw()
            self.clock.tick(10)  # 10 FPS for classic snake feel
        
        pygame.quit()
        sys.exit()

if __name__ == "__main__":
    print("Starting Snake Game...")
    print("Use arrow keys to control the snake!")
    game = Game()
    game.run()
