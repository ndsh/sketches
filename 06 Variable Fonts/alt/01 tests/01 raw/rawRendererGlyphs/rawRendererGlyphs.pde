  
//import processing.pdf.*;

void setup() {
  //size(500, 500, PDF, "TypeDemo.pdf");
  size(500, 500, P3D);
  beginRaw(DXF, "ding.dxf");
  textMode(SHAPE);
  textSize(180);
}

void draw() {
  background(125);
  text("ABC", 75, 350);
  endRaw();
  //exit();  // Quit the program
}
