Dot dot;
color white = color(255);
color black = color(0);
PGraphics pg;

void setup() {
  size(300, 300);
  surface.setLocation(0, 0);
  dot = new Dot(width/2, height/2, 10);
  pg = createGraphics(width, height);
  
}

void draw() {
  background(200);
  dot.update();
  dot.display();
}

void keyPressed() {
  dot.flip();
}
