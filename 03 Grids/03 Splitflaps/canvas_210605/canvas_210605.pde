// have a grid of 600x600 pixel with custom tileSize
// feed the grid an image (pimage or pgraphics)
// feed the grid a character set
// grid calculates densities for its charset
// the grid first calculates the averageColor of a tile

// todo
// [x] fix canvas positioning: it's slightly off?
// [x] tiles are not properly resizing with canvas: was a floating error. ofc.
// [x] charSets and fonts in arrays?
// [x] get a PGraphics objects from grid
// [ ] slowtrailing
// [ ] cp5 sliders, get all parameters in one place
// [ ] cp5: dropdowns: font, characterSet, resolution
// [ ] cp5: rotate 90° resolution for not square formats
// [ ] fix textFont sizes for the different grids
// [x] resolution modes: square, 16:9, 9:16
// [x] video import (low prio)
// [ ] animation: layers, where nice lines are randomly drawn in a thick grid on canvas
// [ ] animation: gray scale animation
// [x] animation: cellular automata
// [ ] control playback speed of ani class
// [ ] invert image
// [x] play / pause
// [ ] fix character overlap!
// [x] better debug view
// [ ] importer
// [ ] read movies dynamically and list them
// [ ] read images dynamically and list them
// [ ] start/stop movies according to the states


// source: https://en.wikipedia.org/wiki/List_of_Unicode_characters

import controlP5.*;
import java.util.Collections;
import processing.video.*;

Grid grid;
Animation animation;
ControlP5 cp5;
Importer importer;

int selectSet = 0;
int selectFont = 4;


int[][] resolutions = {
  {600, 600},
  {1920, 1080},
  {1080, 1920},
  {3840, 2160},
  {7680, 4320},
  {1080, 1080},
  {1200, 1200}
};
int selectResolution = 0;
int gridSize = 20; // 20x20

float splitflapInterval = 2;
float splitflapCooldown = 1;

boolean toggleExport = false;
boolean brightnessToggle = false;
boolean cpInitDone = false;
boolean toggleFeed = true;
boolean toggleIncrement = true;
boolean toggleDebugView = false;
boolean toggleFlapping = true;
boolean togglePlay = true;
boolean toggleStroke = true;
boolean toggleFill = false;
boolean toggleBackground = true;
boolean toggleBrightnessFlip = false;

int frameNr = 0;
String y = year()+"";
String m = leadingZero(month());
String d = leadingZero(day());
String h = leadingZero(hour());
String i = leadingZero(minute());
String s = leadingZero(second());
String folderFormat = y + m + d + "_" + h + i + s;
StringList imgFiles;
StringList movFiles;
int imgIndex = 0;
int movIndex = 0;

void setup() {
  size(800, 600);
  frameRate(60);
  noSmooth();
  surface.setLocation(0, 0);
  surface.setTitle("ASCII Tool / 0.0.7");
  
  Ani.init(this);
  initCP5();
  cpInitDone = true;
  initGrid();
  
  animation = new Animation(this, resolutions[selectResolution][0], resolutions[selectResolution][1]);
  
  importer = new Importer("assets");
  reloadFiles("_MOV");
  reloadFiles("_IMG");
}



void draw() {
  background(30);
  updateGUI();
  if(togglePlay) animation.update();
  
  if(toggleFeed) grid.feed(animation.getDisplay());
  //grid.feed(loadImage("assets/frtgi.png"));
  grid.update();
  
  if(toggleDebugView) {
    if(selectResolution == 0 || selectResolution == 5) image(animation.getDisplay(), 10, 10, 580, 580);
    else if(selectResolution == 1 || selectResolution == 3) image(animation.getDisplay(), 10, 10, 580, 326);
    else if(selectResolution == 2) image(animation.getDisplay(), 10, 10, 326, 580);
    image(grid.getDisplay(), 600, 10, 80, 80);
  } else {
    if(selectResolution == 0 || selectResolution == 5) image(grid.getDisplay(), 10, 10, 580, 580);
    else if(selectResolution == 1 || selectResolution == 3) image(grid.getDisplay(), 10, 10, 580, 326);
    else if(selectResolution == 2) image(grid.getDisplay(), 10, 10, 326, 580);
    image(animation.getDisplay(), 600, 10, 80, 80);
  }
  
  if(brightnessToggle) image(grid.getBrightnessGrid(), 700, 10, 80, 80);
  
  if(toggleExport) {
    grid.getDisplay().save("_EXPORT/"+folderFormat+"/"+ frameNr +".tga");
    frameNr++;
    push();
    fill(255, 0, 0);
    ellipse(570, 570, 20, 20);
    pop();
  }
  
}
