import peasy.*;

PeasyCam cam;

void setup() {
  size(200,200,P3D);
  frameRate(30);
  ortho(-width/2,width/2,-height/2,height/2,-200,200);

  cam = new PeasyCam(this, 100);
  cam.setMinimumDistance(50);
  cam.setMaximumDistance(500);
}
void draw() {
  rotateX(-.5);
  rotateY(-.5);
  background(0);
  fill(255,0,0);
  box(30);
  pushMatrix();
  translate(0,0,20);
  fill(0,0,255);
  box(5);
  popMatrix();
}
