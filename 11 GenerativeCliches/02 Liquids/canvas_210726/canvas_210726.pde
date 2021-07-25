// Five moving bodies
Mover[] movers = new Mover[10];

// Liquid
Liquid liquid;

void setup() {
  size(640, 360);
  reset();
  // Create liquid object
  liquid = new Liquid(0, height/2, width, height/2, 0.1);
}

void draw() {
  background(0);

  // Draw water
  liquid.display();

  for (Mover mover : movers) {

    // Is the Mover in the liquid?
    if (liquid.contains(mover)) {
      // Calculate drag force
      PVector drag = liquid.drag(mover);
      // Apply drag force to Mover
      mover.applyForce(drag);
    }

    // Gravity is scaled by mass here!
    PVector gravity = new PVector(0, 0.1*mover.mass);
    // Apply gravity
    mover.applyForce(gravity);

    // Update and display
    mover.update();
    mover.display();
    mover.checkEdges();
  }

  fill(255);
  text("click mouse to reset", 10, 30);
}

void mousePressed() {
  reset();
}

// Restart all the Mover objects randomly
void reset() {
  for (int i = 0; i < movers.length; i++) {
    movers[i] = new Mover(random(0.5, 3), 40+i*70, 0);
  }
}


/**
 * Forces (Gravity and Fluid Resistence) with Vectors 
 * by Daniel Shiffman.  
 * 
 * Demonstration of multiple force acting on bodies (Mover class)
 * Bodies experience gravity continuously
 * Bodies experience fluid resistance when in "water"
 */


class Mover {

  // position, velocity, and acceleration 
  PVector position;
  PVector velocity;
  PVector acceleration;

  // Mass is tied to size
  float mass;

  Mover(float m, float x, float y) {
    mass = m;
    position = new PVector(x, y);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
  }

  // Newton's 2nd law: F = M * A
  // or A = F / M
  void applyForce(PVector force) {
    // Divide by mass 
    PVector f = PVector.div(force, mass);
    // Accumulate all forces in acceleration
    acceleration.add(f);
  }

  void update() {

    // Velocity changes according to acceleration
    velocity.add(acceleration);
    // position changes by velocity
    position.add(velocity);
    // We must clear acceleration each frame
    acceleration.mult(0);
  }

  // Draw Mover
  void display() {
    stroke(255);
    strokeWeight(2);
    fill(255, 200);
    ellipse(position.x, position.y, mass*16, mass*16);
  }

  // Bounce off bottom of window
  void checkEdges() {
    if (position.y > height) {
      velocity.y *= -0.9;  // A little dampening when hitting the bottom
      position.y = height;
    }
  }
}


/**
 * Forces (Gravity and Fluid Resistence) with Vectors 
 * by Daniel Shiffman.  
 * 
 * Demonstration of multiple force acting on bodies (Mover class)
 * Bodies experience gravity continuously
 * Bodies experience fluid resistance when in "water"
 */

// Liquid class 
class Liquid {


  // Liquid is a rectangle
  float x, y, w, h;
  // Coefficient of drag
  float c;

  Liquid(float x_, float y_, float w_, float h_, float c_) {
    x = x_;
    y = y_;
    w = w_;
    h = h_;
    c = c_;
  }

  // Is the Mover in the Liquid?
  boolean contains(Mover m) {
    PVector l = m.position;
    if (l.x > x && l.x < x + w && l.y > y && l.y < y + h) {
      return true;
    } else {
      return false;
    }
  }

  // Calculate drag force
  PVector drag(Mover m) {
    // Magnitude is coefficient * speed squared
    float speed = m.velocity.mag();
    float dragMagnitude = c * speed * speed;

    // Direction is inverse of velocity
    PVector drag = m.velocity.copy();
    drag.mult(-1);

    // Scale according to magnitude
    drag.setMag(dragMagnitude);
    return drag;
  }

  void display() {
    noStroke();
    fill(127);
    rect(x, y, w, h);
  }
}
