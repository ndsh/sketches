// https://dia.tv/project/catk/#slide-8
// https://dia.tv/project/space10/
// https://timrodenbroeker.de/processing-tutorial-programming-posters/

PGraphics pg;
PFont font;
String displayText = "YES!";

void setup() {
  size(600, 600, P3D);
  frameRate(60);
  surface.setLocation(0, 0);
  
  font = loadFont("Annonce-60.vlw");
  pg = createGraphics(600, 600);
  
  pg.beginDraw();
  pg.textFont(font);
  pg.textAlign(CENTER, CENTER);
  pg.background(0);
  pg.fill(255);
  //pg.text("TEXT", pg.width/2, pg.height/2);
  pg.push();
  pg.translate(pg.width/2, pg.height/2);
  for(int x = -1; x < 2; x++) {
      pg.text(displayText, x,0);
      pg.text(displayText, 0,x);
  }
  pg.pop();
  pg.fill(0);
  pg.text(displayText, pg.width/2, pg.height/2);
  pg.endDraw();
  
  imageMode(CENTER);
}

void draw() {
  background(0);
  beginShape();
  texture(pg);
  //vertex(mouseX, mouseY, map(mouseX, 0, 600, 0, mouseX), map(mouseY, 0, 600, 0, mouseY));
  vertex(mouseX, 0, 0, 0);
  vertex(600, 0, 600, 0);
  vertex(600, 600, 600, 600);
  vertex(mouseX, 600, 0, 600);
  //vertex(mouseX, mouseY+600, map(mouseX, 0, 600, 0, mouseX), map(mouseY, 0, 600, 0, mouseY)+600);
  endShape();
}
