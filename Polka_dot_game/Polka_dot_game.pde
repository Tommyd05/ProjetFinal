int playerSize = 20;

int score=0;
int heightBall=0;
boolean ballKill=false;

boolean intro = true;
int skin = 1;
color[] skins = {color(0),color(255,0,0), color(0,255,0), color(0,0,255), 
color(255,255,0), color(255,0,255), color(0,255,255)};
int aX=0;
int aY=0;

int[] ballSize=new int[3];
PShape[] balls=new PShape[3];
int[] startPoint=new int[3];

void ballSize() {
  for (int n=0;n<3;n++) {
    ballSize[n]=(int)(((Math.random()*1000))/2);
  }
}

void startPoint() {
  for (int n=0;n<3;n++) {
    startPoint[n]=(int)((Math.random()*1000));
  }
}

void setup() {
    ballSize();
    startPoint();
  
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
    
  background(240);
  /**joueur*/
  fill(0);
  circle(mouseX,mouseY, playerSize);
  
  randomBalls();
  
  scoreChange();
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
void couleur(){
  fill(0);
  circle(500,500,72);
  for (int i=0;i<7;i++){
    if (skin==i){
      fill(skins[i]);
    }
  }
  circle(500,500,70);
}

void printScore(){
  PFont font;
  font=loadFont("TimesNewRomanPS-BoldMT-30.vlw");
  textFont(font);
  fill(0,255,0);
  text("Score: " + score,850,50);
}

void scoreChange(){
  for (int n=0;n<3;n++) {
    if ((startPoint[n]-mouseX)<30&&(startPoint[n]-mouseX)>-30&&(heightBall-mouseY)<30&&(heightBall-mouseY)>-30) {
      score++;
      ballKill=true;
      heightBall=-100;
    }
  }
}


void randomBalls() {
  for (int n=0;n<3;n++) {
    //if (ballKill==false) {  
       fill(0);
       balls[n]=createShape(ELLIPSE,startPoint[n],heightBall,ballSize[n],ballSize[n]);
       shape(balls[n]);
       heightBall++;
    //}
    //else{}
  }
}