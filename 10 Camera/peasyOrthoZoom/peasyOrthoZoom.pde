import peasy.*;
PeasyCam cam;
boolean isOrtho = true;
float zoomRatio = 1.0;


void setup() {
  size(500, 500, P3D);
  surface.setLocation(0, 0);
  frameRate(30);
  
  cam = new PeasyCam(this, 100);
  cam.setMinimumDistance(50);
  cam.setMaximumDistance(500);  
}
void draw() {
  
  if (isOrtho) {
    ortho(-width / 2*zoomRatio, width / 2*zoomRatio, -height / 2*zoomRatio, height / 2*zoomRatio, 0, 1000);
  } else {
    perspective();
  }
  
  rotateX(-.5);
  rotateY(-.5);
  background(0);
  fill(255, 0, 0);
  box(30);
  pushMatrix();
  translate(0, 0, 20);
  fill(0, 0, 255);
  box(5);
  popMatrix();

  textSize(10);
  textAlign(LEFT);
  fill(225, 255, 255);
  if (isOrtho) {
    text("ortho view", width/15, 0);
  } else {
    text("perspective view", width/15, 0);
  }  
  
}

void keyPressed() {
  if (key=='c') {
    if (isOrtho) {
      toPerspetive();
    } else {
      toOrtho();
    }
  }
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();

  zoomRatio += e/20;
  if (zoomRatio>1.2) {
    zoomRatio =1.2;
  }
  if (zoomRatio < 0.1) {
    zoomRatio = 0.1;
  }
}

void toPerspetive() {
  cam.setDistance(map(zoomRatio, 0.1, 1.2, 50, 500));
  isOrtho = !isOrtho;
}

void toOrtho() {
  zoomRatio = map((float)cam.getDistance(), 50, 500, 0.1, 1.2);
  isOrtho = !isOrtho;
}
