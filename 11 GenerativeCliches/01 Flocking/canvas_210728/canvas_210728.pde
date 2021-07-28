// impleentation of flock that can stick to a background image
import processing.video.*;

PGraphics pg;
Movie frame;
StickyFlock stickyFlock;
color globalColor = 0;

boolean ready = false;
int frameNr = 0;

void setup() {
  size(600, 600, P2D);
  frameRate(30);
  surface.setLocation(0, 0);
  
  //frame = loadImage("a.png");
  frame = new Movie(this, "fade.mp4");
  frame.loop();
  
  delay(500);
  
  pg = createGraphics(width, height);

  // STICKYFLOCK
  stickyFlock = new StickyFlock();
  // Add an initial set of boids into the system
  for (int i = 0; i < 800; i++) {
    //stickyFlock.addBoid(new StickyBoid(width/2, height/2, 10));
    stickyFlock.addBoid(new StickyBoid(random(width), random(height), 20));
  }

  
}

void draw() {
  if(ready) {
  background(0);
  frame.loadPixels();
  pg.beginDraw();
  pg.clear();
  pg.ellipseMode(CENTER);
  stickyFlock.run(pg);
  pg.endDraw();
  
  image(frame, 0, 0, 0, 0);
  image(pg, 0, 0);
  ready = false;
  saveFrame("export/" + frameNr + ".png");
  frameNr++;
  }
  /*
  push();
  fill(globalColor);
  stroke(255, 255, 0);
  rect(0, 0, 20, 20);
  pop();
  */
}

void movieEvent(Movie m) {
  m.read();
  ready = true;
}
