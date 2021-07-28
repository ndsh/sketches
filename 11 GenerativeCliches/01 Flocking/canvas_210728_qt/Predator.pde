class Predator extends Boid {
  float maxSpeed = 6;
  Arc visionField;

  Predator() {
    super();
    maxSpeed = 10;
    shape.scale(2);
    animation = new Animation("shark_", 4);
    animation.setScale(scale);
  }

  Predator(PVector position) {
    super();
    this.position = position;
    maxSpeed = 2;
    shape.scale(2);
    animation = new Animation("shark_", 4);
    animation.setScale(1.5);
    visionField = new Arc(position.x, position.y + 50, TWO_PI/1.5, 300);
  }

  PVector seek(PVector target, float maxForce) {
    PVector desired = PVector.sub(target, position);  // A vector pointing from the position to the target
    desired.setMag(5);

    // Steering = Desired minus Velocity
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(0.1);  // Limit to maximum steering force
    return steer;
  }

  PVector seekClosestBoid(ArrayList<Point> points) {
    Boid closestBoid = null;
    float closestDistance = 10000;
    for (Point point : points) {
      if (point.obj instanceof Boid) {
        float d = PVector.dist(position, ((Boid)point.obj).position);
        if (this.visionField.containsPoint(point.x, point.y)) {//Condense line and below in one condition
          ((Boid)point.obj).setHighlighted(true);
          if ((d > 0) && (d < closestDistance)) {
            closestDistance = d;
            closestBoid = ((Boid)point.obj);
          }
        }
      }
    }
    if (closestBoid != null) {
      //strokeWeight(2);
      //stroke(255, 0, 0);
      //line(this.position.x, this.position.y, closestBoid.position.x, closestBoid.position.y);
      return seek(closestBoid.position, 0.2);
    } else {
      return new PVector(0, 0);
    }
  }

  void eatCloseBoids(ArrayList<Point> points) {
    noFill();
    strokeWeight(1);
    stroke(255, 0, 0);
    PVector mouthPosition = new PVector(this.position.x + cos(angle - PI/2)*35, this.position.y+sin(angle - PI/2)*35);
    //circle(mouthPosition.x, mouthPosition.y, 25);
    for (Point point : points) {
      if (point.obj instanceof Boid) {
        float d = PVector.dist(mouthPosition, ((Boid)point.obj).position);

        if ((d > 0) && (d < 15)) {
          flock.boids.remove(point.obj);
        }
      }
    }
  }

  void update() {
    super.update();

    visionField.updatePosition(position.x + cos(angle-PI/2)*25, position.y + sin(angle-PI/2)*25); //shifted to be close to the eyes
    visionField.setAngle(angle);
  }

  void display() {
    super.display();
    //visionField.display();
  }

  //void display() {
  //  pushMatrix();
  //  translate(position.x, position.y);
  //  shape.setFill(color(200, 20, 10));
  //  shape(shape, 0, 0);   
  //  popMatrix();
  //}
}

class Arc {
  float radius;
  float startingAngle;
  float endingAngle;
  float centerX;
  float centerY;
  float angle;

  Arc(float x, float y, float startingAngle, float endingAngle, float radius) {
    this.centerX = x;
    this.centerY = y;
    this.startingAngle = startingAngle - PI/2;
    this.endingAngle = endingAngle - PI/2;
    this.radius = radius;
  }

  Arc(float x, float y, float angle, float radius) {
    this.centerX = x;
    this.centerY = y;
    this.startingAngle = -angle/2 - PI/2;
    this.endingAngle = angle/2 - PI/2;
    this.radius = radius;
    this.angle = angle;
  }

  void updatePosition(float x, float y) {
    this.centerX = x;
    this.centerY = y;
  }

  void rotateBy(float angle) {
    startingAngle += angle;
    endingAngle +=angle;
  }

  void setAngle(float a) {
    this.startingAngle = -angle/2 - PI/2 + (a+TWO_PI);
    this.endingAngle = angle/2 - PI/2 + (a+TWO_PI);
  }

  boolean containsPoint(float x, float y) {
    float r = sqrt( pow((x - centerX), 2) + pow((y - centerY), 2));
    float a = atan2(y - centerY, x - centerX) + PI;//+PI to shift to a standard circle

    //Convert the angle to a standard trigonometric circle
    float s = (startingAngle + PI)%TWO_PI;
    float e = (endingAngle + PI)%TWO_PI;
    //Inspired by
    //https://stackoverflow.com/questions/6270785/how-to-determine-whether-a-point-x-y-is-contained-within-an-arc-section-of-a-c
    if (r < radius) {
      if (s < e) {
        if (a > s && a < e) {
          return true;
        }
      }
      if (s > e) {
        if (a > s || a < e) {
          return true;
        }
      }
    }
    return false;
  }

  void display() {
    noFill();
    stroke(255);
    strokeWeight(1);
    arc(centerX, centerY, radius*2, radius*2, startingAngle, endingAngle, PIE);
  }
}
