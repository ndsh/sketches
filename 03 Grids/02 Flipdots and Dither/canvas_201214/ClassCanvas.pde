class Canvas {
  // A Canvas takes an input PImage or PGraphics
  // and rasterizes it on a square or rectangular grid
  // it start at 0,0
  
  int gX = 0;
  int gY = 0;
  
  float sizeX = 0;
  float sizeY = 0;
  
  float margin = 0;
  
  PGraphics pg;
  PImage source;
  
  ArrayList<Dot> dots;
  
  float size = 0;
  int padding = 0;
  
  public Canvas(int _x, int _y, float _margin, int _padding) {
    dots = new ArrayList<Dot>();
    
    gX = _x; // how many dots in x
    gY = _y; // how many dots in y
    
    pg = createGraphics(width, height);
    
    sizeX = pg.width/gX;
    sizeY = pg.width/gY;
    size = sizeX;
    padding = _padding;
    
    margin = _margin;
    
    for(int x = 0; x<gX; x++) {
      for(int y = 0; y<gY; y++) {
        // size + offset - margin
        
        dots.add(new Dot( 
          (sizeX*x) + (sizeX/2) - (margin*x),
          (sizeY*y) + (sizeY/2) - (margin*y),
        sizeX-(margin*2)));
        
        /*
        dots.add(new Dot( 
          (sizeX*x) + (sizeX/2) - (margin*x) + ( (((width-(margin*gX))/2)/gX)/2 ),
          (sizeY*y) + (sizeY/2) - (margin*y) + ( (((height-(margin*gY))/2)/gY)/2 ),
        sizeX-(margin*2)));
        */
      }
    }
    
  }
  
  void update() {
    // grid calculations here
    color c = 0;
    float b = 0;
    for(int i = 0; i<gX; i++) {
      for(int j = 0; j<gY; j++) {
        c = averageColor(source, i*sizeX, j*sizeY, sizeX, sizeY);
        b = brightness(c);
        if(b < 255/2) dots.get(i*gX+j).flip(false);
        else dots.get(i*gX+j).flip(true);
      }
    }
    for(int i = 0; i<dots.size(); i++) {
      dots.get(i).update();
    }
  }
  
  void display() {
    for(int i = 0; i<dots.size(); i++) {
      dots.get(i).display();
    }
  }
  
  PGraphics getDisplay() {
    return pg;
  }
  
  void feed(PImage p) {
    source = p;
  }
  
  void flip() {
    for(int i = 0; i<dots.size(); i++) {
      dots.get(i).flip();
    }
  }
  
  color averageColor(PImage source, float x, float y, float w, float h) {
    PImage temp = source.get((int)x, (int)y, (int)w, (int)h);
    temp.loadPixels();
    int r = 0;
    int g = 0;
    int b = 0;
    
    for (int i=0; i<temp.pixels.length; i++) {
      color c = temp.pixels[i];
      r += c>>16&0xFF;
      g += c>>8&0xFF;
      b += c&0xFF;
    }
    r /= temp.pixels.length;
    g /= temp.pixels.length;
    b /= temp.pixels.length;
   
    return color(r, g, b);
  }
}
