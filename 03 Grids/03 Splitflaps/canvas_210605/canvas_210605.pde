// inspo
// https://www.instagram.com/p/CT67z7FI7Oq/?utm_source=ig_web_copy_link

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
// [x] invert image
// [x] play / pause
// [ ] fix character overlap!
// [x] better debug view
// [x] importer
// [x] read movies dynamically and list them
// [x] read images dynamically and list them
// [ ] start/stop movies according to the states
// [ ] geomerative import
// [ ] stickyFlock quadtree import
// [ ] change resolution via controls
// [ ] layer system (turn on/off flapping for example on same animation)
// [ ] turn of flapping based on "lightness"
// [x] settings
// [/] remove stickyflock menu
// [ ] flow field
// [ ] turn off the "brightness mapping" / pixel density
// [ ] something like a bright "cursor" symbol that appears before new chars (see andreas gysin works)
// [x] autocycle for galleries
// [ ] flaps mit invertiertem hintergrund



// source: https://en.wikipedia.org/wiki/List_of_Unicode_characters


import java.util.Collections;
import processing.video.*;

Grid grid;
Animation animation;
int layers = 1;


Importer importer;
PImage globalFrame = null;
PFont uiFont;
PGraphics output;

int selectSet = 0;
int selectFont = 0;

int[][] resolutions;
String[] charSets;
String[] fontNames;
int selectResolution = 0;
int gridSize = 100; // 20x20

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
boolean toggleAutocycle = false;
boolean toggleFullscreen = false;

boolean firstClick = false;
boolean frameReady = false;

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
int exportCounter = -1;
String fontsFolder = "fonts/";

long timestamp;
long autoInterval = 10000;

void setup() {
  size(800, 600, P2D);
  //fullScreen();
 
  
  frameRate(60);
  noSmooth();
  surface.setLocation(0, 0);
  surface.setTitle("ASCII Tool / 0.0.7");
  
  loadSettings();
  uiFont = loadFont(fontsFolder + "/SFMono-Regular-8.vlw");
  Ani.init(this);
  initCP5();
  cpInitDone = true;
  initGrid();
  
  importer = new Importer("assets");
  reloadFiles("_MOV");
  reloadFiles("_IMG");
  
  animation = new Animation(this, resolutions[selectResolution][0], resolutions[selectResolution][1]);
  
  if(toggleFullscreen) surface.setSize(resolutions[selectResolution][0], resolutions[selectResolution][1]);
}

void draw() {
  if(toggleAutocycle && millis() - timestamp > autoInterval) {
    timestamp = millis();
    //if(random(100) > 50) randomGridSize();
    if(random(100) > 50) randomCharSet();
    //if(random(1000) > 700) toggleBackground(true);
    //else toggleBackground(false);
    animation.randomState();
  }
  
  if(togglePlay) animation.update();
  if(animation.ready()) {
    if(toggleFeed) grid.feed(animation.getDisplay());
    grid.update();
    background(30);
    showWindows(detectResolution(resolutions[selectResolution][0], resolutions[selectResolution][1]));
    if(brightnessToggle) image(grid.getBrightnessGrid(), 700, 10, 80, 80);
    exportFrames(toggleExport);
  }
  
/*

if(toggleFullscreen) {
      cp5.hide();
    } else {
      cp5.draw();
    }
*/

  animation.resetReadiness();
  frameReady = false;
  updateGUI();
}
