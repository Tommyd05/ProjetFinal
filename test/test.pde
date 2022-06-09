boolean falling = false;
int h,rand,score;

void setup(){
  size(1000,1000);
}
void draw(){
  background(255,200,0);
    text(str(score), 900,50);
  fill(0,255,0);
  circle(mouseX,mouseY,50);
  
  if (!falling){
    rand = (int)(Math.random()*900)+50;
    h = -25;
    falling = true;
  }
  fill(255,0,0);
  circle(rand,h,50);
  h += 15;
  if (h==1025){
    falling = false;
  }  
  if ((rand-mouseX)<40&&(rand-mouseX)>-40&&(h-mouseY)<40&&(h-mouseY)>-40){
    falling = false;
    score++;
  }
}
