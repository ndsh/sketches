// impleentation of flock that can stick to a background image

PGraphics pg;
StickyFlock stickyFlock;
PImage frame;
color globalColor = 0;

void setup() {
  size(600, 600);
  surface.setLocation(0, 0);
  pg = createGraphics(width, height);

  // STICKYFLOCK
  stickyFlock = new StickyFlock();
  // Add an initial set of boids into the system
  for (int i = 0; i < 600; i++) {
    stickyFlock.addBoid(new StickyBoid(width/2, height/2, 7));
  }

  frame = loadImage("f.png");
}

void draw() {
  background(0);
  frame.loadPixels();
  pg.beginDraw();
  pg.clear();
  pg.ellipseMode(CENTER);
  stickyFlock.run(pg);
  pg.endDraw();
  
  //image(frame, 0, 0);
  image(pg, 0, 0);
  /*
  push();
  fill(globalColor);
  stroke(255, 255, 0);
  rect(0, 0, 20, 20);
  pop();
  */
}
