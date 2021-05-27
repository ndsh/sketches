// https://dia.tv/project/catk/#slide-8
// https://dia.tv/project/space10/
// https://timrodenbroeker.de/processing-tutorial-programming-posters/
import de.looksgood.ani.*;

PFont font;
ArrayList<Textframe> frames = new ArrayList<Textframe>();
// 12 zeilen
int[] layout = {6,2,2,1,1}; // 12 zeilen
//String[] displayTexts = {"HOLY", "FORKING", "SHIRT", "BALLS"};
String[] displayTexts = {"IHRE", "WERBUNG", "HIER", "LOL"};
float ca;

boolean record = false;
int frameCounter = 0;

void setup() {
  size(600, 600, P3D);
  frameRate(60);
  surface.setLocation(0, 0);
  
  Ani.init(this);
  
  font = loadFont("Annonce-70.vlw");
  textFont(font);
  ca = textAscent();
  initGraphics();  
  
  imageMode(CENTER);
}

void draw() {
  background(0);
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
  for(int i = 0; i<layout.length; i++) { 
    frames.add(new Textframe(displayTexts, layout[i]));
  }
  
  for(int i = 0; i<frames.size(); i++) {
    Textframe f = frames.get(i);
    float div = (height/12);
    int sum = 0;
    for(int j = 0; j<i; j++) {
      sum += layout[j];
    }    
    //f.setPos(0, div*i);
    //f.setPos(0, div*i + (layout[i]*div) );
    f.setPos(0, (sum*div) );
  }
}
