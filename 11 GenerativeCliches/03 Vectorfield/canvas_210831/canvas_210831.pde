
int margin_x = 150;
int margin_y = 60;
int len = 20;
int w, h;
int cols, rows;
float off;
int scl = 2;

Cell grid[][];

void setup () {
  size(630, 630);
  background(255);
  
  cols = floor(width / len);
  rows = floor(height / len);
  
  grid = new Cell[cols][rows];
  
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      grid[i][j] = new Cell(i, j);
      //grid[i][j].show();
    }
  }
}

void draw(){
  background(255);
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      grid[i][j].update();
      grid[i][j].show();
    }
  }
}

PVector vector__field (float x, float y) {
  x = map(x, 0, width, -3, 3);
  y = map(y, 0, height, -3, 3);
  
  float u = x;
  float v = y;
  
  return new PVector(u, v);
}

class Cell {
  int i, j;  
  PVector vec;  float arg;
  float mag;  
  float inc = 2.02;
  Cell (int _i, int _j) {
    i = _i;
    j = _j;
    
    float x = (i + 0.5) * len;
    float y = (j + 0.5) * len;
    
    vec = vector__field(x, y);
    mag = vec.mag();
    arg = vec.heading();
  }
  
  void update() {
    float x = (i + 0.5) * len;
    float y = (j + 0.5) * len;
    inc += random(inc);
    vec = vector__field(x, y+PI);
    mag = vec.mag();
    arg = vec.heading();
  }
  
  void show () {
  if (mag != 0) {
    push();
    strokeWeight(2);
    stroke(0);    float r = 8; 
    float l = len;
    float buffer = 5;    translate((i + 0.5) * l, (j + 0.5) * l);
    rotate(arg);
    line(-l/2 + buffer, 0, l/2 - buffer, 0);
    
    translate(l/2 - buffer, 0);   
    float a = radians(150);
    float x1 = scl * r * cos(a);
    float y1 = scl * r * sin(a);
    
    line(0, 0, x1, y1);  
    line(0, 0, x1, -y1);
      
    pop();
  }
}
}
