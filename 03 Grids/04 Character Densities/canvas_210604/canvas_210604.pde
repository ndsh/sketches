String s = ".:;,#!2";
// densities look up table
int[] densities;
PGraphics pg;
int spriteSize = 20;
PFont font;

int maxDensity = spriteSize*spriteSize;

// order densities
// keep relation between densities and chars

void setup() {
  size(600, 600);
  surface.setLocation(0, 0);
  
  println("maxDensity=" + maxDensity);
  
  font = loadFont("InputMono-Regular-20.vlw");
  pg = createGraphics(spriteSize, spriteSize);
  pg.beginDraw();
  pg.textFont(font);
  pg.textAlign(CENTER, CENTER);
  pg.endDraw();
  
  // build densities
  densities = new int[s.length()];
  for(int i = 0; i<s.length(); i++) {
    pg.beginDraw();
    pg.clear();
    pg.text(s.charAt(i), pg.width/2, pg.height/2);
    pg.endDraw();
    densities[i] = getDensity(pg);
  } 
  
}

void draw() {
  background(0);
  
}

int getDensity(PImage p) {
  color c = 0;
  int count = 0;
  p.loadPixels();
  for(int y = 0; y<p.width; y++) {
    for(int x = 0; x<p.height; x++) {
      c = p.pixels[y*p.width+x];
      if(brightness(c) >= 255) count++;
    }
  }
  //println("density=" + count);
  return count;
}
