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
  final int DIAGONAL_BALLS = 11;
  final int SWING = 12;
  final int PARALLAX = 13;
  final int FLOCK = 14;
  final int CHARMORPH = 15;
  final int STICKYFLOCK = 16;
  final int FLOCKOVERLAY = 17;
  int state = CIRCLE;
  
  String[] stateNames = {
    "CIRCLE", "ELLIPSE", "SQUARE", "RECTANGLE", "MOVIE",
    "SINE", "THREE LINES", "CELLULAR AUTOMATA", "ROTATING BALL",
    "ARCS", "ARCS PERLIN", "DIAGONAL BALLS", "SWING", "PARALLAX",
    "FLOCK", "CHARMORPH", "STICKYFLOCK", "FLOCKOVERLAY"
  };
  
  boolean movieStopped = false;
  
  // temporary variables
  float mapped0 = 0;
  float mapped1 = 0;
  
  color fillColor = 255;
  color strokeColor = 255;
  color tempFillColor = 255;
  color tempStrokeColor = 255;
  
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
  float xincrement = 5;
  float yoff = 0.0;
  float yincrement = 05;
  float zoff = 0.0;
  float zincrement = 5;
  float n = 0;
  float m = 0;
  float o = 0;
  
  // FLOCK
  Flock flock;
  StickyFlock stickyFlock;
  
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
    pg.textFont(loadFont("AkkuratStd-Bold-80.vlw"));
    pg.endDraw();
    
    //movie = new Movie(pa, "../assets/_MOV/faq2_clean.mp4");
    //movie.loop();
    //animation.setMovie(movFiles.get(movIndex));
    
    // SINEWAVE
    sine_width = pg.width+16;
    dx = (TWO_PI / period) * xspacing;
    yvalues = new float[w/xspacing];
    
    // CA
    int[] ruleset = {1,1,1,1,1,0,1,0};    // An initial rule system
    ca = new CA(ruleset, pg);
    
    // FLOCK
    flock = new Flock();
    // Add an initial set of boids into the system
    for (int i = 0; i < 200; i++) {
      flock.addBoid(new Boid(width/2,height/2));
    }
    
    // STICKYFLOCK
    stickyFlock = new StickyFlock();
    // Add an initial set of boids into the system
    for (int i = 0; i < 200; i++) {
      stickyFlock.addBoid(new StickyBoid(width/2,height/2, grid.getTilesize()[0]));
    }
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
        applyToggleStyles();
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
        applyToggleStyles();
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
        applyToggleStyles();
        pg.rect(pg.width/2, pg.height/2, mapped0, mapped0);
        pg.endDraw();
        
        Ani.to(this, 1.5, "progress0", target0);
      break;
      
      case RECTANGLE:
        if(millis() - timestamp > interval) {
          timestamp = millis();
          target0 = random(1);
          target1 = random(1);
          tempFillColor = (int)random(255);
          tempStrokeColor = (int)random(255);
        }
        mapped0 = map(progress0, 0f, 1f, 0, pg.width);
        mapped1 = map(progress1, 0f, 1f, 0, pg.width);
        pg.beginDraw();
        applyToggleStyles(tempFillColor, tempStrokeColor);
        pg.rect(pg.width/2, pg.height/2, mapped0, mapped1);
        pg.endDraw();
        
        Ani.to(this, 1.5, "progress0", target0);
        Ani.to(this, 1.5, "progress1", target1);
      break;
      
      case MOVIE:
        if(movieStopped || movie == null) {
          animation.setMovie(movFiles.get(movIndex));
          animation.startMovie();
        }
        pg.beginDraw();
        pg.imageMode(CENTER);
        pg.image(movie, pg.width/2, pg.height/2); 
        pg.endDraw();
      break;
      
      case SINE:
        // Increment theta (try different values for 'angular velocity' here
        theta += 0.02;
        amplitude = 300;
        if(xspacing != yvalues.length) yvalues = new float[w/xspacing];
        // For every x value, calculate a y value with sine function
        temp = theta;
        for (int i = 0; i < yvalues.length; i++) {
          yvalues[i] = sin(temp)*amplitude;
          temp+=dx;
        }
        pg.beginDraw();
        //pg.noStroke();
        //pg.fill(255);
        applyToggleStyles();
        // A simple way to draw the wave with an ellipse at each location
        for (int i = 0; i < yvalues.length; i++) {
          pg.ellipse(i*xspacing, pg.height/2+yvalues[i], 16, 16);
        }
         
        pg.endDraw();
        
      break;
      
      case THREE_LINES:
        theta += 0.005;
        pg.beginDraw();
        //pg.stroke(255);
        applyToggleStyles();
        pg.translate(pg.width/2, pg.height/2);
        pg.rotate(theta);
        pg.push();
        pg.strokeWeight(16);
        pg.line(0, 0, pg.width*2, pg.height*2);
        pg.rotate(radians(120));
        pg.line(0, 0, pg.width*2, pg.height*2);
        pg.rotate(radians(120));
        pg.line(0, 0, pg.width*2, pg.height*2);
        pg.pop();
        pg.endDraw();
        
      break;
      
      case CELLULAR_AUTOMATA:
        pg.beginDraw();
        applyToggleStyles();
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
        theta += 0.05;
      
        // For every x value, calculate a y value with sine function
        temp = theta;
        
        yvalues[0] = sin(temp)*amplitude;
        temp+=dx;
        
        pg.beginDraw();
        //pg.background(0);
        applyToggleStyles(color(0, 0, 0, 20), color(0));
        //pg.fill(0, 0, 0, 20);
        pg.rect(0, 0, pg.width*2, pg.height*2);
        pg.translate(pg.width/2, pg.height/2);
        //pg.noStroke();
        applyToggleStyles();
        //pg.fill(255);
        // A simple way to draw the wave with an ellipse at each location
        pg.rotate(radians(theta*8));
        pg.translate(0*xspacing, 600+yvalues[0]);
        pg.ellipse(0, -600, 64, 64);
        
         
        pg.endDraw();
        
      break;
      
      case ARCS:
        theta += 0.02;
        pg.beginDraw();
        applyToggleStyles();
        pg.translate(pg.width/2, pg.height/2);
        pg.rotate(theta);
        pg.ellipseMode(CENTER);
        pg.push();
        pg.strokeWeight(16);
        pg.arc(0, 0, 100, 100, 0, HALF_PI);
        pg.rotate(radians(120));
        pg.arc(0, 0, 300, 300, 0, HALF_PI);
        pg.rotate(radians(120));
        pg.arc(0, 0, 500, 500, 0, HALF_PI);
        pg.pop();
        pg.endDraw();
      break;
      
      case ARCS_PERLIN:
        theta += 0.02;
        n = noise(xoff)*pg.width;
        m = noise(yoff)*pg.width;
        o = noise(zoff)*pg.width;
        
        xincrement = 0.01;
        yincrement = 0.01;
        zincrement = 0.01;
        
        xoff += xincrement;
        yoff += yincrement;
        zoff += zincrement;
        
        pg.beginDraw();
        applyToggleStyles();
        pg.translate(pg.width/2, pg.height/2);
        pg.rotate(theta);
        pg.ellipseMode(CENTER);
        pg.push();
        pg.strokeWeight(16);
        pg.arc(0, 0, 100, 100, map(n, 0, pg.width, 0, PI), PI);
        pg.rotate(radians(120));
        pg.arc(0, 0, 300, 300, map(m, 0, pg.width, 0, PI), PI);
        pg.rotate(radians(120));
        pg.arc(0, 0, 500, 500, map(o, 0, pg.width, 0, PI), PI);
        pg.pop();
        
         
        pg.endDraw();
        

      break;
      
      case DIAGONAL_BALLS:
        xoff += xincrement;
        if(xoff >= pg.width+(pg.width/4)) {
          xoff = -(pg.width+(pg.width/4));
          n = random(pg.height);
          xincrement = random(5);
        }
        
        yoff += yincrement;
        if(yoff >= pg.width+(pg.width/4)) {
          yoff = -(pg.width+(pg.width/4));
          m = random(pg.height);
          yincrement = random(5);
        }
        
        zoff += zincrement;
        if(yoff >= pg.width+(pg.width/4)) {
          yoff = -(pg.width+(pg.width/4));
          o = random(pg.height);
          zincrement = random(5);
        }
        
        
        pg.beginDraw();
        pg.translate(pg.width/2, pg.height/2);
        pg.rotate(-45);
        pg.ellipseMode(CENTER);
        //pg.noStroke();
        //pg.fill(255);
        applyToggleStyles();
        pg.ellipse(xoff, n, 32, 32);
        pg.ellipse(yoff, m, 32, 32);
        pg.ellipse(zoff, o, 32, 32);
        //pg.strokeWeight(16);
        pg.endDraw();
       
      break;
      
      case SWING:
        // Increment theta (try different values for 'angular velocity' here
        theta += 0.02;
        amplitude = w/3;
        xspacing = 16;
        if(xspacing != yvalues.length) yvalues = new float[h/xspacing];
        // For every x value, calculate a y value with sine function
        temp = theta;
        for (int i = 0; i < yvalues.length; i++) {
          yvalues[i] = sin(temp)*map(i, 0, yvalues.length, amplitude, 0);
          temp+=dx;
        }
        pg.beginDraw();
        //pg.noStroke();
        //pg.fill(255);
        applyToggleStyles();
        // A simple way to draw the wave with an ellipse at each location
        for (int i = 0; i < yvalues.length; i++) {
          pg.ellipse(pg.width/2+yvalues[i], i*xspacing, 16, 16);
        }
         
        pg.endDraw();
      break;
      
      case PARALLAX:
        theta += 0.02;
        amplitude = 20;
      
        pg.beginDraw();
        //pg.noStroke();
        pg.rectMode(CENTER);
        //pg.fill(255);
        applyToggleStyles();
        pg.textSize(300);
        
        temp = theta;
        pg.rotate(radians(temp));
        pg.text("hello", sin(temp)*amplitude+pg.width/2, pg.height/2);
        
         
        pg.endDraw();
      break;
      
      case FLOCK:
        pg.beginDraw();
        applyToggleStyles();
        pg.ellipseMode(CENTER);
        flock.run(pg);
        pg.endDraw();
      break;
      
      case CHARMORPH:
        if(millis() - timestamp > interval) {
          timestamp = millis();
          target0 = random(1);
          target1 = random(1);
          tempFillColor = (int)random(120,255);
          tempStrokeColor = (int)random(120,255);
        }
        mapped0 = map(progress0, 0f, 1f, 0, pg.width);
        mapped1 = map(progress1, 0f, 1f, 0, pg.width);
        pg.beginDraw();
        pg.textAlign(CENTER, CENTER);
        //pg.stroke(strokeColor);
        //pg.fill(fillColor);
        applyToggleStyles(tempFillColor, tempStrokeColor);
        pg.textSize(mapped0);
        pg.text("Q", pg.width/2, pg.height/2);
        pg.endDraw();
        
        Ani.to(this, 1.5, "progress0", target0);
        Ani.to(this, 1.5, "progress1", target1);
      break;
      
      case STICKYFLOCK:
        pg.beginDraw();
        applyToggleStyles();
        pg.ellipseMode(CENTER);
        stickyFlock.run(pg);
        pg.endDraw();
      break;
      
      case FLOCKOVERLAY:
        pg.beginDraw();
        applyToggleStyles();
        pg.ellipseMode(CENTER);
        pg.imageMode(CENTER);
        pg.image(movie, pg.width/2, pg.height/2);
        flock.run(pg);
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
    state %= stateNames.length;
  }
  
  void prevState() {
    state--;
    if(state < 0) state = stateNames.length-1;
  }
  
  String getStateName() {
    return stateNames[state];
  }
  
  void updateSize(float f) {
    stickyFlock.updateSize(f);
  } 
  
  void setMovie(String s) {
    System.gc();
    movie = new Movie(pa, s);
  }
  
  void stopMovie() {
    if(movie != null) {
      movie.stop();
      movieStopped = true;
    }
  }
  
  void startMovie() {
    if(movie != null) {
      //movie.stop();
      //movie.jump(0);
      //movie.play();
      movie.loop();
      movieStopped = false;
    }
  }
  
  void applyToggleStyles() {
    if(toggleBackground) pg.background(0);
    if(toggleFill) pg.fill(fillColor);
    else pg.noFill();
    if(toggleStroke) pg.stroke(strokeColor);
    else pg.noStroke();
  }
  
  void applyToggleStyles(color c1, color c2) {
    if(toggleFill) pg.fill(c1);
    else pg.noFill();
    if(toggleStroke) pg.stroke(c2);
    else pg.noStroke();
  }
 

}
