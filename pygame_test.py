import pygame
import random

FPS = 60

#顏色
white = (255,255,255)
green = (0,255,0)
red = (255,0,0)
yellow = (255,255,0)
black = (0,0,0)
#大小
width = 500
height = 600
#rock
rock_width = 20
rock_height = 20
#bullet
bullet_width = 10
bullet_height = 10   
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
        self.rect.centerx = width / 2
        self.rect.y = height + 10

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

        if self.rect.centerx > width:
            self.rect.centerx = width
        if self.rect.centerx < 0:
            self.rect.centerx = 0
        if self.rect.y > height-50:
            self.rect.y = height-50 
        if self.rect.y < 0:
            self.rect.y = 0

    def shoot(self):
        bullet = Bullet(self.rect.centerx,self.rect.y)
        all_sprites.add(bullet)
        bullets.add(bullet)
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

class Bullet(pygame.sprite.Sprite):
    def __init__(self,x,y):
        pygame.sprite.Sprite.__init__(self) 
        self.image = pygame.Surface((bullet_width,bullet_height))
        self.image.fill(yellow)
        self.rect = self.image.get_rect()
        self.rect.centerx = x
        self.rect.bottom = y
        self.speedy = -10

    def update(self):
        self.rect.y += self.speedy
        if self.rect.bottom < 0:
            self.kill()

all_sprites = pygame.sprite.Group()
rocks = pygame.sprite.Group()
bullets = pygame.sprite.Group()
player = Player()       
all_sprites.add(player)
for i in range(8):
    rock = Rock()
    all_sprites.add(rock)
    rocks.add(rock)
running = True

while running:
    clock.tick(FPS)
     #輸入
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            running = False
        elif event.type == pygame.KEYDOWN:
            if event.key == pygame.K_SPACE:
                player.shoot()
     #更新
    all_sprites.update()
    hits = pygame.sprite.groupcollide(rocks, bullets, True, True)
    for hit in hits: 
        rock = Rock()
        all_sprites.add(rock)
        rocks.add(rock)
    hits = pygame.sprite.spritecollide(player,rocks,False,False)
    if hits:
        running = False
     #顯示
    screen.fill(black)
    all_sprites.draw(screen)
    pygame.display.update()
    
pygame.quit()
