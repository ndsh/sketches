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
float incX = 0.05;
float incY = 0.05;

color black = color(0);
color white = color(255);
color gray = color(125);

long timestamp = 0;
long interval = 0;
boolean direction = true;

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
      float mapX = map(x, 0, pgs.size(), 0, 7);
      float mapY = map(y, 0, pgs.size(), 0, 7);
      float sinX = map(sin(radians(rotX))*mapX, -pgs.size()-1, pgs.size(), -1, 1);
      float sinY = map(sin(radians(rotY))*mapY, -pgs.size()-1, pgs.size(), -1, 1);
      
      rotateZ(sinX);
      rotateZ(sinY);
      image(pgs.get(x), 0, 0);
      pop();
      
      
      if(direction) {
        rotX += incX;
        rotY += incY;
      } else {
        
      }
      if(rotX >= 700.0) {
        
      } else if(rotY < 0.0) {
        
      }
    }
  }
  
}

public void displayText(String theText) {
  // automatically receives results from controller input
  displayText = theText.toUpperCase();
  println(incX);
  initGraphics();
}

void controlEvent(ControlEvent theEvent) {
  if(theEvent.isAssignableFrom(Textfield.class)) {
    println("controlEvent: accessing a string from controller '"
            +theEvent.getName()+"': "
            +theEvent.getStringValue()
            );
  }
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
