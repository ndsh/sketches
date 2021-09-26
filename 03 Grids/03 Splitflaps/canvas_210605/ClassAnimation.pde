import de.looksgood.ani.*;

class Animation {
  PApplet pa;
  int w;
  int h;
  PGraphics pg;
  int layerID;
  
  float progress0 = 0;
  float progress1 = 0;
  float progress2 = 0;
  float progress3 = 0;
  float target0 = 1;
  float target1 = 1;
  float target2 = 1;
  float target3 = 1;
  
  long timestamp = 0;
  long interval = 2500;
  
  final int CIRCLE = 0;
  final int ELLIPSUS = 1;
  final int SQUAREY = 2;
  final int RECTANGLE = 3;
  final int MOVIE = 4;
  final int STATIC = 5;
  final int SINE = 6;
  final int THREE_LINES = 7;
  final int CELLULAR_AUTOMATA = 8;
  final int ROTATING_BALL = 9;
  final int ARCS = 10;
  final int ARCS_PERLIN = 11;
  final int DIAGONAL_BALLS = 12;
  final int SWING = 13;
  final int PARALLAX = 14;
  final int FLOCK = 15;
  final int CHARMORPH = 16;
  final int STICKYFLOCK = 17;
  final int FLOCKOVERLAY = 18;
  final int QTFLOCK = 19;
  final int GRADIENTS = 20;
  final int DRAW = 21;
  final int THREEDCUBE = 22;
  final int THREEDLINES = 23;
  final int THREEDDISK = 24;
  final int THREEDSCULPTURE = 25;
  int state = THREEDSCULPTURE;
  
  String[] stateNames = {
    "CIRCLE", "ELLIPSE", "SQUARE", "RECTANGLE", "MOVIE",
    "IMAGE","SINE", "THREE LINES", "CELLULAR AUTOMATA",
    "ROTATING BALL", "ARCS", "ARCS PERLIN", "DIAGONAL BALLS", "SWING",
    "PARALLAX", "FLOCK", "CHARMORPH", "STICKYFLOCK", "FLOCKOVERLAY",
    "QUADTREEFLOCKING", "GRADIENTS", "DRAW", 
    "THREED", "THREEDLINES", "THREEDDISK", "THREEDSCULPTURE"
  };
  
  String[] autoStateSelection = {
    "CIRCLE", "ELLIPSE", "SQUARE", "RECTANGLE", 
    "SINE", "THREE LINES", "CELLULAR AUTOMATA",
    "ROTATING BALL", "ARCS", "SWING",
    "FLOCK", "GRADIENTS"
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
  PImage p;
  int newFrame = 0;
  
  /* SINEWAVE VARS */
  int xspacing = 16;   // How far apart should each horizontal location be spaced
  int sine_width;              // Width of entire wave
  float theta = 0.0;  // Start angle at 0
  float thetaValue = random(0.02, 0.06);
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
  
  // 3DPROJECTION
  PVector[] points = new PVector[8];
  PVector[] pointsSpace;
  PVector[] pointsDisk  = new PVector[8];
  PVector[] pointsSculpt1 =  new PVector[16];

  float[][] projection = {
    {1, 0, 0},
    {0, 1, 0}
  };
  
  float[][] rotationX;
  float[][] rotationY;
  float[][] rotationZ;
  PVector[] projected;
  int index = 0;
  PVector[] connect = new PVector[3];
  
  boolean animationReady = false;
  
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
    pg.textFont(loadFont(fontsFolder + "AkkuratStd-Bold-80.vlw"));
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
    for (int i = 0; i < 250; i++) {
      flock.addBoid(new Boid(random(width),random(height)));
    }
    
    // STICKYFLOCK
    stickyFlock = new StickyFlock();
    // Add an initial set of boids into the system
    for (int i = 0; i < 200; i++) {
      stickyFlock.addBoid(new StickyBoid(width/2,height/2, grid.getTilesize()[0]));
    }
    
    // QTFLOCK
    setupUI();
    qtflock = new qtFlock(600);
    
    // 3D PROJECTION
    points[0] = new PVector(-0.5, -0.5, -0.5);
    points[1] = new PVector(0.5, -0.5, -0.5);
    points[2] = new PVector(0.5, 0.5, -0.5);
    points[3] = new PVector(-0.5, 0.5, -0.5);
    points[4] = new PVector(-0.5, -0.5, 0.5);
    points[5] = new PVector(0.5, -0.5, 0.5);
    points[6] = new PVector(0.5, 0.5, 0.5);
    points[7] = new PVector(-0.5, 0.5, 0.5);
    
    pointsSpace = new PVector[int(random(8, 32))];
    for(int i = 0; i<pointsSpace.length; i++) {
      pointsSpace[i] = new PVector(random(-1, 1),random(-1, 1),random(-1, 1)); 
    }
    
    pointsDisk[0] = new PVector(0.0, -0.5, 0);
    pointsDisk[1] = new PVector(0.352, -0.354, 0);
    pointsDisk[2] = new PVector(0.5, 0.0, 0);
    pointsDisk[3] = new PVector(0.352, 0.352, 0);
    pointsDisk[4] = new PVector(-0.0, 0.5, 0);
    pointsDisk[5] = new PVector(-0.354, 0.352, 0);
    pointsDisk[6] = new PVector(-0.5, 0.0, 0);
    pointsDisk[7] = new PVector(-0.354, -0.354, 0);
    
    for(int i = 0; i<pointsSculpt1.length; i++) {
      float map = map(i, 0, pointsSculpt1.length, -0.5, 0.5);
      pointsSculpt1[i] = new PVector(map, map, map);
    }
    
    connect[0] = new PVector(int(random(pointsSpace.length)), int(random(pointsSpace.length)));
    connect[1] = new PVector(int(random(pointsSpace.length)), int(random(pointsSpace.length)));
    connect[2] = new PVector(int(random(pointsSpace.length)), int(random(pointsSpace.length)));
    
    
    // START AT LEAST ONE FRAME OF THE MOVIE
    //setMovie(movFiles.get(movIndex));
    //movie.play();
    //movie.jump(0);
    //movie.pause();
  }
  
