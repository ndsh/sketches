class Orbiter {
  PGraphics pg;
  PVector position;
  PVector velocity;
  PVector acceleration;
  
  Orbiter parent;
  float r;
  float maxforce;    // Maximum steering force
  float maxspeed;    // Maximum speed
  
  // rotating point next to parent
  float theta;
  float thetaIncrease;
  float distance;
  PVector outer;
  float radiusX, radiusY;
  float innerDistance;
  
  boolean drawRadius;
  
  Orbiter(PGraphics _pg, Orbiter _parent, boolean _drawRadius) {
    pg = _pg;
    parent = _parent;
    acceleration = new PVector(0, 0);
    float angle = random(TWO_PI);
    velocity = new PVector(0,0);
    position = new PVector(random(width), random(height));
    
    theta = 0;
    distance = 2;
    outer = new PVector(position.x + radiusX * cos( theta ), position.y + radiusY * sin( theta ));
    float rand = random(30,70);
    radiusX = rand;
    radiusY = rand;
    thetaIncrease = random(0.01, 0.03);
    innerDistance = random(50,80);
    
    r = 2.0;
    maxspeed = 2;
    maxforce = 0.03;
    drawRadius = _drawRadius;
    
  }
  
  Orbiter(PGraphics _pg) {
    pg = _pg;
    parent = this;
    acceleration = new PVector(0, 0);
    float angle = random(TWO_PI);
    velocity = new PVector(cos(angle), sin(angle));
    position = new PVector(width/2, height/2);
    
    theta = 0;
    distance = 2;
    radiusX = 100;
    radiusY = 100;
    outer = new PVector(position.x + radiusX * cos( theta ), position.y + radiusY * sin( theta ));
    thetaIncrease = 0.005;
    innerDistance = 20;
    
    r = 2.0;
    maxspeed = 2;
    maxforce = 0.03;
    drawRadius = true;
  }
  
  void run() {
    circularMovement();
    if(parent != this) {
      //seek(parent.getOuter());
      arrive(parent.getOuter());
      //circularMovement();
      update();
    } else {
      
    }
      
    
    
    borders();
    display();
  }
  
  void update() {
    velocity.add(acceleration);
    velocity.limit(maxspeed);
    position.add(velocity);
    acceleration.mult(0);
  }
  
  void applyForce(PVector force) {
    acceleration.add(force);
  }
  
 void seek(PVector target) {
    PVector desired = PVector.sub(target,position);
    desired.normalize();
    desired.mult(maxspeed);
    PVector steer = PVector.sub(desired,velocity);
    steer.limit(maxforce);
    applyForce(steer);
  }
  
  void display() {
    /*
    pg.beginDraw();
    pg.pushStyle();
    // just some coloring
    if(parent == this) pg.fill(255);
    else {
      pg.fill(125, 125, 255);
      pg.stroke(255);
      pg.line(position.x, position.y, parent.getPosition().x, parent.getPosition().y);
      pg.noStroke();
    }
    pg.ellipse(position.x, position.y, 20, 20);
    pg.popStyle();
    pg.endDraw();
    */
    float theta = velocity.heading() + PI/2;
    fill(175);
    stroke(0);
    pushMatrix();
    translate(position.x,position.y);
    //println("vector: "+ position);
    //println("vector: "+ outer);
    rotate(theta);
    beginShape();
    vertex(0, -r*2);
    vertex(-r, r*2);
    vertex(r, r*2);
    endShape(CLOSE);
    
    popMatrix();
    stroke(255);
    
    //line(outer.x, outer.y, position.x, position.y);
    //if(parent != this) line(parent.getPosition().x, parent.getPosition().y, position.x, position.y);
    noFill();
    if(parent != this && drawRadius) ellipse(position.x, position.y, radiusX*2, radiusX*2);
    if(parent != this && !drawRadius) line(parent.getPosition().x, parent.getPosition().y, position.x, position.y);
    if(parent == this) {
      fill(0);
      noFill();
      ellipse(position.x, position.y, radiusX*2, radiusX*2);
      fill(255);
      ellipse(outer.x, outer.y, 10, 10);
    }
    
    
    //popMatrix();
  }
  
  PVector getPosition() {
    return position;
  }
  
  PVector getOuter() {
    return outer;
  }
  
  
  void borders() {
    if (position.x < -r) position.x = width+r;
    if (position.y < -r) position.y = height+r;
    if (position.x > width+r) position.x = -r;
    if (position.y > height+r) position.y = -r;
  }
  
  void arrive(PVector target) {
    PVector desired = PVector.sub(target,position);

    // The distance is the magnitude of
    // the vector pointing from
    // location to target.
    float d = desired.mag();
    desired.normalize();
    // If we are closer than 100 pixels...
    if (d < 60) {
      //[full] ...set the magnitude
      // according to how close we are.
      // 20 = min. distance
      float m = map(d,innerDistance,60,0,maxspeed);
      desired.mult(m);
      //[end]
    } else {
      // Otherwise, proceed at maximum speed.
      desired.mult(maxspeed);
    }

    // The usual steering = desired - velocity
    PVector steer = PVector.sub(desired,velocity);
    steer.limit(maxforce);
    applyForce(steer);
  }
  
  void circularMovement() { 
   outer.x = position.x + radiusX * cos( theta );
   outer.y = position.y + radiusY * sin( theta );
   theta += thetaIncrease;
  }
  
  void boundaries() { 
    PVector desired = null;

    if (position.x < wall) {
      desired = new PVector(maxspeed, velocity.y);
    } else if (position.x > width -wall) {
      desired = new PVector(-maxspeed, velocity.y);
    }

    if (position.y < wall) {
      desired = new PVector(velocity.x, maxspeed);
    } else if (position.y > height-wall) {
      desired = new PVector(velocity.x, -maxspeed);
    }

    if (desired != null) {
      desired.normalize();
      desired.mult(maxspeed);
      PVector steer = PVector.sub(desired, velocity);
      steer.limit(maxforce);
      applyForce(steer);
    }
  }
  

}