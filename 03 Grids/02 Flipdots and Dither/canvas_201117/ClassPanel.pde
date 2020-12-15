class Panel {
  // 28x14 dots
  PGraphics pg;
  int panelID = 0;
  Dot[][] dots;
  PVector pos;

  PImage currentFrame; 
  boolean changeUp = false;
  boolean changeDown = false;
  int upBits = 0;
  int downBits = 0;
  boolean showIndicators = false;
  int dotsX;
  int dotsY;

  public Panel(int id, int _x, int _y, int _dotsX, int _dotsY) {
    panelID = id;
    dotsX = _dotsX;
    dotsY = _dotsY;
    dots = new Dot[dotsX][dotsY];
    pos = new PVector(_x, _y);
    pg = createGraphics(600, 600);
    for (int x = 0; x<dotsX; x++) {
      for (int y = 0; y<dotsY; y++) {
        dots[x][y] = new Dot(flipdotSize+flipdotSpacing*x, flipdotSize+flipdotSpacing*y);
      }
    }
  }

  void update() {



    // update visuals on flipdots
    for (int x = 0; x<dotsX; x++) {
      for (int y = 0; y<dotsY; y++) {
        dots[x][y].update();
      }
    }
  }
  
  PGraphics getDisplay() {
    pg.beginDraw();
    pg.clear();
    for (int x = 0; x<dotsX; x++) {
      for (int y = 0; y<dotsY; y++) {
        dots[x][y].displayPG();
      }
    }
    pg.endDraw();
    return pg;
  }

  void display() {
    push();
    translate(pos.x, pos.y);

    if (showIndicators) {
      push();
      noStroke();
/*
      if (!changeUp) fill(white);
      else fill(black);
      if (panelLayout == 0) {
        //rect(-(flipdotSize/2), 70, dotsX*(flipdotSize+1)-2, 1*(flipdotSize+1));
      } else if (panelLayout == 1) {
        //rect(140, -2, 27, 7*(flipdotSize+1)-2);
        ellipse(150, 13, 5, 5);
      }
      pop();

      push();
      noStroke();
      if (!changeDown) fill(white);
      else fill(black);
      if (panelLayout == 0) {
        rect(-(flipdotSize/2), 72+(1*(flipdotSize+1)), dotsX*(flipdotSize+1)-2, 1*(flipdotSize+1));
      } else if (panelLayout == 1) {
        //rect(140, 7*(flipdotSize+1)-2, 27, 7*(flipdotSize+1)-2);
        ellipse(150, 7*(flipdotSize+1.0f)+5, 5, 5);
      } 
*/
      pop();
    }

    for (int x = 0; x<dotsX; x++) {
      for (int y = 0; y<dotsY; y++) {
        dots[x][y].display();
      }
    }
    pop();
  }

  void updateFrame(PImage p) {

    feed(p);
  }

  void feed(PImage p) {
    PGraphics pt = createGraphics(600, 600);
    pt.beginDraw();
    pt.image(p, 0, 0, xDots, yDots);
    pt.endDraw();
    currentFrame = pt;
    currentFrame.loadPixels();
    color c = 0;
    boolean state = false;
    for (int x = 0; x<dotsX; x++) {
      for (int y = 0; y<dotsY; y++) {
        c = currentFrame.pixels[y*currentFrame.width+x];
        //println(brightness(c));
        if (pt.brightness(c) >= 50) state = true;
        else state = false;
        dots[x][y].flip(state);
      }
    }
  }

  void setPixel(int x, int y, boolean b) {
    dots[x][y].flip(b);
  }

  int getPanelID() {
    return panelID;
  }






  boolean sameArray(byte[] a, byte[] b) {

    boolean result = true;
    for (int i = 0; i<a.length; i++) {
      if (a[i] != b[i]) {
        result = false;
        break;
      }
    }
    return result;
  }



  void flip() { // eigentlich "invert"
    for (int x = 0; x<dotsX; x++) {
      for (int y = 0; y<dotsY; y++) {
        dots[x][y].flip();
      }
    }
  }



  boolean[] getChangeIndicator() {
    boolean[] result = {changeUp, changeDown};
    return result;
  }

  // BEGIN DOT CLASS
  class Dot {
    boolean state = false;
    boolean animate = false;
    PVector pos = new PVector(0, 0);
    float size = flipdotSize;
    float rotation;
    float increment;
    long timestamp = 0;

    public Dot() {
      rotation = size*1;
      increment = size/5;
    }

    public Dot(float x, float y) {
      rotation = size*1;
      increment = size/5.02;
      pos = new PVector(x, y);
    }

    void update() {
      if (animate) {
        if (state) {
          rotation += increment;
          if (rotation >= size) {
            animate = false;
            rotation = size;
              
          }
        } else {
          rotation -= increment;
          if (rotation < (size*-1)) {
            rotation = (size*-1);
            animate = false;
          }
        }
      }
    }

    void display() {
      push();
      noStroke();

      if (state) fill(white);
      else fill(black);
      translate(pos.x, pos.y);

      rotate(radians(-45));
      ellipse(0, 0, size, rotation);
      pop();
    }
    
    void displayPG() {
      pg.push();
      pg.noStroke();

      if (state) pg.fill(white);
      else pg.fill(black);
      pg.translate(pos.x, pos.y);

      pg.rotate(radians(-45));
      pg.ellipse(0, 0, size, rotation);
      pg.pop();
      
    }

    void flip() {
      state = !state;
      animate = true;
    }

    void flip(boolean b) {
      if (b != state) animate = true; 
      state = b;
    }
  }
  // END DOT CLASS
}
