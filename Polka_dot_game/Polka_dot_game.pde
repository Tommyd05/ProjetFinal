int score=0;

void setup(){
    size(1500,1000);
    background(240);
}

void draw(){
  PFont font;
  font=loadFont("TimesNewRomanPS-BoldMT-30.vlw");
  textFont(font);
  fill(0);
  text("Score: " + score,850,50);
}
