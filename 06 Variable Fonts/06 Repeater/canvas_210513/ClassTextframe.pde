class Textframe {
  PVector pos;
  PGraphics pg;
  //int copies = 30;
  float origin = 0;
  float max;
  boolean reachDest = false;
  
  long timestamp = 0;
  long interval = 2000;
  int localCopies = copies;
  int newCopies = 0;
  PVector orientation;
  
  
  Textframe(String s) {
    orientation = new PVector(int(random(1))*180, int(random(1))*180, int(random(1))*180);
    max = (pgSize + (pgSize/2));
    pos = new PVector(0, 0, 0);
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
    pg.noFill();
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
    
    
    for(int i = 0; i<newCopies; i++) {
      float divX = pos.x/newCopies;
      float calc = divX*(log(i));


      //float m = map(divX*i, 0, 600, 0, log(20));
      //float m = mapLog(i, 0, 600, 0.0, 1.0);
      float p = map(divX*i, 0, divX*newCopies, origin, pos.x);
      push();
      rotateX(radians(orientation.x));
      rotateY(radians(orientation.y));
      rotateZ(radians(orientation.z));
      translate(pos.x, pos.y, -30*i);
      
      
      image(pg, 0, 0);
      pop();
    }
    push();
    rotateX(radians(orientation.x));
    rotateY(radians(orientation.y));
    rotateZ(radians(orientation.z));
    translate(pos.x, pos.y);
    
    image(pg, 0, 0);
    pop();
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
  
  
  void setCopies(int i) {
    newCopies = i;
  }
  
  int getCopies() {
    return newCopies;
  }
}
