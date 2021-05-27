Splitflap[] flaps;
PFont font;

int val = 0;
int nuance = 100; // 0 – 9
int inc = 0;

PImage[] vocabulary = new PImage[36];
//ArrayList<PImage> vocabulary;
//String[] vocabulary = {" ", ".", "/", "#"};
//String[] vocabulary = {" ", ".", "/", "//", "X", "#", "?", "!"};
//String[] vocabulary = {".", "_", "-", "=", "*", "+", "|", "/", "#", " "};
//String[] vocabulary = {"H", "E", "L", "L", "O", "?", " ", " "};
//String[] vocabulary = {"A", "B", "C", "D", "E", "F", "G", "H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"};

float[] randoms = new float[9];
float xoff = 0.0;


void setup() {
  size(600, 600);
  surface.setLocation(0, 0);
  frameRate(30);
  //vocabulary = new ArrayList<PImage>();
  
  for(int i = 0; i<36; i++) {
    //vocabulary.add(loadImage("assets/" + i + ".jpg"));
    vocabulary[i] = loadImage("assets/" + i + ".jpg");
  }
  
  font = loadFont("04b-03-48.vlw");
  textFont(font);
  nuance = vocabulary.length;
  println(nuance);
  colorMode(HSB, 360, 100, nuance);
  inc = 1000/nuance;
  
  int amount = 300;
  int grid = 30;
  flaps = new Splitflap[amount];
  randoms = new float[amount];
  int x = 0;
  int y = 0;
  for(int i = 0; i<amount; i++) {
    flaps[i] = new Splitflap((x*(width/nuance))+(width/nuance)/2, (y*width/nuance)+(width/nuance)/2);
    x++;
    if(x >= grid) {
      x = 0;
      y++;
    }
  } 
  
  rectMode(CENTER);
  textAlign(CENTER, CENTER);
}

void draw() {
  background( color(0,0,val) );

  for(int i = 0; i<randoms.length; i++) {
    //randoms[i] = noise(xoff) * nuance;
    randoms[i] = int(random(nuance));
    flaps[i].setTarget(int(randoms[i]));
  }
  for(int i = 0; i<flaps.length; i++) {
    flaps[i].update();
    flaps[i].display();
  } 
}
