class Textframe {
  PVector pos;
  PGraphics pg;
  //int copies = 30;
  float origin = 0;
  float max;
  boolean reachDest = false;
  
  Textframe(String s) {
    max = (pgSize + (pgSize/2));
    pos = new PVector(-max, 0);
    pg = createGraphics((int)max, height);
    init(s);
  }
  
  void init(String s) {
    int len = 1;
    if(s.length() != 0) len = s.length();
    float div = pg.height/len;
    
    pg.beginDraw();
    
    pg.background(black);
    pg.fill(black);
    pg.stroke(white);
    pg.strokeWeight(2);
    pg.noFill();
    pg.rect(0, 0, pg.width, pg.height);
    pg.fill(white);
    
    pg.textFont(font);
    pg.textAlign(CENTER, CENTER);
    for(int i = 0; i<s.length(); i++) {
      pg.text(s.charAt(i), pg.width/2, div*i + (div/2));
    }
    pg.endDraw();
  }
  
  void display() {
    // map currentX position of frame to the left of the beginning of the frame
    // distribute logaritmically
    for(int i = 0; i<copies; i++) {
      float divX = pos.x/copies;
      float calc = divX*(log(i));


      //float m = map(divX*i, 0, 600, 0, log(20));
      //float m = mapLog(i, 0, 600, 0.0, 1.0);
      float p = map(divX*i, 0, divX*copies, origin, pos.x);
      image(pg, p, pos.y);
      
    }
    image(pg, pos.x, pos.y);
  }
  

  void update() {
  }
  
  void addX(float x) {
    if(!reachDest) {
      pos.x += x;
    } else {
      origin += x;
    }
    //pos.x %= width;
    
    if(pos.x >= (width-max) && !reachDest) {
      reachDest = true;
      pos.x = width-max;
    } else if(origin >= width && reachDest) {
      reachDest = false;
      origin = 0;
      pos.x = -max;
      
    }
  }
  
  void setX(float x) {
    pos.x = x;
    pos.x %= width;
  }
  
  void setY(float y) {
    pos.y = y;
  }
  
  void setOrigin(float o) {
    origin = o;
  }
  
  boolean getReach() {
    return reachDest;
  }
  
}
