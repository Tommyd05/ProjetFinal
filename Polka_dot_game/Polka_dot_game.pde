/**
* Polka-dot game. Un genre de agar.io à un joueur.
* Auteurs: Thomas Dufour, Zachary Wilson
* Version: 17 juin 2022
*/

int playerSize = 40;

int score=0;

boolean intro = true, dead = false;
int peau = 0;
color[] ballColours = {color(255,150,0), color(200,255,200), color(0,0,100),
color(120,0,150)};
color[] skinColours = {color(0),color(255,0,0), color(0,255,0), color(0,0,255), 
color(255,255,0), color(255,0,255), color(0,255,255)};

PImage[] flags = new PImage[17];

int numberOfBalls = 20;

PShape[] balls=new PShape[numberOfBalls];

int[] heightBall=new int[numberOfBalls];
int[] widthBall=new int[numberOfBalls];
int[] ballSpeedX=new int[numberOfBalls];
int[] ballSpeedY=new int[numberOfBalls];
int[] ballSize=new int[numberOfBalls];
 
void assign(){
  for(int n = 0;n<numberOfBalls;n++){
    int edge = (int)(Math.random()*4);
    ballSize[n]=n*5+playerSize/2;
    if (edge == 0){
      heightBall[n] = 0-ballSize[n];
      widthBall[n] = (int)((Math.random()*901)+50);
      ballSpeedY[n] = (int)(Math.random()*12)+1;
      ballSpeedX[n] = (int)(Math.random()*25)-12;
    }
    else if(edge == 1){
      heightBall[n] = 1000+ballSize[n];
      widthBall[n] = (int)((Math.random()*901)+50);
      ballSpeedY[n] = (int)(Math.random()*12)-1;
      ballSpeedX[n] = (int)(Math.random()*25)-12;
    }
    else if (edge == 2){
      widthBall[n] = 0-ballSize[n];
      heightBall[n] = (int)((Math.random()*901)+50);
      ballSpeedX[n] = (int)(Math.random()*12)+1;
      ballSpeedY[n] = (int)(Math.random()*25)-12;
    }
    else{
      widthBall[n] = 1000+ballSize[n];
      heightBall[n] = (int)((Math.random()*901)+50);
      ballSpeedX[n] = (int)(Math.random()*-12)-1;
      ballSpeedY[n] = (int)(Math.random()*25)-12;
    }
  }
}
void setup() {
  
  assignFlag();
  assign();
  
  size(1000,1000);
  background(240);
  intro();
}

void draw(){
  if (intro){
    peau();
  }
  else if (dead){
    
  }
  else{
    
    background(240);
    /**joueur*/
    if (peau < 7){
      fill(skinColours[peau]);
      circle(mouseX,mouseY,playerSize);
    }
    else{
      image(flags[peau-7], mouseX-(playerSize/2),mouseY-(playerSize/2),playerSize,playerSize);
    }
    
    printScore();
  
    touchBall();
    touchWall();
    ballsShowing();
    move();

  }  
}
void move(){
  for (int n=0;n<numberOfBalls;n++){
    heightBall[n] += ballSpeedY[n];
    widthBall[n] += ballSpeedX[n];
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
  if (dead){
    intro = true;
    assign();
    background(240);
    intro();
    dead = false;
  }
}
void intro(){ 

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

void peau(){
  fill(0);
  circle(500,700,72);
  for (int i=0;i<24;i++){
    if(peau==i&&peau<7){
      fill(skinColours[peau]);
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
  text("Points: " + score,850,50);
}

void touchBall(){
  for (int n=0;n<numberOfBalls;n++) {
    if(collide(widthBall[n], heightBall[n], ballSize[n])){
      if (playerSize>ballSize[n]){

        score++;
        playerSize+=5;
        int edge = (int)(Math.random()*4);
        widthBall[n] = reassignWidth(edge, ballSize[n]);
        heightBall[n] = reassignHeight(edge, ballSize[n]);
        ballSpeedX[n] = reassignSpeedX(edge);
        ballSpeedY[n] = reassignSpeedY(edge);
        ballSize[n] = (n+1)*playerSize/2;
      }
      else{
        death();
      }
    }
  }
}

boolean collide(int w, int h, int size){
  if ((w-mouseX)<(size+playerSize)/2&&(w-mouseX)>(-(size+playerSize)/2)){
    if((h-mouseY)<(size+playerSize)/2&&(h-mouseY)>(-(size+playerSize)/2)){
      return true;
    }
  }
  return false; 
  
}
void touchWall(){
  for (int n=0;n<numberOfBalls;n++) {
    if (wallHit(widthBall[n], heightBall[n], ballSize[n]/2)){ 
      int edge = (int)(Math.random()*4);
      widthBall[n] = reassignWidth(edge, ballSize[n]);
      heightBall[n] = reassignHeight(edge, ballSize[n]);
      ballSpeedX[n] = reassignSpeedX(edge);
      ballSpeedY[n] = reassignSpeedY(edge);
      ballSize[n] = (n+1)*playerSize/4;
    }
  }

}
boolean wallHit(int w, int h, int size){
  if (w<(0-size*2)||w>(1000+size*2)){
    return true;
  }
  else if(h<(0-size*2)||h>(1000+size*2)){
    return true;
  }
  else {
    return false;
  }
  
}
 
int reassignWidth(int edge, int size){
  if (edge == 3){
    return 1000+size;
  }
  else if (edge == 2){
    return 0-size;
  }
  else{
    return (int)((Math.random()*901)+50);
  }
}
int reassignHeight(int edge, int size){
  if (edge == 0){
    return 0-size;
  }
  else if(edge == 1){
    return 1000+size;
  }
  else{
    return (int)((Math.random()*901)+50);

  }
}
int reassignSpeedX(int edge){
  if (edge == 2|| edge == 3){
    return (int)(Math.random()*7)+1;
  }
  else{  
    return (int)(Math.random()*15)-7;
  }
}
int reassignSpeedY(int edge){
  if (edge == 1|| edge == 2){
    return (int)(Math.random()*7)+1;
  }
  else{  
    return (int)(Math.random()*15)-7;
  }
}
void ballsShowing() {
  for (int n=0;n<numberOfBalls;n++) {
     fill(ballColours[n%4]);
     circle(widthBall[n], heightBall[n], ballSize[n]);
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
void death(){
    dead = true;
    cursor();
    background(0);
    fill(255);
    textSize(100);
    text("GAME OVER", 190,400);
    textSize(60);
    text("Points: " + score, 390, 600);
  }
