import processing.video.*;

Movie myMovie;
Dither d;
PImage p;

void setup() {
  size(600, 600);
  myMovie = new Movie(this, "export.mp4");
  myMovie.loop();
  surface.setLocation(0,0);
  colorMode(HSB, 360, 100, 100);
  p = loadImage("medusa.jpg");
  d = new Dither();
  //d2 = new Dither("sample.jpg");
  d.setCanvas(600, 600);
  
  
  // example of how to set the modes differently via d2 object
  //d2.setMode("RANDOM");
  //d2.setMode(3);
  d.setMode(3);
}

void draw() {
  background(0);
  
  
  
  // get random outputs
  
  // ask the dither object just for the calculated dither image instead of going to a mode directly
  d.feed(myMovie);
  image(d.dither(), 0, 0);
}

void movieEvent(Movie m) {
  m.read();
  
}