  void update() {
    switch(state) {
      case CIRCLE:
        if(!movieStopped) stopMovie();
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
        animationReady = true;
      break;
      
      case ELLIPSUS:
        if(!movieStopped) stopMovie();
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
        animationReady = true;
      break;
      
      case SQUAREY:
        if(!movieStopped) stopMovie();
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
        animationReady = true;
      break;
      
      case RECTANGLE:
        if(!movieStopped) stopMovie();
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
        animationReady = true;
      break;
      
      case MOVIE:
        if(movieStopped || movie == null) {
          setMovie(movFiles.get(movIndex));
          startMovie();
        }
        if(!frameReady) return;
        pg.beginDraw();
        pg.imageMode(CENTER);
        pg.image(movie, pg.width/2, pg.height/2); 
        pg.endDraw();
        animationReady = true;
      break;
      
      case STATIC:
        if(!movieStopped) stopMovie();
        if(p == null) {
          p = loadImage(imgFiles.get(imgIndex));
        }
        pg.beginDraw();
        pg.imageMode(CORNER);
        pg.image(p, 0, 0, pg.width, pg.height); 
        pg.endDraw();
        animationReady = true;
      break;
      
      case SINE:
        if(!movieStopped) stopMovie();
        //amplitude = 24;
        //xspacing = 16;
        //theta += 0.02;
        theta += thetaValue;
        
        if(xspacing != yvalues.length) yvalues = new float[w/xspacing];
        temp = theta;
        for (int i = 0; i < yvalues.length; i++) {
          yvalues[i] = sin(temp)*amplitude;
          temp+=dx;
        }
        pg.beginDraw();
        applyToggleStyles();
        for (int i = 0; i < yvalues.length; i++) {
          pg.ellipse(i*xspacing, pg.height/2+yvalues[i], 16, 16);
        }
         
        pg.endDraw();
        animationReady = true;
      break;
      
      case THREE_LINES:
        if(!movieStopped) stopMovie();
        //theta += 0.005;
        theta += thetaValue;
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
        animationReady = true;
      break;
      
      case CELLULAR_AUTOMATA:
        if(!movieStopped) stopMovie();
        pg.beginDraw();
        applyToggleStyles();
        ca.render(pg);    // Draw the CA
        ca.generate();  // Generate the next level
        
        if (ca.finished()) {   // If we're done, clear the screen, pick a new ruleset and restart
          ca.randomize();
          ca.restart();
        }
        pg.endDraw();
        animationReady = true;
      break;
      
      case ROTATING_BALL:
        if(!movieStopped) stopMovie();
//        amplitude = 300.0;
        //theta += 0.05;
        theta += thetaValue;
        temp = theta;
        yvalues[0] = sin(temp)*amplitude;
        temp+=dx;
        
        pg.beginDraw();
        applyToggleStyles(color(0, 0, 0, 20), color(0));
        pg.rect(0, 0, pg.width*2, pg.height*2);
        pg.translate(pg.width/2, pg.height/2);
        applyToggleStyles();
        pg.rotate(radians(theta*8));
        pg.translate(0*xspacing, 600+yvalues[0]);
        pg.ellipse(0, -600, 64, 64);
        pg.endDraw();
        animationReady = true;
      break;
      
      case ARCS:
        if(!movieStopped) stopMovie();
        theta += thetaValue;
        pg.beginDraw();
        applyToggleStyles();
        pg.translate(pg.width/2, pg.height/2);
        pg.rotate(theta);
        pg.ellipseMode(CENTER);
        pg.push();
        pg.strokeWeight(16);
        pg.arc(0, random(-20, 20), 100, 100, 0, HALF_PI);
        pg.rotate(radians(120));
        pg.arc(0, random(-20, 20), 300, 300, 0, HALF_PI);
        pg.rotate(radians(120));
        pg.arc(0, random(-10, 10), 500, 500, 0, HALF_PI);
        pg.pop();
        pg.endDraw();
        animationReady = true;
      break;
      
      case ARCS_PERLIN:
        if(!movieStopped) stopMovie();
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
        animationReady = true;
      break;
      
      case DIAGONAL_BALLS:
        if(!movieStopped) stopMovie();
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
        animationReady = true;
      break;
      
      case SWING:
        if(!movieStopped) stopMovie();
        //theta += 0.02; // Increment theta (try different values for 'angular velocity' here
        //amplitude = w/3;
        theta += thetaValue;
        if(xspacing != yvalues.length) yvalues = new float[h/xspacing];
        temp = theta;
        for (int i = 0; i < yvalues.length; i++) {
          yvalues[i] = sin(temp)*map(i, 0, yvalues.length, amplitude, 0);
          temp+=dx;
        }
        pg.beginDraw();
        applyToggleStyles();
        for (int i = 0; i < yvalues.length; i++) { // A simple way to draw the wave with an ellipse at each location
          pg.ellipse(pg.width/2+yvalues[i], i*xspacing, 16, 16);
        }
         
        pg.endDraw();
        animationReady = true;
      break;
      
      case PARALLAX:
        if(!movieStopped) stopMovie();
        theta += 0.02;
        amplitude = 20;
        pg.beginDraw();
        pg.rectMode(CENTER);
        applyToggleStyles();
        pg.textSize(300);
        temp = theta;
        pg.rotate(radians(temp));
        pg.text("hello", sin(temp)*amplitude+pg.width/2, pg.height/2);
        pg.endDraw();
        animationReady = true;
      break;
      
      case FLOCK:
        if(!movieStopped) stopMovie();
        pg.beginDraw();
        applyToggleStyles();
        pg.ellipseMode(CENTER);
        flock.run(pg);
        pg.endDraw();
        animationReady = true;
      break;
      
      case CHARMORPH:
        if(!movieStopped) stopMovie();
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
        animationReady = true;
      break;
      
      case STICKYFLOCK:
        if(!movieStopped) stopMovie();
        pg.beginDraw();
        applyToggleStyles();
        pg.ellipseMode(CENTER);
        stickyFlock.run(pg);
        pg.endDraw();
        animationReady = true;
      break;
      
      case FLOCKOVERLAY:
        if(movieStopped || movie == null) {
          animation.setMovie(movFiles.get(movIndex));
          animation.startMovie();
        }
        if(!frameReady) return;
        pg.beginDraw();
        applyToggleStyles();
        pg.ellipseMode(CENTER);
        pg.imageMode(CENTER);
        pg.image(movie, pg.width/2, pg.height/2);
        flock.run(pg);
        pg.endDraw();
        animationReady = true;
      break;
      
      case QTFLOCK:
      /*
        if(movieStopped || movie == null) {
          animation.setMovie(movFiles.get(movIndex));
          animation.startMovie();
        }
        
        globalFrame = movie;
        globalFrame.loadPixels();
        if(globalFrame.pixels.length <= 0) return;
        */
        qtree = new QuadTree(new Rectangle(width/2, height/2, width, height), (int)quadTreeBoidPerSquareLimitSlider.getValue());
        for (qtBoid boid : qtflock.boids) {
          qtree.insert(new Point(boid.position.x, boid.position.y, boid));
        }
    
        pg.beginDraw();
        applyToggleStyles();
        pg.ellipseMode(CENTER);
        pg.imageMode(CORNER);
        
        //flock.run(pg);
        qtflock.display(pg);
        pg.endDraw();
        
        if (showQuadTreeCheckBox.getArrayValue()[0] == 1) {
          qtree.show();
        }
        globalSticky = false;

        //pg.image(movie, 0, 0, 0, 0); // stupid hack to advance the movie
        animationReady = true;

        //pg.image(movie, 0, 0, 0, 0);

      break;
      
      case GRADIENTS:
        color c1 = color(40);
        color c2 = color(255);
        if(millis() - timestamp > interval) {
          timestamp = millis();
          float a = pg.width/12*2;
          float b = pg.width/12*4;
          float c = pg.width/12*6;
          float d = pg.width/12*8;
          
          float e = pg.height/12*2;
          float f = pg.height/12*4;
          float g = pg.height/12*6;
          float h = pg.height/12*8;
          target0 = random(a,b);
          target1 = random(e,f);
          target2 = random(c,d);
          target3 = random(g,h);
        }
        
        
        pg.beginDraw();
        applyToggleStyles();
        pg.push();
        setGradient((int)progress0, (int)progress1, (int)progress2, (int)progress3, c1, c2, Y_AXIS);
        pg.pop();
        pg.endDraw();
        Ani.to(this, 1.5, "progress0", target0);
        Ani.to(this, 1.5, "progress1", target1);
        Ani.to(this, 1.5, "progress2", target2);
        Ani.to(this, 1.5, "progress3", target3);
        animationReady = true;
      break;
      
      case DRAW:
        if(!movieStopped) stopMovie(); 
        pg.beginDraw();
        applyToggleStyles();
        if(mousePressed) {
          pg.ellipse(mouseX, mouseY, 20, 20);
        }
        pg.endDraw();
        
        animationReady = true;
      break;
      
      case THREEDCUBE:
        
        float[][] rotationX = {
          { 1, 0, 0},
          { 0, cos(theta), -sin(theta)},
          { 0, sin(theta), cos(theta)}
        };
      
        float[][] rotationY = {
          { cos(theta), 0, sin(theta)},
          { 0, 1, 0},
          { -sin(theta), 0, cos(theta)}
        };
        
        float[][] rotationZ = {
          { cos(theta), -sin(theta), 0},
          { sin(theta), cos(theta), 0},
          { 0, 0, 1}
        };
        
        projected = new PVector[8];
        
        int index = 0;
        for (PVector v : points) {
          PVector rotated = matmul(rotationY, v);
          rotated = matmul(rotationX, rotated);
          rotated = matmul(rotationZ, rotated);
          PVector projected2d = matmul(projection, rotated);
          projected2d.mult(300);
          projected[index] = projected2d;
          //point(projected2d.x, projected2d.y);
          index++;
        }
        

      
        if(!movieStopped) stopMovie(); 
        pg.beginDraw();
        pg.translate(pg.width/2, pg.height/2);
        applyToggleStyles();
        
        for(PVector v : projected) {
          pg.stroke(255);
          pg.strokeWeight(16);
          pg.noFill();
          pg.point(v.x, v.y);
        }
        
          // Connecting
        for (int i = 0; i < 4; i++) {
          connect(i, (i+1) % 4, projected);
          connect(i+4, ((i+1) % 4)+4, projected);
          connect(i, i+4, projected);
        }
        
        pg.endDraw();
        
        animationReady = true;
        theta += 0.01;
        
      break;
      
      case THREEDLINES:
        
        float[][] rotationX1 = {
          { 1, 0, 0},
          { 0, cos(theta), -sin(theta)},
          { 0, sin(theta), cos(theta)}
        };
        
        float[][] rotationY1 = {
          { cos(theta), 0, sin(theta)},
          { 0, 1, 0},
          { -sin(theta), 0, cos(theta)}
        };
        
        float[][] rotationZ1 = {
          { cos(theta), -sin(theta), 0},
          { sin(theta), cos(theta), 0},
          { 0, 0, 1}
        };
        
        projected = new PVector[pointsSpace.length];
        
        index = 0;
        for (PVector v : pointsSpace) {
          PVector rotated = matmul(rotationY1, v);
          //rotated = matmul(rotationX1, rotated);
          //rotated = matmul(rotationZ1, rotated);
          PVector projected2d = matmul(projection, rotated);
          projected2d.mult(300);
          projected[index] = projected2d;
          //point(projected2d.x, projected2d.y);
          index++;
        }
        

      
        if(!movieStopped) stopMovie(); 
        pg.beginDraw();
        pg.translate(pg.width/2, pg.height/2);
        applyToggleStyles();
        
        for(PVector v : projected) {
          pg.stroke(255);
          pg.strokeWeight(16);
          pg.noFill();
          //pg.point(v.x, v.y);
        }
        
          // Connecting
        for (int i = 0; i < 4; i++) {
          //connect(i, (i+1) % 4, projected);
          //connect(i+4, ((i+1) % 4)+4, projected);
          //connect(i, i+4, projected);
        }
        
        for(int i = 0; i<connect.length; i++) {
        connect((int)connect[i].x, (int)connect[i].y, projected);
        }
        
        pg.endDraw();
        
        animationReady = true;
        theta += 0.01;
        
      break;
      
      case THREEDDISK:
        
        float[][] rotationX2 = {
          { 1, 0, 0},
          { 0, cos(theta), -sin(theta)},
          { 0, sin(theta), cos(theta)}
        };
        
        float[][] rotationY2 = {
          { cos(theta), 0, sin(theta)},
          { 0, 1, 0},
          { -sin(theta), 0, cos(theta)}
        };
        
        float[][] rotationZ2 = {
          { cos(theta), -sin(theta), 0},
          { sin(theta), cos(theta), 0},
          { 0, 0, 1}
        };
        
        projected = new PVector[pointsDisk.length];
        
        index = 0;
        for (PVector v : pointsDisk) {
          PVector rotated = matmul(rotationX2, v);
          rotated = matmul(rotationY2, rotated);
          rotated = matmul(rotationZ2, rotated);
          PVector projected2d = matmul(projection, rotated);
          projected2d.mult(400);
          projected[index] = projected2d;
          //point(projected2d.x, projected2d.y);
          index++;
        }
        
        
        

      
        if(!movieStopped) stopMovie(); 
        pg.beginDraw();
        pg.translate(pg.width/2, pg.height/2);
        applyToggleStyles();
        
        for(PVector v : projected) {
          pg.stroke(255);
          pg.strokeWeight(16);
          pg.noFill();
          //pg.point(v.x, v.y);
        }
        
        for (int i = 0; i < 7; i++) {
          connect(i, (i+1), projected, 8);
          //connect(i+4, ((i+1) % 4)+4, projected, 8);
          //connect(i, i+4, projected, 8);
        }
        connect(7, 0, projected, 8);
        
        //connectBezier(0, 1, 2, 3, projected);
        //connectBezier(2, 3, 4, 5, projected);
        //connectBezier(4, 5, 6,7, projected);
        //connectBezier(1, 3, 2, projected);
        //connectBezier(2, 0, 3, projected);
        //connectBezier(3, 1, 0, projected);
        
        
        pg.endDraw();
        
        animationReady = true;
        
        
        theta += 0.01;
        
      break;
      
      case THREEDSCULPTURE:
        
        float[][] rotationX3 = {
          { 1, 0, 0},
          { 0, cos(theta), -sin(theta)},
          { 0, sin(theta), cos(theta)}
        };
        
        float[][] rotationY3 = {
          { cos(theta), 0, sin(theta)},
          { 0, 1, 0},
          { -sin(theta), 0, cos(theta)}
        };
        
        float[][] rotationZ3 = {
          { cos(theta), -sin(theta), 0},
          { sin(theta), cos(theta), 0},
          { 0, 0, 1}
        };
        
        projected = new PVector[pointsSculpt1.length];
        
        index = 0;
        for (PVector v : pointsSculpt1) {
          PVector rotated = matmul(rotationY3, v);
          rotated = matmul(rotationX3, rotated);
          //rotated = matmul(rotationZ3, rotated);
          PVector projected2d = matmul(projection, rotated);
          projected2d.mult(500);
          projected[index] = projected2d;
          //point(projected2d.x, projected2d.y);
          index++;
        }
        
        
        if(!movieStopped) stopMovie(); 
        pg.beginDraw();
        pg.translate(pg.width/2, pg.height/2);
        applyToggleStyles();
        
        for(PVector v : projected) {
          pg.stroke(255);
          pg.strokeWeight(32);
          pg.noFill();
          pg.point(v.x, v.y);
        }
        

        
        
        pg.endDraw();
        
        animationReady = true;
        
        
        theta += 0.01;
        
      break;
      
    }
    
  }
  
