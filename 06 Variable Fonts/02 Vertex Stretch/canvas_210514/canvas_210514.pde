// https://dia.tv/project/catk/#slide-8
// https://dia.tv/project/space10/
// https://timrodenbroeker.de/processing-tutorial-programming-posters/
import de.looksgood.ani.*;

PGraphics pg;
PFont font;
String displayText = "YO";
float ca;
Textframe frame;


void setup() {
  size(600, 600, P3D);
  frameRate(60);
  surface.setLocation(0, 0);
  
  Ani.init(this);
  
  
  font = loadFont("Annonce-70.vlw");
  textFont(font);
  ca = textAscent();
  println(ca);
  
  frame = new Textframe(displayText);
  pg = createGraphics(600, 600);
  
  
  imageMode(CENTER);
}

void draw() {
  background(30);
  frame.update();
  frame.display();

}


void initGraphics() {
}
