// have a grid of 600x600 pixel with custom tileSize
// feed the grid an image (pimage or pgraphics)
// feed the grid a character set
// grid calculates densities for its charset
// the grid first calculates the averageColor of a tile

// todo
// [ ] fix canvas positioning: it's slightly off?
// [x] tiles are not properly resizing with canvas: was a floating error. ofc.
// [x] charSets and fonts in arrays?
// [x] get a PGraphics objects from grid
// [ ] slowtrailing
// [ ] cp5 sliders, get all parameters in one place
// [ ] cp5: dropdowns: font, characterSet, resolution
// [ ] cp5: rotate 90° resolution for not square formats
// [ ] fix textFont sizes for the different grids
// [x] resolution modes: square, 16:9, 9:16
// [ ] video import (low prio)
// [ ] animation: layers, where nice lines are randomly drawn in a thick grid on canvas
// [ ] animation: gray scale animation
// [ ] animation: cellular automata
// [ ] control playback speed of ani class
// [ ] invert image
// [ ] play / pause

import controlP5.*;
import java.util.Collections;
import processing.video.*;

Grid grid;
Animation animation;
ControlP5 cp5;

int selectSet = 5;
String[] charSets = {
  " .:,;#'+*`=?!¬”#^˜·$%/()",
  " ░▒▓█▄▀│┤╣║╚╔╗╝┐╩└╦╠┴═┬├╬─┼┘┌¦┼└┴┬├┐",
  " ░▒▓█▄▀",
  " ☿♀♁♂♃♄♅♆♇",
  " ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghjiklmnopqrstuvwxyz",
  " !#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~"
};



int selectFont = 0;
String[] fontNames = {
  "CourierNewPSMT-20.vlw",
  "InputMono-Medium-20.vlw",
  "FifteenTwenty-20.vlw",
  "Verdana-20.vlw"
};

int[][] resolutions = {
  {600, 600},
  {1920, 1080},
  {1080, 1920},
  {3840, 2160},
  {7680, 4320},
};
int selectResolution = 0;
int gridSize = 60; // 20x20

float splitflapInterval = 2;
float splitflapCooldown = 1;

boolean exportToggle = false;
boolean brightnessToggle = false;
boolean cpInitDone = false;

int frameNr = 0;
String y = year()+"";
String m = leadingZero(month());
String d = leadingZero(day());
String h = leadingZero(hour());
String i = leadingZero(minute());
String s = leadingZero(second());
String folderFormat = y + m + d + "_" + h + i + s;

void setup() {
  size(800, 600);
  frameRate(60);
  noSmooth();
  surface.setLocation(0, 0);
  surface.setTitle("Splitflapesque");
  
  Ani.init(this);
  initCP5();
  cpInitDone = true;
  initGrid();
  
  animation = new Animation(this, resolutions[selectResolution][0], resolutions[selectResolution][1]);
  grid.feed(loadImage("assets/test2.png"));
}

void draw() {
  background(30);
  updateGUI();
  animation.update();
  
  grid.feed(animation.getDisplay());
  //grid.feed(loadImage("assets/test2.png"));
  grid.update();
  //grid.display();
  
  if(selectResolution == 0) image(grid.getDisplay(), 10, 10, 580, 580);
  else if(selectResolution == 1 || selectResolution == 3) image(grid.getDisplay(), 10, 10, 580, 326);
  else if(selectResolution == 2) image(grid.getDisplay(), 10, 10, 326, 580);
  image(animation.getDisplay(), 600, 10, 80, 80);
  if(brightnessToggle) image(grid.getBrightnessGrid(), 700, 10, 80, 80);
  if(exportToggle) {
    grid.getDisplay().save("export/"+folderFormat+"/"+ frameNr +".tga");
    frameNr++;
  }
}
