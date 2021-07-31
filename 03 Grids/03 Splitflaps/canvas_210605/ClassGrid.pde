class Grid {
  PGraphics pg;
  PGraphics brightnessGrid;
  Splitflap[] flaps;
  String sortedCharacters = "";
  int brightnessSensitivity = 255; // value after which a pixel is considered "bright"
  // densities look up table
  int[] densities2;
  int spriteSize = 20;
  PFont font;
  int maxDensity = spriteSize*spriteSize;
  int gridSize;
  float[] tileSize = {0, 0};
  int nuance;
  int amount;
  
  ArrayList<Density> densities = new ArrayList<Density>();
  PImage target = null;
  
  public Grid(float w, float h, String charset, String fontName, int _gridSize, float interval, float cooldown) {    
    font = loadFont(fontName);
    gridSize = _gridSize;
    if(gridSize == 0) gridSize = 1;
    tileSize[0] = w/gridSize;
    tileSize[1] = h/gridSize;
    nuance = charset.length(); // the different nuances or densities we have. basically the amount of chars
    amount = gridSize*gridSize;
    //amount = tileSize[]|;
    flaps = new Splitflap[amount];

    
    println("grid=" + gridSize + "x" + gridSize + " / tiles= " + tileSize[0] + "x" + tileSize[1] + "px");
    
    pg = createGraphics(spriteSize, spriteSize);
    pg.beginDraw();
    pg.textFont(font);
    pg.textSize(tileSize[0]);
    pg.textAlign(CENTER, CENTER);
    pg.endDraw();
    textFont(font);
    textSize(tileSize[0]);
    rectMode(CENTER);
    textAlign(CENTER, CENTER);
    
    // build densities
    println("Calculating densities. This may take a second or two");
    for(int i = 0; i<charset.length(); i++) {
      pg.beginDraw();
      pg.clear();
      pg.text(charset.charAt(i), pg.width/2, pg.height/2);
      pg.endDraw();
      densities.add(new Density(getDensity(pg), charset.charAt(i)));
    }
    
    Collections.sort(densities);
    for(int i = 0; i<densities.size(); i++) sortedCharacters += densities.get(i).getCharacter();
    println("Done!");
    
    println("Building Splitflap objects");
    int x = 0;
    int y = 0;
    for(int i = 0; i<amount; i++) {
      flaps[i] = new Splitflap((x*tileSize[0]) + (tileSize[0]/2), (y*tileSize[1]) + (tileSize[1]/2), nuance, sortedCharacters, interval, cooldown, tileSize);
      x++;
      if(x >= gridSize) {
        x = 0;
        y++;
      }
    }
    println("Done!");
    
    // create the canvas of the grid
    pg = createGraphics((int)w, (int)h);
    pg.beginDraw();
    pg.rectMode(CENTER);
    pg.textFont(font);
    pg.textSize(tileSize[0]);
    pg.textAlign(CENTER, CENTER);
    pg.endDraw();
    
    brightnessGrid = createGraphics((int)w, (int)h);
    brightnessGrid.beginDraw();
    brightnessGrid.textFont(font);
    brightnessGrid.rectMode(CENTER);
    brightnessGrid.textAlign(CENTER, CENTER);
    brightnessGrid.endDraw();
  }
  
  void update() {
    color c = 0;
    float b = 0;
    brightnessGrid.beginDraw();
    brightnessGrid.clear();
    
    brightnessGrid.noStroke();
    for(int y = 0; y<gridSize; y++) {
      for(int x = 0; x<gridSize; x++) {
        c = averageColor(target, x*tileSize[0], y*tileSize[1], tileSize[0], tileSize[1]);
        b = brightness(c);
        
        brightnessGrid.push();
        brightnessGrid.fill(b);
        brightnessGrid.rect(x*tileSize[0], y*tileSize[1], tileSize[0], tileSize[1]);
        brightnessGrid.pop();
        
        int t = y*gridSize+x;
        int mapped = 0;
        if(!toggleBrightnessFlip) mapped = (int)map(b, 0, 255, 0, sortedCharacters.length()-1);
        else mapped = (int)map(b, 0, 255, sortedCharacters.length()-1, 0);
        //print(nf(mapped, 2) + " ");
        flaps[t].setTarget(mapped);
        flaps[t].update();    
      }
      //println();
    }
    brightnessGrid.endDraw();
    //println();
  }
  
  void display() {
    background(0);
    fill(255);
    noStroke();
    for(int i = 0; i<flaps.length; i++) {      
      flaps[i].display();
    }
  }
  
  PImage getDisplay() {
    pg.beginDraw();
    pg.background(0);
    //pg.fill(255);
    pg.noStroke();
    for(int i = 0; i<flaps.length; i++) {      
      flaps[i].display(pg);
    }
    pg.endDraw();
    return pg;
  }
  
  PImage getBrightnessGrid() {
    return brightnessGrid;
  }
  
  void feed(PImage p) {
    target = p;
  }
  
  int getDensity(PImage p) {
    color c = 0;
    int count = 0;
    p.loadPixels();
    for(int y = 0; y<p.width; y++) {
      for(int x = 0; x<p.height; x++) {
        c = p.pixels[y*p.width+x];
        if(brightness(c) >= brightnessSensitivity) count++;
      }
    }
    //println("density=" + count);
    return count;
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
  
  void updateInterval(float f) {
    for(int i = 0; i<flaps.length; i++) {      
      flaps[i].updateInterval(f);
    }
  }
  
  void updateCooldown(float f) {
    for(int i = 0; i<flaps.length; i++) {      
      flaps[i].updateCooldown(f);
    }
  }
  
  float[] getTilesize() {
    return tileSize;
  } 

}
