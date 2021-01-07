Splitflap flap;
PFont font;

int val = 0;
int nuance = 10; // 0 – 9
int inc = 0;

//String[] vocabulary = {"0", "1", "2", "3", "4", "5", "6", "7", "8", "9"};
String[] vocabulary = {"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"};

void setup() {
  size(400, 400);
  surface.setLocation(0, 0);
  frameRate(30);
  
  
  font = loadFont("04b-03-48.vlw");
  textFont(font);
  nuance = vocabulary.length;
  println(nuance);
  colorMode(HSB, 360, 100, nuance);
  inc = 100/nuance;
  
  flap = new Splitflap();
  rectMode(CENTER);
  textAlign(CENTER, CENTER);
}

void draw() {
  background( color(0,0,val) );
  flap.update();
  flap.display();
}
