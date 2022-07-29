import pygame

FPS = 60

#顏色
white = (255,255,255)
green = (0,255,0)
#大小
width = 500
height = 600

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
        self.rect.x += 2
        if self.rect.left > width:
            self.rect.right = 0

all_sprites = pygame.sprite.Group()
player = Player()       
all_sprites.add(player)

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
