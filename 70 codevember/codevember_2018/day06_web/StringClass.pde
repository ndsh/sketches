class WebString {
  PGraphics pg;
  
  float xoff = 0.0;
  float xincrement = 0.01;
  
  float yoff = 0.0;
  float yincrement = 0.025;
  
  public WebString(float thickness) {
    pg = createGraphics(600, 600, P3D);
    pg.beginDraw();
    pg.smooth();
    pg.endDraw();
  }
  
  void update() {
    float n = map(noise(xoff, yoff), 0, 1, pg.height/2, pg.height);
    float m = map(noise(yoff, xoff), 0, 1, pg.height/2, pg.height);
    xoff += xincrement;
    yoff += yincrement;
      
    pg.beginDraw();
    pg.noFill();
    pg.stroke(255);
    pg.strokeWeight(2);
    pg.pushStyle();
    pg.fill(0, 50);
    pg.noStroke();
    pg.rect(0, 0, pg.width, pg.height);
    pg.popStyle();
    pg.beginShape();
    
    pg.vertex(50, pg.height/2, 0);
    //bezierVertex(x2, y2, z2, x3, y3, z3, x4, y4, z4)
    pg.bezierVertex(
      0, n, 0, 
      n, m, 0, 
      width-50, height/2, 0);
    pg.endShape();
    pg.endDraw();
  }
  
  void display() {
  }
  
  PGraphics getDisplay() {
    return pg;
  }
}
