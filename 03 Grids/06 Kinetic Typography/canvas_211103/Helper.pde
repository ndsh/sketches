// Import libraries
import controlP5.*;
import processing.video.*;

// Objects
ControlP5 cp5;
Importer importer;
PGraphics pg;
PGraphics pg2;
PGraphics pg4;
PGraphics pgTemp;
PFont font1;
PFont font2;
PFont uiFont;
Dither d;
PImage p;
Movie myMovie;
PImage source = null;

// Globals
color white = color(255);
color black = color(0);
color gray = color(125);

int wallW = 1560;
int wallH = 408;

// Animation variables
float speed = 30;
int phasing = 10;
boolean waveDirection = true;

int sx, sy, sw, sh, dx, dy, dw, dh;

int counter = 0;
boolean showGrid = true;
boolean showCursor = true;
boolean doubleText = false;
boolean ditherThis = true;
boolean export = false;
boolean bigText = false;
boolean pixelate = true;

int[] targetStart = {28, 1};
int[] targetEnd = {8, 14};

int waveMode = 1;

float wave = 0;

int tilesX = 65;
int tilesY = 17;
long timestamp = 0;
long interval = 500;

String text1 = "LEL";
String text2 = "TECHNOLOGIES";

int tileW = 0;
int tileH = 0;

int ditherMode = 0;
String[] namedDithers = {"FLOYD-STEINBERG", "ORDERED BAYER", "ATKINSON", "RANDOM"};

float facetteX = 0;
float facetteY = 0;

float targetRotation1 = 0.02;
float targetRotation2 = 0.02;

int ditherAlpha = 20;

Drop[] drops = new Drop[500]; // array of drop objects
Flake[] flakes = new Flake[500]; // array of drop objects
ArrayList<Dot> dots;

String assetsPath = "../../../Assets/";
String staticPath = "Static";
String videoPath = "Video";
StringList staticImports;
StringList videoImports;
int staticIndex = 0;
int videoIndex = 0;

float targetRotation = 180;

/* CLOUDS
 */
float increment = 0.01;
float zoff = 0.0;
float xincrement = 0.01;
float yincrement = 0.01;
float zincrement = 0.02;
float noiseBrightness = 255;
float sunPos = wallH;
float sunSize = wallW/2;
float sunBrightness = 255; 

// Functions and Events

void grid() {
  if (showGrid) {
    push();
    stroke(255);
    for (int x = 0; x < tilesX; x++) {
      line(x *tileW, 0, x*tileW, wallH);
    }
    for (int y = 0; y < tilesY; y++) {
      line(0, y *tileW, wallW, y*tileW);
    }
    line(wallW-1, 0, wallW-1, wallH);
    line(0, wallH, wallW, wallH);
    pop();
  }
}

void mouseDragged() {
  if(state == 2) {
    pgTemp.beginDraw();
    //pg3.fill(0, 10);
    //pg3.rect(0, 0, pg3.width, pg3.height);
    pgTemp.fill(255);
    pgTemp.noStroke();
    pgTemp.rect(mouseX/tileW * tileW, mouseY/tileH * tileH, 24, 24);
    pgTemp.endDraw();
  } else {
    if(mouseButton == 37) {
      
    }
  }
}
void keyPressed() {
  if (key == CODED) {
    if(keyCode == LEFT) {
    } else if(keyCode == RIGHT) {
    } else if(keyCode == UP) {
    } else if(keyCode == DOWN) {
    }
  } else {
    if (key == 'w' || key == 'W' ) {
    } else if (key == 'g' || key == 'G' ) {
    } else if(key == 'c' || key == 'C') {
    } else if(key == 't' || key == 'T') {
    } else if(key == 'm' || key == 'M') {
    } else if(key == 'd' || key == 'D') {
    }
    
  }
}

class Drop {
  float x; // x postion of drop
  float y; // y position of drop
  float z; // z position of drop , determines whether the drop is far or near
  float len; // length of the drop
  float yspeed; // speed of te drop
  
  //near means closer to the screen , ie the higher the z value ,closer the drop is to the screen.
  Drop() {
    x  = random(wallW); // random x position ie width because anywhere along the width of screen
    y  = random(-500, -50); // random y position, negative values because drop first begins off screen to give a realistic effect
    z  = random(0, 20); // z value is to give a perspective view , farther and nearer drops effect
    len = map(z, 0, 20, 10, 20); // if z is near then  drop is longer
    yspeed  = map(z, 0, 20, 1, 20); // if z is near drop is faster
  }

  void fall() { // function  to determine the speed and shape of the drop 
    y = y + yspeed; // increment y position to give the effect of falling 
    float grav = map(z, 0, 20, 0, 0.2); // if z is near then gravity on drop is more
    yspeed = yspeed + grav; // speed increases as gravity acts on the drop

    if (y > wallH) { // repositions the drop after it has 'disappeared' from screen
      y = random(-200, -100);
      yspeed = map(z, 0, 20, 4, 10);
    }
  }

