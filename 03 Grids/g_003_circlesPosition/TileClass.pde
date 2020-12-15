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
    
    random = (int)random(3);
    
    PVector p = new PVector();
    
    switch(random) {
      case 0:
        p.x = pg.width/2;
        p.y = 0;
      break;
      
      case 1:
        p.x = pg.width;
        p.y = pg.height/2;
      break;
      
      case 2:
        p.x = pg.width/2;
        p.y = pg.height;
      break;
      
      case 3:
        p.x = 0;
        p.y = pg.height/2;
      break;
    } 
    
    
    float geoSize = (size/3)*2;
    
    pg.beginDraw();
    pg.translate(p.x, p.y);
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
