//https://www.behance.net/gallery/34417137/Brett-Reif
import controlP5.*;

ControlP5 cp5;
ArrayList<PGraphics> pgs;
PFont font;
String displayText = "STANDARD";

int pgSize = 20;
boolean showCP5 = true;

float rotX = 0;
float rotY = 0;
float incX = 0.01;
float incY = 0.01;

color black = color(0);
color white = color(255);
color gray = color(125);

void setup() {
  size(600, 600, P3D);
  frameRate(60);
  surface.setLocation(0, 0);
  
  font = loadFont("Annonce-20.vlw");
  
  cp5 = new ControlP5(this);
  cp5.setColorForeground(gray);
  cp5.setColorBackground(black);
  cp5.setColorActive(white);
               
  cp5.addTextfield("displayText")
     .setPosition(10,height-15)
     .setSize(80,10)
     .setAutoClear(true)
     .setLabelVisible(false)
     ;
       
    
  initGraphics();
  
  imageMode(CENTER);
}

void draw() {
  background(0);
  for(int y = 0; y<pgs.size(); y++) {
    for(int x = 0; x<pgs.size(); x++) {
      int div = width/pgs.size();
      push();
      translate(div*x + (div/2), div*y + (div/2));
      //rotateX(sin(radians(rotX)));
      float mapX = map(x, 0, pgs.size(), 0, 15);
      float mapY = map(y, 0, pgs.size(), 0, 15);
      rotateZ(sin(radians(rotX))*mapX*mapY);
      image(pgs.get(x), 0, 0);
      pop();
      rotX += incX;
      rotY += incY;
    }
  }
  
}

public void displayText(String theText) {
  // automatically receives results from controller input
  displayText = theText.toUpperCase();
  initGraphics();
}



void initGraphics() {
  pgs = new ArrayList<PGraphics>();
  for(int i = 0; i<displayText.length(); i++) {
    pgs.add(createGraphics(pgSize, pgSize));
  }
  
  for(int i = 0; i<displayText.length(); i++) {
    PGraphics pg = pgs.get(i);
    pg.beginDraw();
    pg.textFont(font);
    pg.textAlign(CENTER, CENTER);
    
    pg.background(0);
    pg.fill(255);
    pg.translate(pg.width/2, pg.height/2);
    pg.text(displayText.charAt(i), 0,0);
    pg.endDraw();
  }
}
