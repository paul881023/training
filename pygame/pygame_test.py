import pygame
import random
import os
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
#圖片
backgound_jpg = pygame.image.load(os.path.join("pygame","jpg","back.jpg")).convert()
#rock_jpg = pygame.image.load(os.path.join("pygame","jpg","rock_2.webp")).convert()
airplane_jpg = pygame.image.load(os.path.join("pygame","jpg","airplane.jpg")).convert()
rock_jpgs  = []
pic_num = [2,3,4]
for i in pic_num:
    rock_jpgs.append(pygame.image.load(os.path.join("pygame","jpg",f"rock_{i}.png")).convert())
font_name = pygame.font.match_font('arial')

def draw_text(surf,text,size,x,y):
    font = pygame.font.Font(font_name, size)
    text_surface = font.render(text, True, white)
    text_rect = text_surface.get_rect()
    text_rect.centerx = x
    text_rect.top = y
    surf.blit(text_surface,text_rect)

#設定相關物件
class Player(pygame.sprite.Sprite):
    def __init__(self):
        pygame.sprite.Sprite.__init__(self) 
        self.image = pygame.transform.scale(airplane_jpg,(70,50))
        self.image.set_colorkey(black) 
        self.rect = self.image.get_rect()
        self.radius = 20 
        #pygame.draw.circle(self.image,red,self.rect.center,self.radius)
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
        self.image_ori = pygame.transform.scale(random.choice(rock_jpgs),(50,50))
        self.image_ori.set_colorkey(black)
        self.image = self.image_ori.copy()
        self.rect = self.image.get_rect()
        self.radius = int(self.rect.width * 0.85 / 2)
        #pygame.draw.circle(self.image,red,self.rect.center,self.radius)
        self.rect.x = random.randrange(0,width-self.rect.width)
        self.rect.y = random.randrange(-180,-100)
        self.speedy = random.randrange(3,7)
        self.speedx = random.randrange(-2,2)
        self.total_degree = 0
        self.rot_degree = random.randrange(-5,5) 

    def rotate(self):
        self.total_degree += self.rot_degree
        self.total_degree = self.total_degree % 360
        self.image = pygame.transform.rotate(self.image_ori,self.total_degree)
        center = self.rect.center
        self.rect = self.image  .get_rect()
        self.rect.center = center
 
    def update(self):
        self.rotate()
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

score = 0

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
        score += hit.radius
        rock = Rock()
        all_sprites.add(rock)
        rocks.add(rock)
    hits = pygame.sprite.spritecollide(player,rocks,False, pygame.sprite.collide_circle)
    if hits:
        running = False
     #顯示
    screen.fill(black)
    screen.blit(backgound_jpg,(0,0))
    all_sprites.draw(screen)
    draw_text(screen, str(score), 18 , width / 2, 10)
    pygame.display.update()
    
pygame.quit()
