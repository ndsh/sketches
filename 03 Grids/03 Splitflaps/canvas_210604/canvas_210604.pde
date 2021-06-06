Splitflap[] flaps;
PFont font;

int val = 0;
int nuance = 20; // 0 – 9
int inc = 0;

//String[] vocabulary = {"0", "1", "2", "3", "4", "5", "6", "7", "8", "9"};
//String[] vocabulary = {" ", ".", "/", "#"};
//String[] vocabulary = {" ", ".", "/", "//", "X", "#", "?", "!"};
String[] vocabulary = {" ", ".", "_", "-", "=", "*", "+", "|", "/", "#", " ", ".", "_", "-", "=", "*", "+", "|", "/", "#", };
//String[] vocabulary = {"H", "E", "L", "L", "O", "?"};
//String[] vocabulary = {"A", "B", "C", "D", "E", "F", "G", "H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"};

float[] randoms = new float[9];
float xoff = 0.0;
float xincrement = 0.001;


void setup() {
  size(600, 600);
  surface.setLocation(0, 0);
  frameRate(30);
  
  
  //font = loadFont("InputMono-Regular-20.vlw");
  font = loadFont("InputMono-Medium-20.vlw");
  //font = loadFont("Annonce-20.vlw");
  textFont(font);
  nuance = vocabulary.length;
  println(nuance);
  colorMode(HSB, 360, 100, nuance);
  inc = 400/nuance;
  
  int amount = 400;
  int grid = 20;
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
  float n = noise(xoff)*nuance;
  xoff += xincrement;

  for(int i = 0; i<randoms.length; i++) {
    //randoms[i] = noise(xoff) * nuance;
    randoms[i] = int(n);
    flaps[i].setTarget(int(randoms[i]));
  }
  for(int i = 0; i<flaps.length; i++) {
    flaps[i].update();
    flaps[i].display();
  } 
}
