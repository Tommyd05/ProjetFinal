
int playerSize = 20;
int score = 0;
boolean intro = true;
int peau = 0;
color[] colours = {color(0),color(255,0,0), color(0,255,0), color(0,0,255), 
color(255,255,0), color(255,0,255), color(0,255,255)};
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
  }  
}
void mousePressed(){
  if(intro){
    if (mouseX<660&&mouseX>340&&mouseY<910&&mouseY>790){
      intro = false;
      loop();
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
