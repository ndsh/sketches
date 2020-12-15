import com.hamoid.*;

VideoExport videoExport;

int particles = 300;
float[] xPos;
float[] yPos;
float[] zPos;
float[] yInc;



void setup() {
  size(600, 600, P3D);
  
  videoExport = new VideoExport(this);
  videoExport.startMovie();
  
  xPos = new float[particles];
  yPos = new float[particles];
  zPos = new float[particles];
  yInc = new float[particles];
  for(int i = 0; i<particles; i++){
    xPos[i] = random(-width+50, width-50);
    yPos[i] = random(0, height);
    zPos[i] = random(0.1, 100);
    yInc[i] = random(0.2, 0.89);
  } 
  
  stroke(255);
  noFill();
  smooth();
  strokeWeight(2);
}
 
void draw() {
  
  //background(0);
  stroke(255);
  
  pushMatrix();
  //iso(0,0,0);
  //box(100, 100, 100);
  popMatrix();
  
  for(int i = 0; i<particles; i++) {
    pushMatrix();
    iso(xPos[i], yPos[i],zPos[i]);
    sphere(0.1);
    popMatrix();
    yPos[i] -= yInc[i]; 
    if(yPos[i] < -height) yPos[i] = height; 
  }
  


  
  pushStyle();
  fill(0, 50);
  rect(0,0,width,height);
  noFill();
  popStyle();
  
  videoExport.saveFrame();
}

void iso(float x, float y, float z) {
  //y = map(y, 0, height, height/
  translate(width/2+x, height/2+y, z);
  rotateX(-PI/6);
  rotateY(PI/3);
}

void keyPressed() {
  if (key == 'q') {
    videoExport.endMovie();
    exit();
  }
}
