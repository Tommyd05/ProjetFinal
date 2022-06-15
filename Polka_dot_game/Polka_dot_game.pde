int playerSize = 20;

int wallBall;

int score=0;
boolean ballKill=false;

boolean intro = true;
int skin = 1;
color[] skins = {color(0),color(255,0,0), color(0,255,0), color(0,0,255), 
color(255,255,0), color(255,0,255), color(0,255,255)};

double curX;
double curY;

int numberOfBalls=20;
PShape[] balls=new PShape[numberOfBalls];

int[] heightBall=new int[numberOfBalls];
int[] widthBall=new int[numberOfBalls];
int[] ballSpeedX=new int[numberOfBalls];
int[] ballSpeedY=new int[numberOfBalls];
int[] ballSize=new int[numberOfBalls];


void ballSize() {
  for (int n=0;n<numberOfBalls;n++) {
    ballSize[n]=(int)((Math.random()*100)/4);
  }
}
    
void widthBallStart() {
  for (int n=0;n<numberOfBalls;n++) {
    widthBall[n]=(int)(Math.random()*1000);
  }
}

void ballHeightStart() {
  for (int n=0;n<numberOfBalls;n++) {
    heightBall[n]=0-ballSize[n]-1;
  }
}

void ballSpeedY() {
  for (int n=0;n<numberOfBalls;n++) {
    ballSpeedY[n]=(int)(((Math.random()*11)-5));
  }
}

void ballSpeedX() {
    for (int n=0;n<numberOfBalls;n++) {
    ballSpeedX[n]=(int)(((Math.random()*11)-5));
  }
}
  


void setup() {
  widthBallStart();
  ballSize();
  ballHeightStart();
  ballSpeedX();
  ballSpeedY();
  
  size(1000,1000);
  background(240);
  intro();
}

void draw(){
  if (intro){
      couleur();
  }
  else{
    background(240);
    /**joueur*/
    fill(skins[skin]);
    PShape player = createShape(ELLIPSE,mouseX,mouseY, playerSize, playerSize);
    shape(player);
    
  printScore();
  
  ballsShowing();
  touchBall();
  touchWall();
  }  
}
void mousePressed(){
  if(intro){
    if (mouseX<660&&mouseX>340&&mouseY<710&&mouseY>590){
      intro = false;
      loop();
      noCursor();
    }
    else if (skin<6){
      skin++;
    }
    else{
      skin=0;
    }
  }
}
void intro(){ 
  if(intro){
    fill(0);
    textSize(40);
    text("Cliquez l'écran pour changer votre couleur",150,400);
    
    fill(0);
    rect(340,590,320,120,10);
    fill(255);
    rect(350,600,300,100,10);
    textSize(80);
    fill(0);
    text("JOUER",385,675);
    
  }
}
void couleur() {
  fill(0);
  circle(500,500,72);
  for (int i=0;i<7;i++){
    if (skin==i){
      fill(skins[i]);
    }
  }
  circle(500,500,70);
}

void printScore() {
  PFont font;
  font=loadFont("TimesNewRomanPS-BoldMT-30.vlw");
  textFont(font);
  fill(0,255,0);
  text("Score: " + score,850,50);
}

void touchBall(){
  for (int n=0;n<numberOfBalls;n++) {
    
    if ((widthBall[n]-mouseX)<30&&(widthBall[n]-mouseX)>-30&&(heightBall[n]-mouseY)<30&&(heightBall[n]-mouseY)>-30) {
      score++;
      playerSize+=3;
      ballKill=true;
      heightBall[n]=-1000;
    }
  }
}

void touchWall(){
  for (wallBall=0;wallBall<numberOfBalls;wallBall++) {
    if (widthBall[wallBall]<(0-ballSize[wallBall]-11)||widthBall[wallBall]>(1000+ballSize[wallBall]+11)||heightBall[wallBall]<(0-ballSize[wallBall]-11)||heightBall[wallBall]>(1000+ballSize[wallBall]+11)) {
       removeAddBall();
    }
  }
}

void removeAddBall() {
  heightBall[wallBall]=0-ballSize[wallBall]-1;
  widthBall[wallBall]=(int)(Math.random()*1000);
  ballSize[wallBall]=(int)((Math.random()*1000)/4);
  ballSpeedY[wallBall]=(int)(((Math.random()*11)/-5));
  ballSpeedX[wallBall]=(int)(((Math.random()*11)-5)); 
}



void ballsShowing() {
  for (int n=0;n<numberOfBalls;n++) {
     fill(0);
     balls[n]=createShape(ELLIPSE,widthBall[n],heightBall[n],ballSize[n],ballSize[n]);
     shape(balls[n]);
     heightBall[n]+=ballSpeedY[n];
     widthBall[n]+=ballSpeedX[n];
  }
}