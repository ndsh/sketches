// Spationierung von Text, Align LEFT/CENTER/RIGHT
// rotate in richtung in die geschoben wird
//https://www.behance.net/gallery/34417137/Brett-Reif

// zeile für zeile

import de.looksgood.ani.*;

PFont font;
String[] displayTexts = {"Sometimes", "you", "gotta work", "a little", "so you can", "ball", "a lot."};

int[] aniMaxFramesMove = {2, 6, 3, 2, 4, 3, 1};
int[][] aniMoveTiming = {
  {500, 500},
  {1000, 1000, 1000, 1000, 1000, 1000},
  {5000, 5000, 5000},
  
  {1000, 2500, 1000},
  {300, 300, 300, 300},
  {1000, 2500, 1000},
  
  {1000},
  
};
float[][] aniMovePattern = {
  {0.0, 1.0},
  {0.0, 0.0, 0.0, 1.0, 1.0, 1.0},
  {0.0, 1.0, 1.0},
  
  {1.0, 0.75},
  {0.0, 0.5, 1.0, 0.5},
  {0.0, 0.0, 0.0},
  
  {1.0},
};

int[] aniMaxFramesSpacing = {5, 2, 3, 1, 3, 3, 4};
int[][] aniSpacingTiming = {
  {1000, 2500, 1000, 2500, 100, 2500},
  {200, 200},
  {2500, 2500, 2500},
  
  {300, 300},
  {1000, 2500, 1000},
  {1000, 2500, 1000},
  
  {300, 300, 300, 300},
};
float[][] aniSpacingPattern = {
  {0.0, 0.25, 0.10, 0.25, 0.10},
  {1.0, 0.0},
  {0.0, 1.0, 0.0},
  
  {0.00},
  {0.0, 0.0, 0.0},
  {0.0, 0.0, 1.0},
  
  {1.0, 0.75, 0.5, 0.25},
};

ArrayList<Textframe> frames = new ArrayList<Textframe>();
int pgSize = 50;

color black = color(0);
color white = color(255);
color gray = color(125);


boolean record = false;
int frameCounter = 0;

float ca = 29;

void setup() {
  size(600, 600, P2D);
  frameRate(60);
//  pixelDensity(2);
  surface.setLocation(0, 0);
  
  font = loadFont("Annonce-40.vlw");
  textFont(font);
  
  ca = textAscent();
  ca = 85;
  Ani.init(this);
  
 
  initGraphics();
  //imageMode(CENTER);

}

void draw() {
  background(0);
  //translate(0, 0);
  
  for(int i = 0; i<frames.size(); i++) {
    Textframe f = frames.get(i);
    f.update();
    f.display();
  }
  
  if(record) {
    saveFrame("export/"+ year() + month() + day() +"/"+ frameCounter++ + ".tif");
  }
}

void initGraphics() {
  for(int i = 0; i<displayTexts.length; i++) {
    frames.add(new Textframe(displayTexts[i], i*ca, aniMaxFramesMove[i], aniMaxFramesSpacing[i], aniMoveTiming[i], aniSpacingTiming[i], aniMovePattern[i], aniSpacingPattern[i]));
  }
  
}
