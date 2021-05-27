// https://dia.tv/project/catk/#slide-8
// https://dia.tv/project/space10/
// https://timrodenbroeker.de/processing-tutorial-programming-posters/
import de.looksgood.ani.*;

PGraphics pg;
PFont font;
String displayText = "HELLO";
float ca;
Textframe frame;
float leftGoal = 0;
float rightGoal = 0;
float leftSet = 0;
float rightSet = 0;
int animationSide = 0;

long timestamp = 0;
long interval = 2000;

void setup() {
  size(600, 600, P3D);
  frameRate(60);
  surface.setLocation(0, 0);
  
  Ani.init(this);
  
  font = loadFont("Annonce-70.vlw");
  textFont(font);
  ca = textAscent();
  println(ca);
  
  frame = new Textframe(displayText);
  pg = createGraphics(600, 600);
  leftSet = width;
  rightSet = width;
  /*
  pg.beginDraw();
  pg.textFont(font);
  pg.textAlign(LEFT, CENTER);
  pg.background(0);
  pg.fill(255);
  float cw = pg.textWidth(displayText);
  println(cw);
  
  pg.push();
  pg.translate(0, pg.height/2);
  for(int x = -2; x < 3; x++) {
      pg.text(displayText, x,0);
      pg.text(displayText, 0,x);
  }
  pg.pop();
  pg.fill(0);
  pg.text(displayText, 0, pg.height/2);
  pg.endDraw();
  */
  
  imageMode(CENTER);
}

void draw() {
  background(30);
  
  //frame.setRight(mouseY);
  if(animationSide == 0) {
    if((int)frame.getLeft() >= width) {
      leftGoal = 0;
    }
    Ani.to(this, 1.5, "leftSet", leftGoal, Ani.EXPO_OUT);
    frame.setLeft(leftSet);
    if((int)frame.getLeft() <= 0) {
      if(millis() - timestamp > interval) {
        timestamp = millis();
        animationSide = 1;
      }
    }
  } else if(animationSide == 1) {
    if((int)frame.getRight() >= width) {
      rightGoal = 0;
    }
    Ani.to(this, 1.5, "rightSet", rightGoal, Ani.EXPO_OUT);
    frame.setRight(rightSet);
    if((int)frame.getRight() <= 0) {
      if(millis() - timestamp > interval) {
        timestamp = millis();
        animationSide = 2;
      }
    }
  } else if(animationSide == 2) {
    
    if(millis() - timestamp > interval) {
        timestamp = millis();
        animationSide = 0;
        frame.setLeft(width);
        frame.setRight(width);
        leftSet = width;
        rightSet = width;
        leftGoal = width;
        rightGoal = width;
      }
  }
  

  
  
  
  
  frame.display();
  /*
  beginShape();
  texture(pg);
  //vertex(mouseX, mouseY, map(mouseX, 0, 600, 0, mouseX), map(mouseY, 0, 600, 0, mouseY));
  vertex(mouseX, 0, 0, 0);
  vertex(600, 0, 600, 0);
  vertex(600, 600, 600, 600);
  vertex(mouseX, 600, 0, 600);
  //vertex(mouseX, mouseY+600, map(mouseX, 0, 600, 0, mouseX), map(mouseY, 0, 600, 0, mouseY)+600);
  endShape();
  */
}


void initGraphics() {
}
