PImage bgImg, groundhogIdle, lifeImg, soilImg, soldierImg,
cabbage,groundhogDown, groundhogLeft, groundhogRight, startHover,
startNormal, title, gameOver, restart, restartHover;

final int GAME_START = 0;
final int GAME_RUN = 1;
final int GAME_OVER = 2;
final int GAME_WIN = 3;
int gameState = GAME_START;

final int STAY = 0;
final int GO_RIGHT = 1;
final int GO_LEFT = 2;
final int GO_DOWN = 3;
int hogState = STAY;

final int BUTTON_TOP = 360;
final int BUTTON_BOTTOM = 420;
final int BUTTON_LEFT = 248;
final int BUTTON_RIGHT = 392;
final int START_X = 248;
final int START_Y = 360;

int speedS;
float soldierX;
float soldierY;
int a;
float cabbageX;
float cabbageY;
int b;
int c;
float hogX;
float hogY;
float hogSpeed;
int life2X=80;
int life1X=10;
int life3X=-100;
int frame=15;

boolean right= false;
boolean down= false;
boolean left= false;

void setup() {
  size(640, 480, P2D);

// load the image of background, groundhog, life, and soil
  bgImg=loadImage("img/bg.jpg");
  groundhogIdle=loadImage("img/groundhogIdle.png");
  lifeImg=loadImage("img/life.png");
  soilImg=loadImage("img/soil.png");
  soldierImg=loadImage("img/soldier.png");
  cabbage=loadImage("img/cabbage.png");
  groundhogDown=loadImage("img/groundhogDown.png");
  groundhogLeft=loadImage("img/groundhogLeft.png");
  groundhogRight=loadImage("img/groundhogRight.png");
  startHover=loadImage("img/startHovered.png");
  startNormal=loadImage("img/startNormal.png");  
  title=loadImage("img/title.jpg");
  gameOver=loadImage("img/gameover.jpg");
  restartHover=loadImage("img/restartHovered.png");
  restart=loadImage("img/restartNormal.png");
  
//set soldier's speed
  speedS=2;
  
//make soldier appear at a random level
  a=floor(random(2,5));
  soldierY=80*a;
  soldierX=-80;
  
//cabbage  
  b=floor(random(2,6));
  cabbageY=80*b;
  c=floor(random(0,8));
  cabbageX=80*c;

//groundhog
  hogX=320;
  hogY=80;
  hogSpeed=80.0;  
}

void draw() {

   switch(gameState){
    case GAME_START:
      image(title,0,0);
      if(mouseX > BUTTON_LEFT && mouseX < BUTTON_RIGHT
      && mouseY > BUTTON_TOP && mouseY < BUTTON_BOTTOM){
        image(startHover, START_X, START_Y);
        if(mousePressed){
          gameState = GAME_RUN;
        }
      }else{
        image(startNormal, START_X, START_Y);
      }
    break;

case GAME_RUN:  
//set the position of the images
  image(bgImg,0,0);
  image(lifeImg,life1X,10);
  image(lifeImg,life2X,10);
  image(lifeImg,life3X,10);
  image(groundhogIdle,hogX,hogY);

//sun
  stroke(255,255,0);
  strokeWeight(5);
  ellipse(590,50,120,120);
  fill(253,184,19);
  
//lawn
  stroke(124,204,25);
  strokeWeight(15);
  line(0,160,640,160);
 
//soil
  image(soilImg,0,160);

//groundhog move  
switch(hogState){
  case GO_RIGHT:
  if(frame<15){
    image(groundhogRight,hogX,hogY);
    hogX+=hogSpeed/15.0;
    frame++;
    if(hogX>560){hogX=560;}}
  if(frame==15){image(groundhogIdle,round(hogX),round(hogY));}
  break; 
  
  case GO_LEFT:
  if(frame<15){
    image(groundhogLeft,hogX,hogY); 
    hogX-=hogSpeed/15.0;
    frame++;
    if(hogX<=0){hogX=0;}}
  if(frame==15){image(groundhogIdle,round(hogX),round(hogY));}
  break;
      
  case GO_DOWN:    
  if(frame<15){
    image(groundhogDown,hogX,hogY);
    hogY+=hogSpeed/15.0;
    frame++;
    if(hogY>=400){hogY=400;}}
  if(frame==15){image(groundhogIdle,round(hogX),round(hogY));}
  break;
  
  case STAY:
  frame=15;
  image(groundhogIdle,hogX,hogY);
  break;
}


//+life
if( life2X>0 && hogY<cabbageY+80 && hogY+80>cabbageY &&
    hogX<cabbageX+80 && hogX+80>cabbageX){
    life3X=150;
    cabbageX=-100;
    }

if( life2X<0 && hogY<cabbageY+80 && hogY+80>cabbageY 
   && hogX<cabbageX+80 && hogX+80>cabbageX){
    life2X=80;
    cabbageX=-100;
    }   

//-life    
  if( life3X>0 && hogY<soldierY+80 && hogY+80>soldierY
  && hogX<soldierX+80 && hogX+80>soldierX){
        hogX=320;
        hogY=80;
        hogState=STAY;
        life3X=-100;}
  if( life3X<0 && life2X>0 && hogY<soldierY+80 && hogY+80>soldierY &&
  hogX<soldierX+80 && hogX+80>soldierX){
        hogX=320;
        hogY=80;
        hogState=STAY;
        life2X=-100;}  
  if( life2X<0 && hogY<soldierY+80 && hogY+80>soldierY
  && hogX<soldierX+80 && hogX+80>soldierX ){
    hogState=STAY;
    gameState= GAME_OVER;}        
                        
//set the position of the soldier
  image(soldierImg,soldierX,soldierY);
  soldierX+=speedS;
  soldierX = soldierX %720;
 
//cabbage
  image(cabbage,cabbageX,cabbageY);
  break;  
  
//game over  
case GAME_OVER:
  image(gameOver,0,0);  
      if(mouseX > BUTTON_LEFT && mouseX < BUTTON_RIGHT
      && mouseY > BUTTON_TOP && mouseY < BUTTON_BOTTOM){
        image(restartHover, START_X, START_Y);
        if(mousePressed){
          gameState = GAME_RUN;
          hogX=320;
          hogY=80;
          life2X=80;
          b=floor(random(2,6));
          cabbageY=80*b;
          c=floor(random(0,8));
          cabbageX=80*c;
          a=floor(random(2,5));
          soldierY=80*a;
        }
      }else{
        image(restart, START_X, START_Y);}     
    break;
}
}

void keyPressed(){

  switch(keyCode){
    //down
    case DOWN:
    if(frame==15){
      down=true; 
      frame=0;
      hogState=GO_DOWN;}
      if(hogY>=400){hogState=STAY;}
    break;
    
    //right
    case RIGHT:
    if(frame==15){
      right=true;
      frame=0; 
      hogState=GO_RIGHT;}
      if(hogX>=560){hogState=STAY;}
    break;
    
    //left
      case LEFT:
      if(frame==15){
      left=true;
      frame=0;
      hogState=GO_LEFT;}
      if(hogX<=0){hogState=STAY;}
    break;
}
}
