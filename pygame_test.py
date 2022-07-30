import pygame
import random

FPS = 60

#顏色
white = (255,255,255)
green = (0,255,0)
red = (255,0,0)
#大小
width = 500
height = 600
#rock
rock_width = 20
rock_height = 20
#初始化
pygame.init()
screen = pygame.display.set_mode((width,height))
pygame.display.set_caption("test1")
clock = pygame.time.Clock()

#設定相關物件
class Player(pygame.sprite.Sprite):
    def __init__(self):
        pygame.sprite.Sprite.__init__(self) 
        self.image = pygame.Surface((40,50))
        self.image.fill(green)
        self.rect = self.image.get_rect()
        self.rect.x = 200
        self.rect.y = 200

    def update(self):
        key_pressed = pygame.key.get_pressed()
        if key_pressed[pygame.K_a]:
            self.rect.x -= 2
        if key_pressed[pygame.K_d]:
            self.rect.x += 2
        if key_pressed[pygame.K_w]:
            self.rect.y -= 2
        if key_pressed[pygame.K_s]:
            self.rect.y += 2     

        print(self.rect.x,",",self.rect.y)   

        if self.rect.x > width:
            self.rect.x = width
        if self.rect.x < 0:
            self.rect.x = 0
        if self.rect.y > height-50:
            self.rect.y = height-50 
        if self.rect.y < 0:
            self.rect.y = 0

class Rock(pygame.sprite.Sprite):
    def __init__(self):
        pygame.sprite.Sprite.__init__(self) 
        self.image = pygame.Surface((rock_width,rock_height))
        self.image.fill(red)
        self.rect = self.image.get_rect()
        self.rect.x = random.randrange(0,width-self.rect.width)
        self.rect.y = random.randrange(-100,-40)
        self.speedy = random.randrange(3,7)
        self.speedx = random.randrange(-2,2)

    def update(self):
        self.rect.y +=self.speedy
        self.rect.x +=self.speedx
        if self.rect.top > height:
            self.rect.x = random.randrange(0,width-self.rect.width)
            self.rect.y = random.randrange(-100,-40)
            self.speedy = random.randrange(3,7)
            self.speedx = random.randrange(-2,2)
        if self.rect.left > width + rock_width  or self.rect.right - rock_width < 0:
            self.speedx = -self.speedx

all_sprites = pygame.sprite.Group()
player = Player()       
all_sprites.add(player)
for i in range(8):
    rock = Rock()
    all_sprites.add(rock)

running = True

while running:
    clock.tick(FPS)
     #輸入
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            running = False
     #更新
    all_sprites.update()
     #顯示
    screen.fill(white)
    all_sprites.draw(screen)
    pygame.display.update()
    
pygame.quit()