  void display() {
  }
  
  PImage getDisplay() {
    return pg;
  }
  
  void connect(int i, int j, PVector[] points) {
    PVector a = points[i];
    PVector b = points[j];
    pg.strokeWeight(16);
    pg.stroke(255);
    pg.line(a.x, a.y, b.x, b.y);
  }
  
  void connect(int i, int j, PVector[] points, int strokeWeight) {
    PVector a = points[i];
    PVector b = points[j];
    pg.strokeWeight(strokeWeight);
    pg.stroke(255);
    pg.line(a.x, a.y, b.x, b.y);
  }
  
  void connectBezier(int i, int j, int k, int l, PVector[] points) {
    PVector a = points[i];
    PVector b = points[j];
    PVector c = points[k];
    PVector d = points[l];
    pg.strokeWeight(60);
    pg.stroke(255);
    float f = 1;
    //pg.curve(a.x, a.y, (c.x-a.x)/f, (c.y-a.y)/f, (c.x-b.x)/f, (c.y-b.y)/f, b.x, b.y);
    pg.bezier(a.x, a.y, b.x, b.y, c.x, c.y, d.x, d.y);
  }
  
  
  
  
  void nextState() {
    state++;
    state %= stateNames.length;
  }
  
  void prevState() {
    state--;
    if(state < 0) state = stateNames.length-1;
  }
  
