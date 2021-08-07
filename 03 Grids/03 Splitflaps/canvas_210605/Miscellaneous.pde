class CA {
  int[] cells;     // An array of 0s and 1s 
  int generation;  // How many generations?
  int scl;         // How many pixels wide/high is each cell?

  int[] rules;     // An array to store the ruleset, for example {0,1,1,0,1,1,0,1}
  PGraphics pg;
  boolean changingBehaviour = false;

  CA(int[] r, PGraphics _pg) {
    pg = _pg;
    rules = r;
    scl = 5;
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
    if(changingBehaviour) {
      // simple changing behaviour to generate endless iterations of CAs
      if(random(100) > 50) randomSize();
      if(random(100) > 50) randomGridSize();
      if(random(100) > 50) randomCharSet();
      if(random(100) > 70) toggleBackground(true);
      else toggleBackground(false);
    }
  }
  
  void randomSize() {
    scl = (int)random(5,20);
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

//
// END OF CA CLASS
// ---------------

// The Flock (a list of Boid objects)
class Flock {
  ArrayList<Boid> boids;
  Flock() {
    boids = new ArrayList<Boid>();
  }

  void run(PGraphics pg) {
    for (Boid b : boids) {
      b.run(boids, pg);
    }
  }

  void addBoid(Boid b) {
    boids.add(b);
  }
  

}

// The Boid class
class Boid {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float r;
  float maxforce;    // Maximum steering force
  float maxspeed;    // Maximum speed
  float inc = 0;

  Boid(float x, float y) {
    acceleration = new PVector(0, 0);
    // This is a new PVector method not yet implemented in JS
    //velocity = PVector.random2D();
    // Leaving the code temporarily this way so that this example runs in JS
    float angle = random(TWO_PI);
    velocity = new PVector(cos(angle), sin(angle));
    position = new PVector(x, y);
    r = 2.0;
    maxspeed = 2;
    maxforce = 0.03;
  }

  void run(ArrayList<Boid> boids, PGraphics pg) {
    flock(boids);
    update();
    borders(pg);
    render(pg);
  }

  void applyForce(PVector force) {
    acceleration.add(force); // We could add mass here if we want A = F / M
  }

  // We accumulate a new acceleration each time based on three rules
  void flock(ArrayList<Boid> boids) {
    PVector sep = separate(boids);   // Separation
    PVector ali = align(boids);      // Alignment
    PVector coh = cohesion(boids);   // Cohesion
    // Arbitrarily weight these forces
    sep.mult(1.5);
    ali.mult(1.0);
    coh.mult(1.0);
    // Add the force vectors to acceleration
    applyForce(sep);
    applyForce(ali);
    applyForce(coh);
  }

  // Method to update position
  void update() {
    velocity.add(acceleration); // Update velocity
    velocity.limit(maxspeed); // Limit speed
    position.add(velocity);
    acceleration.mult(0); // Reset accelertion to 0 each cycle
    inc += 0.002;
  }

  // A method that calculates and applies a steering force towards a target
  // STEER = DESIRED MINUS VELOCITY
  PVector seek(PVector target) {
    PVector desired = PVector.sub(target, position);  // A vector pointing from the position to the target
    // Scale to maximum speed
    desired.normalize();
    desired.mult(maxspeed);

    // Above two lines of code below could be condensed with new PVector setMag() method
    // Not using this method until Processing.js catches up
    // desired.setMag(maxspeed);

    // Steering = Desired minus Velocity
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce);  // Limit to maximum steering force
    return steer;
  }

  void render(PGraphics pg) {
    // Draw a triangle rotated in the direction of velocity
    //float theta = velocity.heading2D() + radians(90);
    // heading2D() above is now heading() but leaving old syntax until Processing.js catches up
    //float temp = inc;
    
    pg.fill(200, 100);
    //pg.stroke(255);
    pg.pushMatrix();
    pg.translate(position.x, position.y);
    //pg.rotate(theta);
    //pg.ellipseMode(CENTER);
    pg.ellipse(0, 0, 10, 10);
    pg.popMatrix();
  }

  // Wraparound
  void borders(PGraphics pg) {
    if (position.x < -r) position.x = pg.width+r;
    if (position.y < -r) position.y = pg.height+r;
    if (position.x > pg.width+r) position.x = -r;
    if (position.y > pg.height+r) position.y = -r;
  }

  // Separation // Method checks for nearby boids and steers away
  
  PVector separate (ArrayList<Boid> boids) {
    float desiredseparation = 25.0f;
    PVector steer = new PVector(0, 0, 0);
    int count = 0;
    
    for (Boid other : boids) { // For every boid in the system, check if it's too close
      float d = PVector.dist(position, other.position);
      if ((d > 0) && (d < desiredseparation)) {   // If the distance is greater than 0 and less than an arbitrary amount (0 when you are yourself)
        // Calculate vector pointing away from neighbor
        PVector diff = PVector.sub(position, other.position);
        diff.normalize();
        diff.div(d);        // Weight by distance
        steer.add(diff);
        count++;            // Keep track of how many
      }
    }
    
    if (count > 0) {
      steer.div((float)count); // Average -- divide by how many
    }

    // As long as the vector is greater than 0
    if (steer.mag() > 0) {
      // First two lines of code below could be condensed with new PVector setMag() method
      // Not using this method until Processing.js catches up
      // steer.setMag(maxspeed);

      // Implement Reynolds: Steering = Desired - Velocity
      steer.normalize();
      steer.mult(maxspeed);
      steer.sub(velocity);
      steer.limit(maxforce);
    }
    return steer;
  }

  // Alignment // For every nearby boid in the system, calculate the average velocity
  PVector align (ArrayList<Boid> boids) { 
    float neighbordist = 50;
    PVector sum = new PVector(0, 0);
    int count = 0;
    for (Boid other : boids) {
      float d = PVector.dist(position, other.position);
      if ((d > 0) && (d < neighbordist)) {
        sum.add(other.velocity);
        count++;
      }
    }
    if (count > 0) {
      sum.div((float)count);
      // First two lines of code below could be condensed with new PVector setMag() method
      // Not using this method until Processing.js catches up
      // sum.setMag(maxspeed);

      // Implement Reynolds: Steering = Desired - Velocity
      sum.normalize();
      sum.mult(maxspeed);
      PVector steer = PVector.sub(sum, velocity);
      steer.limit(maxforce);
      return steer;
    } 
    else {
      return new PVector(0, 0);
    }
  }

  // Cohesion // For the average position (i.e. center) of all nearby boids, calculate steering vector towards that position
  PVector cohesion (ArrayList<Boid> boids) {
    float neighbordist = 50;
    PVector sum = new PVector(0, 0);   // Start with empty vector to accumulate all positions
    int count = 0;
    for (Boid other : boids) {
      float d = PVector.dist(position, other.position);
      if ((d > 0) && (d < neighbordist)) {
        sum.add(other.position); // Add position
        count++;
      }
    }
    if (count > 0) {
      sum.div(count);
      return seek(sum);  // Steer towards the position
    } 
    else {
      return new PVector(0, 0);
    }
  }
}



//
// END OF NORMAL FLOCKING CLASS
// ---------------

// Sticky Flocking // The Flock (a list of Boid objects)
class StickyFlock {
  ArrayList<StickyBoid> boids;

  StickyFlock() {
    boids = new ArrayList<StickyBoid>();
  }

  void run(PGraphics pg) {
    for (StickyBoid b : boids) {
      b.run(boids, pg);  // Passing the entire list of boids to each boid individually
    }
  }

  void addBoid(StickyBoid b) {
    boids.add(b);
  }
  
  void updateSize(float _size) {
    for (StickyBoid b : boids) {
      b.updateSize(_size);
    }
  }
}

// The Boid class
class StickyBoid {

  PVector position;
  PVector velocity;
  PVector acceleration;
  float r;
  float maxforce;    // Maximum steering force
  float maxspeed;    // Maximum speed
  
  float inc = 0;
  float size = 20;
  boolean isSticky = false;

  StickyBoid(float x, float y, float _size) {
    acceleration = new PVector(0, 0);
    size = _size;
    float angle = random(TWO_PI);
    velocity = new PVector(cos(angle), sin(angle));

    position = new PVector(x, y);
    r = 2.0;
    maxspeed = 2;
    maxforce = 0.03;
  }

  void run(ArrayList<StickyBoid> boids, PGraphics pg) {
    flock(boids);
    update();
    borders(pg);
    render(pg);
  }
  
  void updateSize(float _size) {
    size = _size;
  } 

  void applyForce(PVector force) {
    // We could add mass here if we want A = F / M
    acceleration.add(force);
  }

  // We accumulate a new acceleration each time based on three rules
  void flock(ArrayList<StickyBoid> boids) {
    PVector sep = separate(boids);   // Separation
    PVector ali = align(boids);      // Alignment
    PVector coh = cohesion(boids);   // Cohesion
    // Arbitrarily weight these forces
    sep.mult(1.5);
    ali.mult(1.0);
    coh.mult(1.0);
    // Add the force vectors to acceleration
    applyForce(sep);
    applyForce(ali);
    applyForce(coh);
  }

  // Method to update position
  void update() {
    // Update velocity
    velocity.add(acceleration);
    // Limit speed
    velocity.limit(maxspeed);
    position.add(velocity);
    // Reset accelertion to 0 each cycle
    acceleration.mult(0);
    
    inc += 0.002;
  }

  // A method that calculates and applies a steering force towards a target
  // STEER = DESIRED MINUS VELOCITY
  PVector seek(PVector target) {
    PVector desired = PVector.sub(target, position);  // A vector pointing from the position to the target
    // Scale to maximum speed
    desired.normalize();
    desired.mult(maxspeed);

    // Above two lines of code below could be condensed with new PVector setMag() method
    // Not using this method until Processing.js catches up
    // desired.setMag(maxspeed);

    // Steering = Desired minus Velocity
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce);  // Limit to maximum steering force
    return steer;
  }

  void render(PGraphics pg) {    
    pg.fill(200, 100);
    pg.pushMatrix();
    pg.translate(position.x, position.y);
    pg.ellipse(0, 0, size, size);
    pg.popMatrix();
  }

  // Wraparound
  void borders(PGraphics pg) {
    if (position.x < -r) position.x = pg.width+r;
    if (position.y < -r) position.y = pg.height+r;
    if (position.x > pg.width+r) position.x = -r;
    if (position.y > pg.height+r) position.y = -r;
  }

  // Separation // Method checks for nearby boids and steers away
  PVector separate (ArrayList<StickyBoid> boids) {
    float desiredseparation = 25.0f;
    PVector steer = new PVector(0, 0, 0);
    int count = 0;
    // For every boid in the system, check if it's too close
    for (StickyBoid other : boids) {
      float d = PVector.dist(position, other.position);
      // If the distance is greater than 0 and less than an arbitrary amount (0 when you are yourself)
      if ((d > 0) && (d < desiredseparation)) {
        // Calculate vector pointing away from neighbor
        PVector diff = PVector.sub(position, other.position);
        diff.normalize();
        diff.div(d);        // Weight by distance
        steer.add(diff);
        count++;            // Keep track of how many
      }
    }

    if (count > 0) {
      steer.div((float)count); // Average -- divide by how many
    }

    // As long as the vector is greater than 0
    if (steer.mag() > 0) {
      // Implement Reynolds: Steering = Desired - Velocity
      steer.setMag(maxspeed);
      steer.sub(velocity);
      steer.limit(maxforce);
    }
    return steer;
  }

  // Alignment   // For every nearby boid in the system, calculate the average velocity
  PVector align (ArrayList<StickyBoid> boids) {
    float neighbordist = 50;
    PVector sum = new PVector(0, 0);
    int count = 0;
    for (StickyBoid other : boids) {
      float d = PVector.dist(position, other.position);
      if ((d > 0) && (d < neighbordist)) {
        sum.add(other.velocity);
        count++;
      }
    }
    if (count > 0) {
      sum.div((float)count);
      // Implement Reynolds: Steering = Desired - Velocity
      sum.setMag(maxspeed);
      PVector steer = PVector.sub(sum, velocity);
      steer.limit(maxforce);
      return steer;
    } 
    else {
      return new PVector(0, 0);
    }
  }

  // Cohesion // For the average position (i.e. center) of all nearby boids, calculate steering vector towards that position
  PVector cohesion (ArrayList<StickyBoid> boids) {
    float neighbordist = 50;
    PVector sum = new PVector(0, 0);   // Start with empty vector to accumulate all positions
    int count = 0;
    for (StickyBoid other : boids) {
      float d = PVector.dist(position, other.position);
      if ((d > 0) && (d < neighbordist)) {
        sum.add(other.position); // Add position
        count++;
      }
    }
    if (count > 0) {
      sum.div(count);
      return seek(sum);  // Steer towards the position
    } 
    else {
      return new PVector(0, 0);
    }
  }
  
  PVector drag() {
    float coefficent = 0.1;
    // Magnitude is coefficient * speed squared
    float speed = velocity.mag();
    float dragMagnitude = coefficent * speed * speed;

    // Direction is inverse of velocity
    PVector drag = velocity.copy();
    drag.mult(-1);

    // Scale according to magnitude
    drag.setMag(dragMagnitude);
    return drag;
  }
}
