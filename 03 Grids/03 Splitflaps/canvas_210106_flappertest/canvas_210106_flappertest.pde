int r = 20;

void setup() {
  size(200, 200);
  surface.setLocation(0, 0);
  rectMode(CENTER);
}

void draw() {
  background(255);
  rect(width/2, height/2, 20, r);
  r--;
  if(r < 0) r = 20;
}
