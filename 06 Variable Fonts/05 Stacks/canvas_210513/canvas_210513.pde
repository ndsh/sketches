//https://www.behance.net/gallery/34417137/Brett-Reif
import peasy.PeasyCam;
import controlP5.*;
import de.looksgood.ani.*;

ControlP5 cp5;
PeasyCam cam;

ArrayList<PGraphics> pgs;
PFont font;
String displayText = "";
String[] displayTexts = {"HELLO", "QWERT"};
int copies = 30;
ArrayList<Textframe> frames = new ArrayList<Textframe>();
int currentFrame = 0;
int currentText = 0;
int overlappingFrames = 2; // how many frames are show on screen simultaneously

int pgSize = 60;
boolean showCP5 = true;

float rotX = 0;
float rotY = 0;
float incX = 2.5;
float incY = 0.05;

color black = color(0);
color white = color(255);
color gray = color(125);

long[] timestamp = {0, 0, 0, 0};
long[] interval = {5000, 10000, 5000, 6000};

boolean activateOnce = false;
boolean setup = false;

boolean record = false;
int frameCounter = 0;

float screenRotationX = 0;
float screenRotationY = 0;
float screenRotationZ = 0;
float frameCopies = 0;
float frameCopygoal = 0;
float[] newRotation = {0, 0, 0};


void setup() {
  size(600, 600, P3D);
  frameRate(60);
  pixelDensity(2);
  surface.setLocation(0, 0);
  
  font = loadFont("Annonce-20.vlw");
  
  Ani.init(this);
  
  cam = new PeasyCam(this, 1000);
  
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
  imageMode(CENTER);
  cp5.hide();
  for(int i = 0; i<timestamp.length; i++) timestamp[i] = -interval[i];
}

void draw() {
  background(255);
  translate(0, 0, 0);
  /*
  rotateX(radians(45));
  rotateY(radians(-45));
  rotateZ(radians(45));
  */
  //rotate(1);
  
  
  
  // axis 1
  if(millis() - timestamp[0] > interval[0]) {
    timestamp[0] = millis();
    newRotation[0] += 18;
  }
  if(millis() - timestamp[1] > interval[1]) {
    timestamp[1] = millis();
    newRotation[1] += 18;
  }
  if(millis() - timestamp[2] > interval[2]) {
    timestamp[2] = millis();
    newRotation[2] += 18;
  }
  
  if(millis() - timestamp[3] > interval[3]) {
    
    timestamp[3] = millis();
    if(frameCopygoal == 0) frameCopygoal = copies;
    else frameCopygoal = 0;
    
  }
  Ani.to(this, 4, "screenRotationX", newRotation[0]);
  Ani.to(this, 4, "screenRotationY", newRotation[1]);
  Ani.to(this, 4, "screenRotationZ", newRotation[2]);
  Ani.to(this, 2, "frameCopies", frameCopygoal);
  
  for(int i = 0; i<frames.size(); i++) {
  Textframe f = frames.get(i);
  f.setCopies((int)frameCopies);
  
  //rotateX(radians(screenRotationX));
  rotateY(radians(screenRotationY));
  //rotateZ(radians(screenRotationZ));
  
  f.display();
  }
  
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
