float val = 0;
float inc = 0.1;

PGraphics pg1;
PGraphics pg2;
int tileSize = 50;

void setup() {
  size(200, 200);
  surface.setLocation(0, 0);
  rectMode(CENTER);
  imageMode(CENTER);
  
  pg1 = createGraphics(tileSize, tileSize);
  pg1.beginDraw();
  pg1.background(0, 0, 255);
  pg1.textAlign(CENTER, CENTER);
  pg1.textSize(60);
  pg1.text("C", pg1.width/2, pg1.height/2-7);
  pg1.endDraw();
  
  pg2 = createGraphics(tileSize, tileSize);
  pg2.beginDraw();
  pg2.background(0, 0, 255);
  pg2.textAlign(CENTER, CENTER);
  pg2.textSize(60);
  pg2.text("D", pg2.width/2, pg2.height/2-7);
  pg2.endDraw();
}

void draw() {
  background(255);
  
  
  int mapped1 = 0;
  int mapped2 = tileSize/2;
  if(val <= 0.5) mapped1 = int(map(val, 0.5f, 0f, 0, tileSize/2));
  if(val >= 0.5) mapped2 =  int(map(val, 0.5f, 1f, 0, tileSize/2));
  
  
  translate(width/2-60, height/2);
  
  PImage c1 = pg1.get(0, 0, tileSize, mapped1);
  PImage c2 = pg2.get(0, tileSize/2, tileSize, mapped2);
  PImage c3 = pg2.get(0, 0, tileSize, tileSize/2);
  PImage c4 = pg1.get(0, tileSize/2, tileSize, tileSize/2);
  image(pg1, 0, 0, tileSize, tileSize);
  
  
  push();
  translate(0, -tileSize/4);
  image(c3, 60, 0);
  pop();
  
  push();
  translate(0, tileSize/4);
  image(c4, 60, 0);
  pop();
  
  push();
  translate(0, -mapped1/2);
  image(c1, 60, 0);
  pop();
  
  
  
  
  
  if(val >= 0.5) {
    push();
    translate(0, mapped2/2);
    image(c2, 60, 0);
    pop();
  }
  
  
  
  //rect(0, 0, 20, 20);
  println(val);
  
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      val += inc;
      if(val >= 1.0) val = 1.0;
    } else if (keyCode == DOWN) {
      val -=inc;
      if(val < 0) val = 0;
    }
    //flap.setTarget(val);
  }
}
