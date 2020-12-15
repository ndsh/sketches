class Tile{
  PGraphics pg;
  int size;
  int x;
  int y;
  int bg;
  int random;
  
  Tile(int _size, int _x, int _y) {
    size = _size;
    x = _x*size;
    y = _y*size;
    
    pg = createGraphics(size, size);
    pg.beginDraw();
    pg.background(random(255));
    pg.endDraw();
  }
  
  void display() {
    image(pg, x, y);
  }
  
  void update() {
  }
  
  PImage getDisplay() {
    return pg;
  }
} 
