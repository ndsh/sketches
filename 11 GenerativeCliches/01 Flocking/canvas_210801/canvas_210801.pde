// [ ] versch. geschwindigkeiten = grautöne
// [ ] pgraphics objekt

import processing.video.*;

PGraphics pg;

qtFlock qtflock;
Movie movie;


QuadTree qtree;
int frameNr = 0;

boolean globalSticky = false;
float[] temporaries = {0,0,0};

boolean ready = false;

void setup() {
  size(600, 600, P2D);
  pg = createGraphics(600, 600);
  frameRate(60);
  //fullScreen(P2D);
  surface.setLocation(0, 0);
  setupUI();
  qtflock = new qtFlock(1000);
  
  movie = new Movie(this, "faq2_clean.mp4");
  movie.loop();
  //predators.add(new Predator(new PVector(width/2, height/2)));
}

boolean firstClick = false;

void draw() {
  if(ready) {
    movie.loadPixels();
    if (backgroundColorPicker != null)
      //background(backgroundColorPicker.getColorValue());
      background(0);
  
    if (showMouseCursorCheckBox.getArrayValue()[0] == 1) {
      cursor();
    } else {
      noCursor();
    }
  
    if (showMouseRadiusCheckBox.getArrayValue()[0] == 1) {
      fill(mouseFillColorPicker.getColorValue());
      stroke(mouseStrokeColorPicker.getColorValue());
      circle(mouseX, mouseY, mouseRadiusSlider.getValue()/2);
    }
  
    qtree = new QuadTree(new Rectangle(width/2, height/2, width, height), (int)quadTreeBoidPerSquareLimitSlider.getValue());
    for (qtBoid boid : qtflock.boids) {
      qtree.insert(new Point(boid.position.x, boid.position.y, boid));
    }
 
  
  
    //ArrayList<Point> selection = qtree.query(new Circle(mouseX, mouseY, 100), null);
    //for(Point p : selection){
    //  p.boid.setHighlighted(true);
    //}
  
    qtflock.display();
  
    
  
    if (showQuadTreeCheckBox.getArrayValue()[0] == 1) {
      qtree.show();
    }
  
    //drawUI();
  
    //reachDesiredNumberOfBoids();
    image(movie, 0, 0, 0, 0);
    boolean export = true;
    if(export) {
      saveFrame("_EXPORT/" + frameNr + ".tga");
      
      frameNr++;
      //delay(20);
      if(frameNr >= 1800) exit();
    }
  }
  globalSticky = false;
}


void movieEvent(Movie m) {
  m.read();
  ready = true;
}
