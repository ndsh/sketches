// [ ] versch. geschwindigkeiten = grautöne
// [ ] pgraphics objekt

import processing.video.*;

PGraphics pg;

Flock flock;
ArrayList<Predator> predators = new ArrayList<Predator>();
Movie frame;

ArrayList<Wall> walls = new ArrayList<Wall>();
Wall currentWall = new Wall();

QuadTree qtree;
int frameNr = 0;

boolean ready = false;

void setup() {
  size(600, 600, P2D);
  pg = createGraphics(600, 600);
  frameRate(60);
  //fullScreen(P2D);
  surface.setLocation(0, 0);
  setupUI();
  flock = new Flock(1000);
  walls.add(currentWall);
  
  frame = new Movie(this, "faq2.mp4");
  frame.loop();
  //predators.add(new Predator(new PVector(width/2, height/2)));
}

boolean firstClick = false;

void draw() {
  if(ready) {
    frame.loadPixels();
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
    for (Boid boid : flock.boids) {
      qtree.insert(new Point(boid.position.x, boid.position.y, boid));
    }
  
    for (Wall wall : walls) {
      for (Obstacle obstacle : wall.obstacles) {
        qtree.insert(new Point(obstacle.position.x, obstacle.position.y, obstacle));
      }
    }
  
  
    //ArrayList<Point> selection = qtree.query(new Circle(mouseX, mouseY, 100), null);
    //for(Point p : selection){
    //  p.boid.setHighlighted(true);
    //}
  
    flock.display();
    runPredators();
  
    for (Wall wall : walls)
      wall.display();
  
    if (showQuadTreeCheckBox.getArrayValue()[0] == 1) {
      qtree.show();
    }
  
    //drawUI();
  
    //reachDesiredNumberOfBoids();
    image(frame, 0, 0, 0, 0);
    boolean export = true;
    if(export) {
      saveFrame("_EXPORT/" + frameNr + ".tga");
      
      frameNr++;
      //delay(20);
      if(frameNr >= 1800) exit();
    }
  }
}


void movieEvent(Movie m) {
  m.read();
  ready = true;
}
