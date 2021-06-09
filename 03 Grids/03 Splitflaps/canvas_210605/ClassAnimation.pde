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
  final int THREE_LINES = 6;
  final int CELLULAR_AUTOMATA = 7;
  final int ROTATING_BALL = 8;
  final int ARCS = 9;
  final int ARCS_PERLIN = 10;
  int state = ARCS_PERLIN;
  int maxStates = 11;
  float mapped0 = 0;
  float mapped1 = 0;
  
  String[] stateNames = {
    "CIRCLE", "ELLIPSE", "SQUARE", "RECTANGLE", "MOVIE",
    "SINE", "THREE LINES", "CELLULAR AUTOMATA", "ROTATING BALL",
    "ARCS", "ARCS PERLIN"
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
  float temp = 0;
  
  CA ca;
  
  // PERLIN
  float xoff = 0.0;
  float xincrement = 0.01;
  float yoff = 0.0;
  float yincrement = 0.01;
  float zoff = 0.0;
  float zincrement = 0.01;
  float n = 0;
  float m = 0;
  float o = 0;
  
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
    
    movie = new Movie(pa, "../assets/spiral.mp4");
    movie.loop();
    
    // SINEWAVE
    sine_width = pg.width+16;
    dx = (TWO_PI / period) * xspacing;
    yvalues = new float[w/xspacing];
    
    // CA
    int[] ruleset = {1,1,1,1,1,0,1,0};    // An initial rule system
    ca = new CA(ruleset, pg);   
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
        temp = theta;
        for (int i = 0; i < yvalues.length; i++) {
          yvalues[i] = sin(temp)*amplitude;
          temp+=dx;
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
      
      case THREE_LINES:
        theta += 0.005;
        pg.beginDraw();
        pg.background(0);
        pg.stroke(255);
        pg.translate(pg.width/2, pg.height/2);
        pg.rotate(theta);
        
        pg.strokeWeight(16);
        pg.line(0, 0, pg.width*2, pg.height*2);
        pg.rotate(radians(120));
        pg.line(0, 0, pg.width*2, pg.height*2);
        pg.rotate(radians(120));
        pg.line(0, 0, pg.width*2, pg.height*2);
         
        pg.endDraw();
        
      break;
      
      case CELLULAR_AUTOMATA:
        pg.beginDraw();
        
        ca.render(pg);    // Draw the CA
        ca.generate();  // Generate the next level
        
        if (ca.finished()) {   // If we're done, clear the screen, pick a new ruleset and restart
          //pg.background(0);
          ca.randomize();
          ca.restart();
        }
        pg.endDraw();
      break;
      
      case ROTATING_BALL:
        amplitude = 300.0;
        // Increment theta (try different values for 'angular velocity' here
        theta += 0.2;
      
        // For every x value, calculate a y value with sine function
        temp = theta;
        
          yvalues[0] = sin(temp)*amplitude;
          temp+=dx;
        
        pg.beginDraw();
        //pg.background(0);
        pg.fill(0, 0, 0, 20);
        
        pg.rect(0, 0, pg.width*2, pg.height*2);
        
        
        pg.translate(pg.width/2, pg.height/2);
        pg.noStroke();
        pg.fill(255);
        // A simple way to draw the wave with an ellipse at each location
        pg.rotate(radians(theta));
        pg.translate(0*xspacing, 600+yvalues[0]);
        pg.ellipse(0, -600, 16, 16);
        
         
        pg.endDraw();
        
      break;
      
      case ARCS:
      
        theta += 0.02;
        pg.beginDraw();
        pg.background(0);
        pg.stroke(255);
        pg.translate(pg.width/2, pg.height/2);
        pg.rotate(theta);
        pg.ellipseMode(CENTER);
        pg.strokeWeight(16);
        pg.arc(0, 0, 100, 100, 0, HALF_PI);
        pg.rotate(radians(120));
        pg.arc(0, 0, 300, 300, 0, HALF_PI);
        pg.rotate(radians(120));
        pg.arc(0, 0, 500, 500, 0, HALF_PI);
         
        pg.endDraw();
        

      break;
      
      case ARCS_PERLIN:
      
        theta += 0.02;
        n = noise(xoff)*pg.width;
        m = noise(yoff)*pg.width;
        o = noise(zoff)*pg.width;
        
        xoff += xincrement;
        yoff += yincrement;
        zoff += zincrement;
        
        pg.beginDraw();
        pg.background(0);
        pg.stroke(255);
        pg.translate(pg.width/2, pg.height/2);
        pg.rotate(theta);
        pg.ellipseMode(CENTER);
        pg.strokeWeight(16);
        pg.arc(0, 0, 100, 100, map(n, 0, pg.width, 0, PI), PI);
        pg.rotate(radians(120));
        pg.arc(0, 0, 300, 300, map(m, 0, pg.width, 0, PI), PI);
        pg.rotate(radians(120));
        pg.arc(0, 0, 500, 500, map(o, 0, pg.width, 0, PI), PI);
        
        
         
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

class CA {

  int[] cells;     // An array of 0s and 1s 
  int generation;  // How many generations?
  int scl;         // How many pixels wide/high is each cell?

  int[] rules;     // An array to store the ruleset, for example {0,1,1,0,1,1,0,1}
  PGraphics pg;

  CA(int[] r, PGraphics _pg) {
    pg = _pg;
    rules = r;
    scl = 1;
    cells = new int[pg.width/scl];
    restart();
  }
  
  // Set the rules of the CA
  void setRules(int[] r) {
    rules = r;
  }
  
  // Make a random ruleset
  void randomize() {
    for (int i = 0; i < 8; i++) {
      rules[i] = int(random(2));
    }
  }
  
  // Reset to generation 0
  void restart() {
    for (int i = 0; i < cells.length; i++) {
      cells[i] = 0;
    }
    cells[cells.length/2] = 1;    // We arbitrarily start with just the middle cell having a state of "1"
    generation = 0;
  }

  // The process of creating the new generation
  void generate() {
    // First we create an empty array for the new values
    int[] nextgen = new int[cells.length];
    // For every spot, determine new state by examing current state, and neighbor states
    // Ignore edges that only have one neighor
    for (int i = 1; i < cells.length-1; i++) {
      int left = cells[i-1];   // Left neighbor state
      int me = cells[i];       // Current state
      int right = cells[i+1];  // Right neighbor state
      nextgen[i] = executeRules(left,me,right); // Compute next generation state based on ruleset
    }
    // Copy the array into current value
    for (int i = 1; i < cells.length-1; i++) {
      cells[i] = nextgen[i];
    }
    //cells = (int[]) nextgen.clone();
    generation++;
  }
  
  // This is the easy part, just draw the cells, fill 255 for '1', fill 0 for '0'
  void render(PGraphics pg) {
    for (int i = 0; i < cells.length; i++) {
      if (cells[i] == 1) {
        pg.fill(255);
      } else { 
        pg.fill(0);
      }
      pg.noStroke();
      pg.rect(i*scl,generation*scl, scl,scl);
    }
  }
  
  // Implementing the Wolfram rules
  // Could be improved and made more concise, but here we can explicitly see what is going on for each case
  int executeRules (int a, int b, int c) {
    if (a == 1 && b == 1 && c == 1) { return rules[0]; }
    if (a == 1 && b == 1 && c == 0) { return rules[1]; }
    if (a == 1 && b == 0 && c == 1) { return rules[2]; }
    if (a == 1 && b == 0 && c == 0) { return rules[3]; }
    if (a == 0 && b == 1 && c == 1) { return rules[4]; }
    if (a == 0 && b == 1 && c == 0) { return rules[5]; }
    if (a == 0 && b == 0 && c == 1) { return rules[6]; }
    if (a == 0 && b == 0 && c == 0) { return rules[7]; }
    return 0;
  }
  
  // The CA is done if it reaches the bottom of the screen
  boolean finished() {
    if (generation > pg.height/scl) {
       return true;
    } else {
       return false;
    }
  }
}
