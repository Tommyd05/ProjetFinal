int playerSize = 20;

int wallBall;

int score=0;
boolean ballKill=false;

boolean intro = true;
int peau = 0;

color[] colours = {color(0),color(255,0,0), color(0,255,0), color(0,0,255), 
color(255,255,0), color(255,0,255), color(0,255,255)};

PImage[] flags = new PImage[17];
int aX=0;
int aY=0;

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
  assignFlag();
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
    peau();
  }
  else{
    background(240);
    /**joueur*/
    fill(0);
    circle(mouseX,mouseY,playerSize+2);
      if (peau < 7){
        fill(colours[peau]);
        circle(mouseX,mouseY,playerSize);
      }
      else{
        flags[peau-7].resize(playerSize,0);
        image(flags[peau-7], mouseX-(playerSize/2),mouseY-(playerSize/2));
      }
    
  printScore();
  
  ballsShowing();
  touchBall();
  touchWall();
  }  
}
void mousePressed(){
  if(intro){
    if (mouseX<660&&mouseX>340&&mouseY<910&&mouseY>790){
      intro = false;
      noCursor();
    }
    else if (peau<24){
      peau++;
    }
    else{
      peau=0;
    }
  }
}
void intro(){ 
  if(intro){
    fill(0);
    textSize(40);
    fill(0,150,0);
    text("Cliquez l'écran pour changer votre peau!", 160,600);
    
    textSize(100);
    fill(200,0,0);
    text("P O L K A - D O T",170,200);
    
    textSize(30);
    fill(0,0,200);
    text("Absorbez les plus petites balles grandir",270,350);
    text("Évitez les balles plus grandes, elles vous tuent",220,400);
    
    fill(200,200,0);
    rect(340,790,320,120,10);
    fill(255);
    rect(350,800,300,100,10);
    textSize(80);
    fill(0);
    text("JOUER",385,875);
    
  }
}

void peau(){
  fill(0);
  circle(500,700,72);
  for (int i=0;i<24;i++){
    if(peau==i&&peau<7){
      fill(colours[peau]);
      circle(500,700,70);
    }
    else if (peau==i){
      image(flags[peau-7], 465,665,70,70);
    }
    
  }
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
void assignFlag(){
  BufferedReader flagReader;
  String line;
  flagReader = createReader("flags.txt");
  for (int n = 0;n<17;n++){
    try{
      line = flagReader.readLine();
      flags[n] = loadImage(line + ".png");
    }
    catch (IOException e){
      e.printStackTrace();
    }
  }
}
