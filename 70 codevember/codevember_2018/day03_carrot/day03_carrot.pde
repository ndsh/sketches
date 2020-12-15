//Ceci n’est pas une carrot
import com.hamoid.*;

VideoExport videoExport;

PFont font;

Carrot carrot;

void setup() {
  size(600, 600);
  
  videoExport = new VideoExport(this);
  videoExport.startMovie();
  
  carrot = new Carrot(300, 500);
  font = loadFont("AkkuratStd-Italic-32.vlw");
  textFont(font, 32);
  textAlign(CENTER, CENTER);
}

void draw() {
  background(255);
  carrot.update();
  carrot.display();
  imageMode(CENTER);
  image(carrot.getDisplay(), width/2, height/2);
  fill(0);
  text("Ceci n’est pas une carotte", width/2, (height/12)*11);
  
  videoExport.saveFrame();
  // we will have an almost invisible gradient in the background
}

void keyPressed() {
  if (key == 'q') {
    videoExport.endMovie();
    exit();
  }
}
