import processing.pdf.*;
PImage p;
 
DitherOrdered dither;


int margin = 50;
float segment;
int divides = 3;

int boxDimension;

PGraphics frame;

void setup() {
  size(1341, 1389);
  p = loadImage("wiener.png");
  
  
  frame = createGraphics(width, height);
  
  boxDimension = width-margin*2;
  segment = boxDimension/divides;
  
  dither = new DitherOrdered(3);
  
  
  
  println(segment);
  
  noFill();
  strokeWeight(3);
  stroke(255);
  
  beginRecord(PDF, "output/canvas.pdf");
}

void draw() {
  background(0);
  
  
  // dither PImage
  dither.setSrc(p);
  dither.update();
  

  
  image(dither.getImage(), 0, 0);
  endRecord();
  exit();
  
}

// key press a to add new zoomers
