int playerSize = 20;
int score=0;
int heightBall=0;
boolean ballKill=false;

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
    noCursor();
    intro();
}
void draw() {
  background(240);
  /**joueur*/
  fill(0);
  circle(mouseX,mouseY, playerSize);
  
  randomBalls();
  
  scoreChange();
  
  PFont font;
  font=loadFont("TimesNewRomanPS-BoldMT-30.vlw");
  textFont(font);
  fill(0,255,0);
  text("Score: " + score,850,50);
    
}
void intro(){ 
  
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


void randomBalls(){
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