// what do we need for a carrot?
// 5 point for the carrot
// 3 rectangles for the green


class Carrot {
  
  PGraphics pg;
  boolean setPoints[] = {false, false, false, false, false};
  int maxStep = 5;
  PVector positions[] = new PVector[maxStep];
  int step = 0;
  
  
  long previousMillis = 0;
  long interval = 120;
  
  float segmentsH;
  float segmentsW;
  
  int pixelSize = 4;
  
  public Carrot(int w, int h) {
    pg = createGraphics(w, h);
    pg.beginDraw();
    pg.background(240);
    
    pg.fill(0);
    pg.endDraw();
    segmentsH = h/12;
    segmentsW = w/12;
  }
  
  void update() {
    pg.beginDraw();
    if(millis() - previousMillis > interval) {
      previousMillis = millis();
      if(!setPoints[step] && step == 0){ // step 1
        
        pg.clear();
        pg.background(240);
        positions[step] = new PVector(random(segmentsW*3, segmentsW*8), random(segmentsH*10, segmentsH*12));
        
      } else if(!setPoints[step]  && step == 1) {
        positions[step] = new PVector(random(segmentsW*8, segmentsW*9), random(segmentsH*4, segmentsH*6));
      } else if(!setPoints[step]  && step == 2) {
        positions[step] = new PVector(random(segmentsW*7, segmentsW*8), random(segmentsH*3, segmentsH*5));
      } else if(!setPoints[step]  && step == 3) {
        positions[step] = new PVector(random(segmentsW*4, segmentsW*5), random(segmentsH*3, segmentsH*5));
      } else if(!setPoints[step]  && step == 4) {
        positions[step] = new PVector(random(segmentsW*3, segmentsW*4), random(segmentsH*4, segmentsH*6));
        
      } 
      pg.rect((int)positions[step].x, (int)positions[step].y, pixelSize, pixelSize);
      if(step != 0) pg.line(positions[step-1].x+pixelSize/2, positions[step-1].y+pixelSize/2, positions[step].x+pixelSize/2, positions[step].y+pixelSize/2);
      setPoints[step] = true;
      step++;
      if(step >= maxStep) {
        
        step = 0;
        pg.line(positions[step].x+pixelSize/2, positions[step].y+pixelSize/2, positions[maxStep-1].x+pixelSize/2, positions[maxStep-1].y+pixelSize/2);
        
        PVector lin0 = new PVector();
        float leng = random(3, 30);
        for(int i = 0; i<2; i++) {
          if(i == 0) {
            lin0 = new PVector((positions[1].x+positions[0].x)/2, (positions[1].y+positions[0].y)/2);
            pg.line(lin0.x+pixelSize/2, lin0.y+pixelSize/2, (lin0.x+pixelSize/2)-leng, (lin0.y+pixelSize/2)-leng);
          } else if(i == 1) {
            lin0 = new PVector((positions[4].x+positions[0].x)/2, (positions[0].y+positions[4].y)/2);
            pg.line(lin0.x+pixelSize/2, lin0.y+pixelSize/2, (lin0.x+pixelSize/2)+leng, (lin0.y+pixelSize/2)+leng);
          }
        } 
        
        // reset
        for(int i = 0; i<setPoints.length; i++) setPoints[i] = false;
      }
    }
    
    pg.endDraw();
  }
  
  void display() {
    pg.beginDraw();
    //pg.background(220);
    pg.pushStyle();
    pg.fill(240, 10);
    pg.noStroke();
    //pg.rect(0, 0, pg.width, pg.height);
    pg.popStyle();
    pg.endDraw();
  }
  
  PGraphics getDisplay() {
    return pg;
  }
}
