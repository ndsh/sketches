class Tex {
  PGraphics pg;
  // 5x5 text
  // a 1 bit pattern gets translated into
  
  int xStep;
  int yStep;
  
  public Tex(int w, int h, int stepX, int stepY, int pixelSize) {
    pg = createGraphics(w, h);
    pg.beginDraw();
    pg.noStroke();
    pg.fill(foregroundColor);
    // every n-th step
    
    xStep = stepX;
    yStep = stepY;
    
    for(int x = 0; x<w; x++) {
      for(int y = 0; y<h; y++) {
        if((x % stepX == 0 && x != stepX) && (y % stepY == 0 && y != stepY)) {
          pg.rect(x,y, pixelSize, pixelSize);
          //pg.point(x,y);
        }
      }
    }
    
    pg.endDraw();
  }
  
  void update() {
  }
  
  void display() {
  }
  
  PGraphics getDisplay() {
    return pg;
  }
  
  PVector pixelSize() {
    return new PVector(xStep, yStep);
  }
}
