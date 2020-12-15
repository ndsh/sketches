// ref https://processing.org/examples/noise3d.html

import processing.sound.*;

Noise noise; 
DitherOrdered dither;
Zoomer zoomer;

int margin = 50;
float segment;
int divides = 3;

int boxDimension;

PGraphics frame;

void setup() {
  size(600, 600);
  
  
  
  frame = createGraphics(width, height);
  
  boxDimension = width-margin*2;
  segment = boxDimension/divides;
  
  noise = new Noise(470, 470);
  dither = new DitherOrdered(6);
  zoomer = new Zoomer(this, margin, boxDimension);
  
  
  
  println(segment);
  
  noFill();
  strokeWeight(3);
  stroke(255);
}

void draw() {
  background(0);
  
  
  noise.update();
  dither.setSrc(noise.getDisplay());
  dither.update();
  

  
  pushStyle();
  imageMode(CENTER);
  //image(noise.getDisplay(), width/2, height/2);
  image(dither.getImage(), width/2, height/2);
  popStyle();
  // draw a grid
  
  rect(margin, margin, width-margin*2, height-margin*2);
  loadPixels();
  frame.beginDraw();
  frame.loadPixels();
  frame.copy(0, 0, width, height, 0, 0, width, height);
  frame.endDraw();
  zoomer.setBackground(frame);
  zoomer.update();
  
  zoomer.display();
  image(zoomer.getSnap(), 20, 20);
  
}

// key press a to add new zoomers
