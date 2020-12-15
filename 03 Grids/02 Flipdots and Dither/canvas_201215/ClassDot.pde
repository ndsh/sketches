class Dot {
  boolean state = false;
  boolean animate = true;
  PVector pos = new PVector(0, 0);
  float size = 0;
  float rotation;
  float increment;
  long timestamp = 0;

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
