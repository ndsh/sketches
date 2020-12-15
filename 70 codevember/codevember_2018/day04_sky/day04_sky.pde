import com.hamoid.*;
VideoExport videoExport;
boolean record = false;

float segments;

Tex tex1;
Tex tex2;

float r = 0;
int objs = 8;
PShape clouds[] = new PShape[objs];
PVector positions[] = new PVector[objs];
float speeds[] = new float[objs];

color backgroundColor = color(0);
color foregroundColor = color(255);


void setup() {
  size(600, 600);

  tex1 = new Tex(900, 900, 4, 8, 4);
  tex2 = new Tex(600, 600, 9, 9, 2);

  noStroke();
  segments = height/16;

  if (record) {  
    videoExport = new VideoExport(this);
    videoExport.startMovie();
  }

  imageMode(CENTER);
  for(int i = 0; i<clouds.length; i++) {
    clouds[i] = createShape();
    clouds[i].beginShape();
    clouds[i].vertex((int)random(110, 120), (int)random(30,70));
    clouds[i].vertex((int)random(148,150), (int)random(60,70));
    clouds[i].vertex((int)random(180, 223), (int)random(71,80));
    clouds[i].vertex((int)random(180,210), (int)random(117,120));
    clouds[i].vertex((int)random(81,90), (int)random(130,140));
    clouds[i].vertex((int)random(29,30), (int)random(110,120));
    clouds[i].vertex((int)random(47,50), (int)random(74,80));
    clouds[i].endShape(CLOSE);
    clouds[i].setFill(backgroundColor);
    clouds[i].scale(random(0.2, 1));
    speeds[i] = random(0.01, 0.1);
    positions[i] = new PVector(random(0, width), random(segments*0, segments*6));
    
  }
}

void draw() {
  background(backgroundColor);
  image(tex2.getDisplay(), width/2-tex2.pixelSize().x, height/2-tex2.pixelSize().y);
  
  fill(backgroundColor, 170);
  rect(0, segments*0, width, segments*2);
  
  fill(backgroundColor, 85);
  rect(0, segments*2, width, segments*6);
  
  fill(backgroundColor, 0);
  rect(0, segments*6, width, segments);
  
  pushMatrix();
  translate(width/2, height/2);
  rotate(radians(r));
  r += 0.01;
  popMatrix();
  
  for(int i = 0; i<clouds.length; i++) {
    positions[i].x -= speeds[i];
    if(positions[i].x < -300) positions[i].x = width+300; 
    shape(clouds[i], positions[i].x, positions[i].y);
  }

  if (record) videoExport.saveFrame();
}

void keyPressed() {
  if (key == 'q') {
    videoExport.endMovie();
    exit();
  }
}
