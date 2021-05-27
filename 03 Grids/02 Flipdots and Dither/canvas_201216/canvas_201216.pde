/*
  CANVAS for Instagram Stories
  Instagram Experiments with system animations, dither and dots
  
  Bug: Movie is not full size
*/
import processing.video.*;
Movie myMovie;
Canvas canvas;
Dither dither;
PGraphics pg;
PImage p;
boolean export = true;

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
  size(1080, 1920);
  frameRate(30); // Big Sur fix for P2D. SAD!
  surface.setLocation(0, 0);
  
  dither = new Dither(100, 100);
  dither.setMode(1);
  
  //p = loadImage("test.jpg");
  canvas = new Canvas(90, 90, 4, 5);
  canvas.feed(p);
  canvas.setMode(1);
  canvas.setFilling(false);
  strokeWeight(1);
  
  myMovie = new Movie(this, "export.mp4");
  //myMovie.loop();
  myMovie.play();
  rectMode(CENTER);
}

void draw() {
  if(myMovie.available()) {
    myMovie.read();
    background(0);
    
    //if(change) {
      //dither.feed(myMovie);
      //canvas.feed(dither.dither());
    
      canvas.feed(myMovie);
      canvas.update();
    change = false;
    //}
    canvas.display();
    
    
    if(export) {
      save("export/"+folderFormat+"/"+ frameNr +".tga");
      frameNr++;
    }
  }
}
