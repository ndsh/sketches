
import processing.video.*;

Dither d;
Panel panel;
Movie myMovie;

PImage p;
float flipdotSize = 6;
float flipdotSpacing = 6.1;
int panelLayout = 1;
boolean sendMode = false;

color white = 255;
color black = 0;
int xDots = 100;
int yDots = 100;
boolean change = false;

void setup() {
  size(600, 600);
  d = new Dither();
  d.setMode(1);
  p = loadImage("medusa.jpg");
  
  panel = new Panel(0, 0, 0, xDots, yDots);
  myMovie = new Movie(this, "ok.mp4");
  myMovie.loop();
  surface.setLocation(0,0);
  colorMode(HSB, 360, 100, 100);
  white = color(0, 0, 100);
  black = color(0, 0, 0);  
}

void draw() {
  if(change) {
    background(black);
    //myMovie.resize(400, 400);
    //d.feed(myMovie);
    //panel.feed(d.dither());
    panel.feed(myMovie);
    
    //panel.display();
    image(panel.getDisplay(), -1, -1);
    //image(d.dither(), 0, 0);
    //image(myMovie, 0, 0);
    change = false;
  }
  // get random outputs
  
  // ask the dither object just for the calculated dither image instead of going to a mode directly
  
}

void movieEvent(Movie m) {
  m.read();
  change = true;
}
