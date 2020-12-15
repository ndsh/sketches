/*
  CANVAS
  Instagram Experiments with system animations, dither and dots
*/
import processing.video.*;
Movie myMovie;
Canvas canvas;
PGraphics pg;
PImage p;

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
  size(600, 600);
  surface.setLocation(0, 0);
  
  p = loadImage("test.jpg");
  canvas = new Canvas(128, 128, 0, 5);
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
    save("export/"+folderFormat+"/"+ frameNr +".tga");
    frameNr++;
  }
}

void keyPressed() {
  canvas.flip();
}

void movieEvent(Movie m) {
  m.read();
  change = true;
}

String leadingZero(int i) {
  String s = ""+i;
  if(i < 10) return s = "0"+s;
  else return s;
}
