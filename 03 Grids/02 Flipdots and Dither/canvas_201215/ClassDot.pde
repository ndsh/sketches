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

  public Dot(float flipdotSize) {
    size = flipdotSize;
    rotation = size*1;
    
    increment = size*(size/20);
    
  }

  public Dot(float x, float y, float flipdotSize) {
    size = flipdotSize;
    rotation = size*1;
    increment = size*(size/20);
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
      if (state) fill(white);
      else fill(black);
    } else {
      if (state) stroke(white);
      else stroke(black);
    }
    translate(pos.x, pos.y);

    rotate(radians(-45));
    if(displayMode == 0) ellipse(0, 0, size, rotation);
    else if(displayMode == 1) rect(0, 0, size, rotation);
    else if(displayMode == 2) line(0, 0, size, rotation);
    else if(displayMode == 3) triangle(0, 0, 0, size, 0, rotation);
    else if(displayMode == 4) arc(0, 0, size, rotation, 0, PI);
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
}
