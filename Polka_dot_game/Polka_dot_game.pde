
int playerSize = 20;
int score = 0;
boolean intro = true;
int flag = 0;
PImage[] flags = new PImage[17];
int aX=0;
int aY=0;

void setup(){
    assignFlag();
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
    fill(flags[flag]);
    PShape player = createShape(ELLIPSE,mouseX,mouseY, playerSize, playerSize);
    shape(player);
    
    printScore();
  }  
}
void mousePressed(){
  if(intro){
    if (mouseX<660&&mouseX>340&&mouseY<710&&mouseY>590){
      intro = false;
      loop();
      noCursor();
    }
    else if (flag<17){
      flag++;
    }
    else{
      flag=0;
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
    if (flag==i){
      image(flags[flag], 500,500,70,70);
    }
  }
}  
void printScore(){
  PFont font;
  font=loadFont("TimesNewRomanPS-BoldMT-30.vlw");
  textFont(font);
  fill(0);
  text("Score: " + score,850,50);
}
void score(){
  if ((aX-mouseX)<30&&(aX-mouseX)>-30&&(aY-mouseY)<30&&(aY-mouseY)>-30) {
    score++;
  }
}
void assignFlag(){
  for (int n = 0;n<17;n++){
    Scanner flagScanner = new Scanner(new File("flags.txt"));
    flags[n] = flagScanner.nextLine();
    flagScanner.close();
  }
}