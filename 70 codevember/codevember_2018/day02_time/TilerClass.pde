class Tiler {
  
  PGraphics pg;
  ArrayList<Tex> texs = new ArrayList<Tex>();
  
  public Tiler() {
    pg = createGraphics(width, height);
    pg.beginDraw();
    pg.background(0);
    pg.endDraw();
    for(int i = 0; i< 19*19; i++) {
      texs.add(new Tex((int)random(100, 270)));
    }
    
  }
  
  void update() {
    for (Tex tex : texs) {
      tex.update();
    }    
  }
  
  void display() {
    
    pg.beginDraw();
    int c = 0;
    for(int x = 0; x<19; x++) {
      for(int y = 0; y<19; y++) {
        pg.image(texs.get(c).getDisplay(), x*32, y*32);
        c++;
      }
    }
    pg.endDraw();
  }
  
  void setParameters() {
    for (Tex tex : texs) {
      tex.setParameters();
    }
  }
  
  PGraphics getDisplay() {
    return pg;
  }
}
