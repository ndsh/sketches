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
    random = (int)random(4);
    
    pg = createGraphics(size, size);
    float geoSize = (size/3)*2;
    
    pg.beginDraw();
    pg.translate(pg.width/2, pg.height/2);
    pg.stroke(random(255));
    pg.strokeWeight(2);
    pg.noFill();
    pg.ellipse(0, 0, geoSize, geoSize); 
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