  void show(PGraphics pg) { // function to render the drop onto the screen
    float alpha = map(z, 0, 20, 0, 255); //if z is near , drop is more thicker
    float thick = map(z, 0, 20, 1, 10); //if z is near , drop is more thicker
    pg.strokeWeight(thick); // weight of the drop
    pg.stroke(255, alpha); // purple color
    pg.line(x, y, x, y+len); // draws the line with two points 
  }
}

class Flake {
  float x; // x postion of drop
  float y; // y position of drop
  float z; // z position of drop , determines whether the drop is far or near
  float len; // length of the drop
  float yspeed; // speed of te drop
  float angle = 2;
  
  //near means closer to the screen , ie the higher the z value ,closer the drop is to the screen.
  Flake() {
    x  = random(-100, wallW+100); // random x position ie width because anywhere along the width of screen
    y  = random(-500, -50); // random y position, negative values because drop first begins off screen to give a realistic effect
    z  = random(0, 20); // z value is to give a perspective view , farther and nearer drops effect
    len = map(z, 0, 20, 10, 20); // if z is near then  drop is longer
    yspeed  = map(z, 0, 20, 1, 2); // if z is near drop is faster
  }

  void fall() { // function  to determine the speed and shape of the drop 
    y = y + yspeed; // increment y position to give the effect of falling 
    float grav = map(z, 0, 20, 0, 0.000002); // if z is near then gravity on drop is more
    yspeed = yspeed + grav; // speed increases as gravity acts on the drop
    x += map(sin(frameCount*0.09 + x*y), -1, 1, -2, 2);

    if (y > wallH) { // repositions the drop after it has 'disappeared' from screen
      y = random(-200, -100);
      yspeed = map(z, 0, 20, 4, 1);
    }
  }

  void show() { // function to render the drop onto the screen
    float alpha = map(z, 0, 20, 0, 255); //if z is near , drop is more thicker
    float thick = map(z, 0, 20, 1, 10); //if z is near , drop is more thicker
    //pg5.strokeWeight(thick); // weight of the drop
    //pg5.stroke(255, alpha); // purple color
    pgTemp.fill(255, alpha);
    pgTemp.ellipse(x, y, 5, 5); // draws the line with two points 
  }
}

void drawSun(float xloc, float yloc, int size, int num) {
  float grayvalues = 255/num;
  float steps = size/num;
  for (int i = 0; i < num; i++) {
    pgTemp.fill(i*grayvalues);
    pgTemp.noStroke();
    pgTemp.ellipse(xloc, yloc, size - i*steps, size - i*steps);
  }
}

void movieEvent(Movie m) {
  m.read();
  //if(state == VIDEO) source = myMovie;
}

void loadImage(int index) {
  p = loadImage(staticImports.get(index));
}
void loadMovie(int index) {
  if(myMovie != null) myMovie.stop();
  myMovie = null;
  System.gc();
  myMovie = new Movie(this, videoImports.get(index));
  myMovie.loop();
  myMovie.play();
  myMovie.volume(0);
  //myMovie.speed(movieSpeed);
  
}

String trimPath(String s) {
  String e[] = split(s, "/");
  return e[e.length-1];
}

PGraphics pixelate(PImage p) { // aka macro pixels
  PGraphics pg = createGraphics(wallW, wallH);
  pg.beginDraw();
  pg.noStroke();
  int tWidth = wallW / tilesX;
  int tHeight = wallH / tilesY;
  
  color c = 0;
  float b = 0;
  
  
  for(int y = 0; y<tilesY; y++) {
    for(int x = 0; x<tilesX; x++) {
      c = averageColor(p, x*tWidth, y*tHeight, tWidth, tHeight);
      b = brightness(c);
      pg.fill(b);
      pg.rect(x*tWidth, y*tHeight, tWidth, tHeight);
    }
  }
  pg.endDraw();
  return pg;
  //int tilesX = 65;
  //int tilesY = 17;
}


color averageColor(PImage source, float x, float y, float w, float h) {
  PImage temp = source.get((int)x, (int)y, (int)w, (int)h);
  temp.loadPixels();
  int r = 0;
  int g = 0;
  int b = 0;
  
  for (int i=0; i<temp.pixels.length; i++) {
    color c = temp.pixels[i];
    r += c>>16&0xFF;
    g += c>>8&0xFF;
    b += c&0xFF;
  }
  r /= temp.pixels.length;
  g /= temp.pixels.length;
  b /= temp.pixels.length;
 
  return color(r, g, b);
}

void feed() {
  
  color c = 0;
  float b = 0;
  for(int i = 0; i<dots.size(); i++) {
    int x = (int)i%tilesX;
    int y = (int)i/tilesX;
    c = averageColor(source, x*tileW, y*tileH, tileW, tileH);
    b = brightness(c);
    dots.get(i).setBrightness(b);
    
  }
}
