//https://www.behance.net/gallery/34417137/Brett-Reif
import controlP5.*;
import de.looksgood.ani.*;

ControlP5 cp5;
ArrayList<PGraphics> pgs;
PFont font;
String displayText = "";
String[] displayTexts = {"--------------------", "::::::::::::", "&&&&&&&&&", "=========", "++++++++++++++", "*****", "////"};
int copies = 35;
ArrayList<Textframe> frames = new ArrayList<Textframe>();
int currentFrame = 0;
int currentText = 0;
int overlappingFrames = 2; // how many frames are show on screen simultaneously

int pgSize = 20;
boolean showCP5 = true;

float rotX = 0;
float rotY = 0;
float incX = 2.5;
float incY = 0.05;

color black = color(0);
color white = color(255);
color gray = color(125);

long timestamp = 0;
long interval = 0;

boolean activateOnce = false;
boolean setup = false;

boolean record = false;
int frameCounter = 0;

void setup() {
  size(1080, 1080, P3D);
  frameRate(60);
  pixelDensity(2);
  surface.setLocation(0, 0);
  
  font = loadFont("Annonce-20.vlw");
  
  Ani.init(this);
  
  cp5 = new ControlP5(this);
  cp5.setColorForeground(gray);
  cp5.setColorBackground(black);
  cp5.setColorActive(white);
               
  cp5.addTextfield("displayText")
     .setPosition(10,height-15)
     .setSize(80,10)
     .setAutoClear(true)
     ;
       
  initGraphics();
}

void draw() {
  //background(0);
  
  Textframe f = frames.get(currentFrame);
  //Ani.to(this, 1.5, "incX", 600);
  f.addX(incX*incX);
  f.display();
  
  
  if(f.getReach()) {
    activateOnce = true;
    Textframe f2 = frames.get((currentFrame+1)%frames.size());
    f2.addX(incX*incX);
    f2.display();
  } else if(!f.getReach() && activateOnce) {
    currentFrame++;
    currentFrame %= frames.size();
    activateOnce = false;
    f.setX(0);
    f.setOrigin(0);
  }
  
  //frames.get(0).setOrigin(mouseX);
  if(record) {
    saveFrame("export/"+ year() + month() + day() +"/"+ frameCounter++ + ".tif");
  }
}

public void displayText(String theText) {
  // automatically receives results from controller input
  displayText = theText.toUpperCase();
  println(incX);
  addGraphics();
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
  for(int i = 0; i<displayTexts.length; i++) {
    frames.add(new Textframe(displayTexts[i]));
  }
  
}

void addGraphics() {
    frames.add(new Textframe(displayText));
}

void initGraphics2() {
  pgs = new ArrayList<PGraphics>();
  for(int i = 0; i<displayText.length(); i++) {
    pgs.add(createGraphics(pgSize, pgSize));
  }
  
  for(int i = 0; i<displayText.length(); i++) {
    PGraphics pg = pgs.get(i);
    pg.beginDraw();
    pg.textFont(font);
    pg.textAlign(CENTER, CENTER);
    
    pg.background(255);
    pg.fill(0);
    pg.translate(pg.width/2, pg.height/2);
    pg.text(displayText.charAt(i), 0,0);
    pg.endDraw();
  }
}
