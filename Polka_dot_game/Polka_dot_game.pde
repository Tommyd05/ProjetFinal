int playerSize = 20;
int score=0;
int aX=0;
int aY=0;

void setup(){
    size(1000,1000);
    background(240);
    noCursor();
    intro();
}
void draw(){
  background(240);
  /**joueur*/
  circle(mouseX,mouseY, playerSize);
  
  PFont font;
  font=loadFont("TimesNewRomanPS-BoldMT-30.vlw");
  textFont(font);
  fill(0);
  text("Score: " + score,850,50);
    
}
void intro(){ 
  
}

void score(){
  if ((aX-mouseX)<30&&(aX-mouseX)>-30&&(aY-mouseY)<30&&(aY-mouseY)>-30) {
    score++;
  }
}
