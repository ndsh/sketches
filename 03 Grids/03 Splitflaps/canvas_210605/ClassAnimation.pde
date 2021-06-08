import de.looksgood.ani.*;

class Animation {
  PApplet pa;
  int w;
  int h;
  PGraphics pg;
  
  float progress0 = 0;
  float progress1 = 0;
  float target0 = 1;
  float target1 = 1;
  
  long timestamp = 0;
  long interval = 2500;
  
  final int CIRCLE = 0;
  final int ELLIPSUS = 1;
  final int SQUAREY = 2;
  final int RECTANGLE = 3;
  final int MOVIE = 4;
  final int SINE = 5;
  int state = SINE;
  int maxStates = 5;
  float mapped0 = 0;
  float mapped1 = 0;
  
  String[] stateNames = {
    "CIRCLE", "ELLIPSE", "SQUARE", "RECTANGLE", "MOVIE",
    "SINE"
  };
  
  color fillColor = 0;
  color strokeColor = 255;
  
  Movie movie;
  
  /* SINEWAVE VARS */
  int xspacing = 16;   // How far apart should each horizontal location be spaced
  int sine_width;              // Width of entire wave
  float theta = 0.0;  // Start angle at 0
  float amplitude = 200.0;  // Height of wave
  float period = 500.0;  // How many pixels before the wave repeats
  float dx;  // Value for incrementing X, a function of period and xspacing
  float[] yvalues;  // Using an array to store height values for the wave
  
  public Animation(PApplet _pa, int _w, int _h) {
    pa = _pa;
    w = _w;
    h = _h;
    println("Animation object created with= " + w + "x" + h +" pxl");
    pg = createGraphics(w, h);
    pg.beginDraw();
    pg.ellipseMode(CENTER);
    pg.rectMode(CENTER);
    pg.noFill();
    pg.stroke(255);
    pg.strokeWeight(5);
    pg.endDraw();
    
    movie = new Movie(pa, "../assets/lines.mp4");
    movie.loop();
    
    // SINEWAVE
    sine_width = pg.width+16;
    dx = (TWO_PI / period) * xspacing;
    yvalues = new float[w/xspacing];
  }
  
  void update() {
    switch(state) {
      case CIRCLE:
        if(millis() - timestamp > interval) {
          timestamp = millis();
          target0 = random(1);
        }
        mapped0 = map(progress0, 0f, 1f, 0, pg.width); 
        pg.beginDraw();
        pg.background(0);
        pg.ellipse(pg.width/2, pg.height/2, mapped0, mapped0);
        pg.endDraw();
        
        Ani.to(this, 1.5, "progress0", target0);
      break;
      
      case ELLIPSUS:
        if(millis() - timestamp > interval) {
          timestamp = millis();
          target0 = random(1);
          target1 = random(1);
        }
        mapped0 = map(progress0, 0f, 1f, 0, pg.width);
        mapped1 = map(progress1, 0f, 1f, 0, pg.width);
        pg.beginDraw();
        pg.background(0);
        pg.ellipse(pg.width/2, pg.height/2, mapped0, mapped1);
        pg.endDraw();
        
        Ani.to(this, 1.5, "progress0", target0);
        Ani.to(this, 1.5, "progress1", target1);
      break;
      
      case SQUAREY:
        if(millis() - timestamp > interval) {
          timestamp = millis();
          target0 = random(1);
        }
        mapped0 = map(progress0, 0f, 1f, 0, pg.width); 
        pg.beginDraw();
        pg.background(0);
        pg.stroke(strokeColor);
        pg.fill(fillColor);
        pg.rect(pg.width/2, pg.height/2, mapped0, mapped0);
        pg.endDraw();
        
        Ani.to(this, 1.5, "progress0", target0);
      break;
      
      case RECTANGLE:
        if(millis() - timestamp > interval) {
          timestamp = millis();
          target0 = random(1);
          target1 = random(1);
          fillColor = (int)random(255);
          strokeColor = (int)random(255);
        }
        mapped0 = map(progress0, 0f, 1f, 0, pg.width);
        mapped1 = map(progress1, 0f, 1f, 0, pg.width);
        pg.beginDraw();
        pg.background(0);
        pg.stroke(strokeColor);
        pg.fill(fillColor);
        pg.rect(pg.width/2, pg.height/2, mapped0, mapped1);
        pg.endDraw();
        
        Ani.to(this, 1.5, "progress0", target0);
        Ani.to(this, 1.5, "progress1", target1);
      break;
      
      case MOVIE:
        pg.beginDraw();
        pg.background(0);
        pg.imageMode(CENTER);
        pg.image(movie, pg.width/2, pg.height/2); 
        pg.endDraw();
      break;
      
      case SINE:
        // Increment theta (try different values for 'angular velocity' here
        theta += 0.02;
      
        // For every x value, calculate a y value with sine function
        float x = theta;
        for (int i = 0; i < yvalues.length; i++) {
          yvalues[i] = sin(x)*amplitude;
          x+=dx;
        }
        pg.beginDraw();
        pg.background(0);
        pg.noStroke();
        pg.fill(255);
        // A simple way to draw the wave with an ellipse at each location
        for (int i = 0; i < yvalues.length; i++) {
          pg.ellipse(i*xspacing, pg.height/2+yvalues[i], 16, 16);
        }
         
        pg.endDraw();
        
      break;
      
      
    }
    
  }
  
  void display() {
  }
  
  PImage getDisplay() {
    return pg;
  }
  
  void nextState() {
    state++;
    state %= maxStates;
  }
  
  void prevState() {
    state--;
    if(state < 0) state = maxStates-1;
  }
  
  String getStateName() {
    return stateNames[state];
  }

}
