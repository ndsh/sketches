/*
  CANVAS
  Instagram Experiments with system animations, dither and dots
  
  Bug: Movie is not full size
*/
import processing.video.*;
Movie myMovie;
Canvas canvas;
PGraphics pg;
PImage p;
boolean export = false;

color white = color(255);
color black = color(0);

boolean change = false;

String y = year()+"";
String m = leadingZero(month());
String d = leadingZero(day());
String h = leadingZero(hour());
String i = leadingZero(minute());
String s = leadingZero(second());
String folderFormat = y + m + d + "_" + h + i + s;

int frameNr;

void setup() {
  // dont use noSmooth() with Big Sur. it'll crash your system.
  size(600, 600, P2D);
  frameRate(30); // Big Sur fix for P2D. SAD!
  surface.setLocation(0, 0);
  
  p = loadImage("test.jpg");
  canvas = new Canvas(64, 64, 1, 5);
  canvas.feed(p);
  
  myMovie = new Movie(this, "ok.mp4");
  myMovie.loop();
}

void draw() {
  if(change) {
    background(0);
    canvas.feed(myMovie);
    canvas.update();
    canvas.display();
    change = false;
    
    if(export) {
      save("export/"+folderFormat+"/"+ frameNr +".tga");
      frameNr++;
    }
  }
}
