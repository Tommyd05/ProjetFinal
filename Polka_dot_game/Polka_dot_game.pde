int playerSize = 20;

int score=0;
boolean ballKill=false;

boolean intro = true;
int skin = 1;
color[] skins = {color(0),color(255,0,0), color(0,255,0), color(0,0,255), 
color(255,255,0), color(255,0,255), color(0,255,255)};

int numberOfBalls=(int)((Math.random()*100)/4);
int[] heightBall=new int[numberOfBalls];
int[] speed=new int[numberOfBalls];
int[] ballSize=new int[numberOfBalls];
PShape[] balls=new PShape[numberOfBalls];
int[] startPoint=new int[numberOfBalls];

void ballSize() {
  for (int n=0;n<numberOfBalls;n++) {
    ballSize[n]=(int)((Math.random()*1000)/4);
  }
}

void startPoint() {
  for (int n=0;n<numberOfBalls;n++) {
    startPoint[n]=(int)(Math.random()*1000);
  }
}

void ballSpeed() {
  for (int n=0;n<numberOfBalls;n++) {
    speed[n]=(int)(((Math.random()*100)/5)+1);
  }
}

void ballHeightStart() {
  for (int n=0;n<numberOfBalls;n++) {
    heightBall[n]=0;
  }
}

void setup() {
    ballSize();
    startPoint();
    ballSpeed();
  
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
  
  randomBalls();
  touchBall();
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
    if ((startPoint[n]-mouseX)<30&&(startPoint[n]-mouseX)>-30&&(heightBall[n]-mouseY)<30&&(heightBall[n]-mouseY)>-30) {
      score++;
      playerSize+=3;
      ballKill=true;
      heightBall[n]=-1000;
    }
  }
}


void randomBalls() {
  for (int n=0;n<numberOfBalls;n++) {
    //if (ballKill==false) {  
       fill(0);
       balls[n]=createShape(ELLIPSE,startPoint[n],heightBall[n],ballSize[n],ballSize[n]);
       shape(balls[n]);
       heightBall[n]+=speed[n];
    //}
    //else{}
  }
}