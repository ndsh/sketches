class Dot {
  boolean state = false;
  boolean animate = true;
  PVector pos = new PVector(0, 0);
  float size = 0;
  float rotation;
  float increment;
  long timestamp = 0;
  int displayMode = 0; // 0 = ellipse / 1 = rect / 2 = line
  boolean displayFill = true;
  float brightness = 0;

  public Dot(float flipdotSize) {
    size = flipdotSize;
    rotation = size*1;
    
    //increment = size*(size/20);
    increment = size*0.85;
    
  }

  public Dot(float x, float y, float flipdotSize) {
    size = flipdotSize;
    rotation = size*1;
    //increment = size*(size/20);
    increment = size*0.85;
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
    if(displayFill) noStroke();
    else noFill();

    if(displayFill) {
      //if (state) fill(white);
      //else fill(black);
      stroke(black);
      fill(brightness);
    } else {
      if (state) stroke(white);
      else stroke(black);
    }
    translate(pos.x, pos.y);

    //rotate(radians(-45));
    if(displayMode == 0) ellipse(0, 0, size, rotation);
    else if(displayMode == 1) rect(0, 0, size, rotation);
    else if(displayMode == 2) line(0, 0, size, rotation);
    else if(displayMode == 3) triangle(0, 0, 0, size, 0, rotation);
    else if(displayMode == 4) arc(0, 0, size, rotation, 0, PI);
    pop();
  }
  
  void display(PGraphics pg) {
    
    pg.push();
    
    if(displayFill) pg.noStroke();
    else pg.noFill();

    if(displayFill) {
      //if (state) fill(white);
      //else fill(black);
      //pg.stroke(black);
      pg.fill(brightness);
    } else {
      //if (state) pg.stroke(white);
      //else pg.stroke(black);
    }
    pg.translate(pos.x, pos.y);

    //rotate(radians(-45));
    if(displayMode == 0) pg.ellipse(0, 0, size, rotation);
    else if(displayMode == 1) pg.rect(0, 0, size, rotation);
    else if(displayMode == 2) pg.line(0, 0, size, rotation);
    else if(displayMode == 3) pg.triangle(0, 0, 0, size, 0, rotation);
    else if(displayMode == 4) pg.arc(0, 0, size, rotation, 0, PI);
    pg.pop();
  }
  
  
  void setMode(int m) {
    displayMode = m;
  }
  
  void setFilling(boolean b) {
    displayFill = b;
  }

  void flip() {
    state = !state;
    animate = true;
  }

  void flip(boolean b) {
    if (b != state) animate = true; 
    state = b;
  }
  
  void setBrightness(float f) {
    brightness = f;
  }
  
  void setSize(float f) {
    size = f;
    rotation = size*1;
  }
  
  void setPos(float x, float y) {
    pos = new PVector(x, y);
  }
  
  PVector getCoordinates() {
    return pos;
  }
}
