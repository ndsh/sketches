// Sticky Flocking
// The Flock (a list of Boid objects)
class StickyFlock {
  ArrayList<StickyBoid> boids; // An ArrayList for all the boids

  StickyFlock() {
    boids = new ArrayList<StickyBoid>(); // Initialize the ArrayList
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
  
  float sticky;
  boolean isSticky = false;
  
  float c = 0.1;
  
  PVector sep;   // Separation
  PVector ali;      // Alignment
  PVector coh;  // Cohesion
  
  long timestamp = 0;
  long interval = 5000;

  StickyBoid(float x, float y, float _size) {
    acceleration = new PVector(0, 0);
    size = _size;
    // This is a new PVector method not yet implemented in JS
    // velocity = PVector.random2D();

    // Leaving the code temporarily this way so that this example runs in JS
    float angle = random(TWO_PI);
    velocity = new PVector(cos(angle), sin(angle));

    position = new PVector(x, y);
    r = 2.0;
    maxspeed = 3;
    maxforce = 0.03;
  }

  void run(ArrayList<StickyBoid> boids, PGraphics pg) {
    stickyCheck(pg);
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
    sep = separate(boids);   // Separation
    ali = align(boids);      // Alignment
    coh = cohesion(boids);   // Cohesion
    // Arbitrarily weight these forces
    if(isSticky) {
      sep.mult(0);
      ali.mult(0);
      coh.mult(0.0);
    } else {
      sep.mult(1.5);
      ali.mult(1.0);
      coh.mult(1.0);
    }
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
    
    if(sticky > 0.5) {
      PVector drag = drag();
      // Apply drag force to Mover
      applyForce(drag);
      size = 5;
      isSticky = true; 
    } else {
      size = 5;
      isSticky = false;
    }
    
    
    
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
    float theta = velocity.heading2D() + radians(90);
    // heading2D() above is now heading() but leaving old syntax until Processing.js catches up
    float temp = inc;
    
    pg.fill(255);
    pg.noStroke();
    //pg.stroke(255);
    pg.pushMatrix();
    pg.translate(position.x, position.y);
    //pg.rotate(theta);
    /*pg.beginShape(TRIANGLES);
    pg.vertex(0, -r*2);
    pg.vertex(-r, r*2);
    pg.vertex(r, r*2);
    pg.endShape();
    */
    //pg.ellipseMode(CENTER);
    pg.ellipse(0, 0, size, size);
    pg.popMatrix();
  }
  
  /*
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
  */

  // Wraparound
  void borders(PGraphics pg) {
    if (position.x < -r) position.x = pg.width+r;
    if (position.y < -r) position.y = pg.height+r;
    if (position.x > pg.width+r) position.x = -r;
    if (position.y > pg.height+r) position.y = -r;
  }

  // Separation
  // Method checks for nearby boids and steers away
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
    // Average -- divide by how many
    if (count > 0) {
      steer.div((float)count);
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

  // Alignment
  // For every nearby boid in the system, calculate the average velocity
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

  // Cohesion
  // For the average position (i.e. center) of all nearby boids, calculate steering vector towards that position
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
  
  // StickyCheck
  // check the underground of the boid for a color from the current frame
  void stickyCheck(PGraphics pg) {
    if(millis() - timestamp > interval) {
      timestamp = millis();
    //println(constrain((int)position.y, 0, frame.height-1) + "/" + constrain((int)position.x, 0, frame.width-1));
    color c = frame.pixels[constrain((int)position.y, 0, frame.height-1)*frame.width+constrain((int)position.x, 0, frame.width-1)];
    globalColor = c;
    //println(brightness(c));
    sticky = map(brightness(c), 0, 255, 0.0, 1.0);
    }
    //sticky = map(brightness(c), 0, 255, 255, 0);
    //sticky = new PVector(t, t);
    //globalColor = pg.get(round(position.x), round(position.y));
    
  }
  
  PVector drag() {
    // Magnitude is coefficient * speed squared
    float speed = velocity.mag();
    float dragMagnitude = c * speed * speed;

    // Direction is inverse of velocity
    PVector drag = velocity.copy();
    drag.mult(-1);

    // Scale according to magnitude
    drag.setMag(dragMagnitude);
    return drag;
  }
}
