int playerSize = 20;
int score = 0;
boolean intro = true;
int skin = 1;
color[] skins = {color(0),color(255,0,0), color(0,255,0), color(0,0,255), 
color(255,255,0), color(255,0,255), color(0,255,255)};

void setup(){
    size(1000,1000);
    background(240);
    intro();
}
void draw(){
  couleur();
  if (!intro){
    noCursor();
    background(240);
    /**joueur*/
    fill(skins[skin]);
    PShape player = createShape(ELLIPSE,mouseX,mouseY, playerSize, playerSize);
    shape(player);
  
    PFont font;
    font=loadFont("TimesNewRomanPS-BoldMT-30.vlw");
    textFont(font);
    fill(0);
    text("Score: " + score,850,50);
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
void mousePressed(){
  if(intro){
    if (mouseX<660&&mouseX>340&&mouseY<710&&mouseY>590){
      intro = false;
      loop();
    }
    else if (skin<6){
      skin++;
    }
    else{
      skin=0;
    }
  }
}