  void randomState() {
    String s = autoStateSelection[(int)random(autoStateSelection.length-1)];
    int found = 0;
    for(int i = 0; i<stateNames.length; i++) {
      if(stateNames[i].equals(s)) {
        found = i;
        break;
      }
    }
    state = found;
    amplitude = (int)random(200,300);
    thetaValue = random(0.02, 0.06);
    xspacing = (int)random(8,16);
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
  
  Movie getFrame() {
    return movie;
  }
  
  //int getFrame() {    
  //  return ceil(movie.time() * 30) - 1;
  //}
 
  void setFrame(int n) {
    movie.play();
 
    // The duration of a single frame:
    float frameDuration = 1.0 / movie.frameRate;
 
    // We move to the middle of the frame by adding 0.5:
    float where = (n + 0.5) * frameDuration; 
 
    // Taking into account border effects:
    float diff = movie.duration() - where;
    if (diff < 0) {
      where += diff - 0.25 * frameDuration;
    }
 
    movie.jump(where);
    movie.pause();  
  }  
 
  int getLength() {
    return int(movie.duration() * movie.frameRate);
  }
  
  boolean ready() {
    return animationReady;
  }
  
  void resetReadiness() {
    animationReady = false;
  }
  
  void resetImage() {
    p = null;
  }
  
  int Y_AXIS = 1;
  int X_AXIS = 2;
  void setGradient(int x, int y, float w, float h, color c1, color c2, int axis ) {
    pg.push();
    pg.noFill();

    if (axis == Y_AXIS) {  // Top to bottom gradient
      for (int i = y; i <= y+h; i++) {
        float inter = map(i, y, y+h, 0, 1);
        color c = lerpColor(c1, c2, inter);
        pg.stroke(c);
        pg.line(x, i, x+w, i);
      }
    } else if (axis == X_AXIS) {  // Left to right gradient
      for (int i = x; i <= x+w; i++) {
        float inter = map(i, x, x+w, 0, 1);
        color c = lerpColor(c1, c2, inter);
        pg.stroke(c);
        pg.line(i, y, i, y+h);
      }
    }
    pg.pop();
  } 
 

}
