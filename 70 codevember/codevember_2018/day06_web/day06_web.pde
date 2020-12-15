WebString web;

void setup() {
  size(600, 600, P3D);
  
  web = new WebString(1);
  noStroke();
}

void draw() {
  //background(0);
  web.update();
  image(web.getDisplay(), 0, 0);
  
}
