class Tex {
  // holds a texture that is 32*32 pixels
  int progression = 0;
  int offset = 0;
  int steps = 5;
  int loopWhen = 8;
  
  int posX[] = {10, 20, 30, 40, 50, 60, 55, 44, 33, 22, 54, 54, 12, 56, 89, 63, 23, 10, 20, 30, 40, 50, 60, 55, 44, 33, 22, 54, 54, 12, 56, 89, 63, 23};
  //int posX[] = {7, 32, 48, 1, 33, 63, 23, 42, 47};
  
  int posY[] = {33, 44, 55, 42, 50, 60, 55, 44, 33, 22, 54, 54, 12, 56, 89, 63, 23, 33, 44, 55, 42, 50, 60, 55, 44, 33, 22, 54, 54, 12, 56, 89, 63, 23};
  //int posY[] = {16, 62, 1, 23, 63, 33, 12, 15, 43};
  int offsets[] = {3, 2, 1, 3, 4, 0, 2, 3, 1, 2, 3, 1, 2, 3, 4, 2, 3, 1, 2, 3, 2, 1, 3, 4, 0, 2, 3, 1, 2, 3, 1, 2, 3, 4, 2, 3, 1, 2};
  int prevs[] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
  int intervals[] = {100, 200, 300, 150, 300, 800, 500, 400, 50, 59, 22, 37, 54, 34, 78, 34, 234, 100, 200, 300, 150, 300, 800, 500, 400, 50, 59, 22, 37, 54, 34, 78, 34, 234};
  
  int pixelSize = 2;
  
  PGraphics pg;
  
  long previousMillis = 0;
  long interval = 100;
  
  public Tex(int _i) {
    pg = createGraphics(64, 64);
    pg.beginDraw();
    pg.background(0);
    pg.noStroke();
    pg.endDraw();
    interval = _i;
  }
  
  void update() {
    if(millis() - previousMillis < interval) return;
    previousMillis = millis();
    pg.beginDraw();
    pg.fill(255);
    for(int j = 0; j<posX.length; j++) {
      if(millis() - prevs[j] > intervals[j]) {
        prevs[j] = millis();
        pg.rect(posX[j], (posY[j]-offset*pixelSize), pixelSize, pixelSize);
      }
    }
    
    offset++;
    offset %= steps;
   
    pg.fill(0,60);
    pg.rect(0, 0, pg.width, pg.height);
    pg.endDraw();
    progression++;
  }
  
  void setParameters() {
    interval = (int)random(100, 270);
    for(int i = 0; i<intervals.length; i++) {
      intervals[i] = (int)random(500);
      posX[i] = (int)random(64);
      posY[i] = (int)random(64);
    }
  }
  
  void display() {
  }
  
  PGraphics getDisplay() {
    return pg;
  }
}
