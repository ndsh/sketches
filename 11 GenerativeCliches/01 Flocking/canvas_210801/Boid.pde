class qtBoid {
  //Parameters
  PVector position = new PVector(random(width), random(height));
  PVector acceleration = new PVector();
  PVector velocity = new PVector(random(-3, 3), random(-3, 3));

  

  PShape shape;
  float angle = 0;
  color c = color(random(0, 100), random(50, 200), random(50, 200));
  float scale = random(0.6, 1);

  boolean highlighted = false;
  
  float sticky;
  boolean isSticky = false;
  
  float coefficent = 0.7; // for dragging

  qtBoid() {
    setupShape(0.5);
  }

  qtBoid(PVector position) {
    this.position = position;
    setupShape(0.5);
  }

  void setupShape(float scale) {
    shape = createShape();
    shape.beginShape();
    shape.vertex(-10, 10);
    shape.vertex(0, 0);
    shape.vertex(10, 10);
    shape.vertex(0, -20);
    shape.endShape(CLOSE);
    shape.scale(scale);
    angle = 0;
  }

  void wrapAround() {
    if (position.x < 0) {
      position.x = width;
    }
    if (position.x > width) {
      position.x = 0;
    }

    if (position.y < 0) {
      position.y = height;
    }
    if (position.y > height) {
      position.y = 0;
    }
  }

  PVector separationVector(ArrayList<Point> points) {
    PVector steer = new PVector();
    int count = 0;

    for (Point point : points) {
      if (point.obj instanceof qtBoid) {
        float d = PVector.dist(position, ((qtBoid)point.obj).position);

        if ((d > 0) && (d < separationRadiusSlider.getValue()/2)) {
          PVector diff = PVector.sub(position, ((qtBoid)point.obj).position);
          diff.normalize();
          diff.div(d);
          steer.add(diff);
          count++;
        }
      }
    }

    // Average
    if (count > 0) {
      steer.div((float)count);
    }

    if (steer.mag() > 0) {
      // Implement Reynolds: Steering = Desired - Velocity
      steer.setMag(maxSpeedSlider.getValue());
      steer.sub(velocity);
      steer.limit(separationMaxForceSlider.getValue());
    }
    return steer;
  }

  PVector alignmentVector (ArrayList<Point> points) {
    PVector sum = new PVector(0, 0);
    int count = 0;
    for (Point point : points) {
      if (point.obj instanceof qtBoid) {
        float d = PVector.dist(position, ((qtBoid)point.obj).position);
        if ((d > 0) && (d < alignmentRadiusSlider.getValue()/2)) {
          sum.add(((qtBoid)point.obj).velocity);
          count++;
        }
      }
    }
    if (count > 0) {
      sum.div((float)count);
      sum.setMag(maxSpeedSlider.getValue());
      PVector steer = PVector.sub(sum, velocity);
      steer.limit(alignmentMaxForceSlider.getValue());
      return steer;
    } else {
      return new PVector();
    }
  }

  PVector cohesionVector(ArrayList<Point> points) {
    PVector sum = new PVector();
    int count = 0;
    for (Point point : points) {
      if (point.obj instanceof qtBoid) {
        float d = PVector.dist(position, ((qtBoid)point.obj).position);
        if ((d > 0) && (d < cohesionRadiusSlider.getValue()/2)) {
          sum.add(((qtBoid)point.obj).position);
          count++;
        }
      }
    }
    if (count > 0) {
      sum.div(count);
      return seek(sum, cohesionMaxForceSlider.getValue());
    } else {
      return new PVector();
    }
  }

  PVector avoidanceVector(PVector pos) {
    PVector result = new PVector();
    float d = PVector.dist(position, pos);

    if ((d > 0) && (d < 150)) {
      result = seek(pos, 1);
    }

    return result.mult(-1);
  }

  

  PVector avoidPosition(PVector position, float distance) {
    float d = PVector.dist(this.position, position);
    if ((d > 0) && (d < distance)) {
      return seek(position, 3).mult(-1);
    } else return new PVector();
  }

  PVector seekPosition(PVector position, float distance) {
    float d = PVector.dist(this.position, position);
    if ((d > 0) && (d < distance)) {
      return seek(position, 3);
    } else return new PVector();
  }

  void lookForward() {
    PVector up = new PVector(0, -1);
    float a = PVector.angleBetween(velocity, up);
    if (velocity.x < 0) {
      a = -a;
    }

    shape.rotate(-angle);
    angle = 0;
    shape.rotate(a);
    angle += a;
  }

  void averageColor(ArrayList<qtBoid> boids) {
    PVector averageColor = new PVector(red(c), green(c), blue(c));
    int total = 1;
    for (qtBoid other : boids) {
      if (this.position.dist(other.position) < 20 && other != this) {
        averageColor.set(averageColor.x + red(other.c), averageColor.y + green(other.c), averageColor.z + blue(other.c));
        total++;
      }
    }

    averageColor.div((float)total);
    this.c = color(averageColor.x, averageColor.y, averageColor.z);
  }

  void applyForce(PVector force) {
    acceleration.add(force);
  }

  PVector seek(PVector target, float maxForce) {
    PVector desired = PVector.sub(target, position);  // A vector pointing from the position to the target
    desired.setMag(maxSpeedSlider.getValue());

    // Steering = Desired minus Velocity
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxForce);  // Limit to maximum steering force
    return steer;
  }

  void flock(ArrayList<Point> points) {
    //Flocking
    if(isSticky) {
      //applyForce(separationVector(points).mult(0)); // ergibt das inverse
      //applyForce(separationVector(points).mult(10)); // jittery 
      //applyForce(alignmentVector(points).mult(10));
      applyForce(separationVector(points).mult(1.5));
      applyForce(alignmentVector(points).mult(0.0));
      applyForce(cohesionVector(points).mult(0.0));
    } else {
      applyForce(separationVector(points).mult(temporaries[0]));
      applyForce(alignmentVector(points).mult(temporaries[1]));
      applyForce(cohesionVector(points).mult(temporaries[2]));
    }
    


//    applyForce(avoidPredators(predators).mult(0.08));

    //Mouse behavior
    int behavior = mouseBehaviorRadioButton.getArrayValue()[0] == 0 ? 1 : -1;
    applyForce(avoidPosition(new PVector(mouseX, mouseY), 
      mouseRadiusSlider.getValue()/4)
      .mult(mouseForceSlider.getValue())
      .mult(behavior)
      );

    if (mouseActionCheckBox.getArrayValue()[0] == 1) {
      if (seekMouseOnClickCheckBox.getArrayValue()[0] == 0 || (mousePressed && seekMouseOnClickCheckBox.getArrayValue()[0] == 1)) {
        applyForce(seek(new PVector(mouseX, mouseY), seekMouseForceSlider.getValue()));
      }
    }


  }

  void update() {
    if(isSticky) {
      /*
      velocity.add(new PVector(0,0));
      velocity.limit(maxSpeedSlider.getValue());
      position.add(new PVector(0,0));
  
      acceleration.mult(0);
      */
      velocity.add(acceleration);
      velocity.limit(maxSpeedSlider.getValue());
      position.add(velocity);

      acceleration.mult(0);
    
      PVector drag = drag();
      // Apply drag force to Mover
      applyForce(drag);
    } else {
    velocity.add(acceleration);
    velocity.limit(maxSpeedSlider.getValue());
    position.add(velocity);

    acceleration.mult(0);
    }
  }

  void setHighlighted(boolean h) {
    this.highlighted = h;
  }

  void changeScale(float scale) {
    setupShape(scale);
  }

  void display() {
    pushMatrix();
    translate(position.x, position.y);
/*
    if (boidApparenceRadioButton.getArrayValue()[0] == 1) {//Arrow
      if (!this.highlighted) {
        shape.setFill(boidsFillColorPicker.getColorValue());
        shape.setStroke(boidsStrokeColorPicker.getColorValue());
        shape.setStrokeWeight(boidsStrokeWeightSlider.getValue());
      } else {
        shape.setStroke(boidsStrokeColorPicker.getColorValue());
        shape.setStrokeWeight(boidsStrokeWeightSlider.getValue());
        shape.setFill(color(230, 20, 20, 255));
      }
      shape(shape, 0, 0);
    } else if (boidApparenceRadioButton.getArrayValue()[1] == 1) {//Circle
    */
      //if(isSticky)     fill(255, 0, 0); 
      //else     fill(boidsFillColorPicker.getColorValue());
      float colorMappedX = map(velocity.x, 0, 2, 120, 255);
      float colorMappedY = map(velocity.y, 0, 2, 120, 255);
      float avg = (colorMappedX + colorMappedY)/2;
      
      //fill(boidsFillColorPicker.getColorValue());
      fill(avg);
      if(isSticky) fill(255);
      //noFill();
      noStroke();
      //strokeWeight(boidsStrokeWeightSlider.getValue());
      //stroke(boidsStrokeColorPicker.getColorValue());
      if(isSticky) {
        //if (boidsSizeSlider != null) circle(0, 0, boidsSizeSlider.getValue()*10);
        //for(int i = 0; i<int(random(30)); i++) {
          //if (boidsSizeSlider != null) circle(random(-10, 10), random(-10,10), boidsSizeSlider.getValue()*10);
        //}
        if (boidsSizeSlider != null) circle(0, 0, boidsSizeSlider.getValue()*20);
      } else if (boidsSizeSlider != null) circle(0, 0, boidsSizeSlider.getValue()*20); 

       /* 
    } else if (boidApparenceRadioButton.getArrayValue()[2] == 1) {//Fish
      rotate(angle);
      if (!this.highlighted) {
        noTint();
        //tint(255, 255, 255);
      } else {
        tint(255, 220, 220);
      }
      //tint(c);
      //tint(color(150,50,60));
      animation.display(0, 0);
    }
*/
    popMatrix();

    this.highlighted = false;
  }
  
  void stickyCheck() {
    //if(millis() - timestamp > interval) {
      //timestamp = millis();
    //println(constrain((int)position.y, 0, frame.height-1) + "/" + constrain((int)position.x, 0, frame.width-1));
    
    color c = movie.pixels[constrain((int)position.y, 0, movie.height-1)*movie.width+constrain((int)position.x, 0, movie.width-1)];
    //globalColor = c;
    
    sticky = map(brightness(c), 0, 255, 0.0, 1.0);
    if(sticky > 0.5) isSticky = true;
    else isSticky = false;
    if(isSticky) globalSticky = true;
    //}
    //sticky = map(brightness(c), 0, 255, 255, 0);
    //sticky = new PVector(t, t);
    //globalColor = pg.get(round(position.x), round(position.y));
    
  }
  
  PVector drag() {
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
