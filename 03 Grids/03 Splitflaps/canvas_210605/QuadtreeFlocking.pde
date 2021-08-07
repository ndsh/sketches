boolean globalSticky = false;
float[] temporaries = {0,0,0};
QuadTree qtree;
qtFlock qtflock;

class qtFlock{
  ArrayList<qtBoid> boids = new ArrayList<qtBoid>();
  
  qtFlock(int nbBoids){
    for(int i = 0; i < nbBoids; i++){
      boids.add(new qtBoid());
    }
  }
  
  void display(PGraphics pg){
    for(qtBoid boid : boids){
      ArrayList<Point> query = qtree.query(new Circle(boid.position.x, boid.position.y, quadTreeBoidsPerceptionRadiuslider.getValue()), null);
      boid.stickyCheck();
      boolean d = true;
      if(globalSticky && d) {
        temporaries[0] = 0.2; //seperation
        temporaries[1] = 0.5; //alignment
        temporaries[2] = 0.5;   //cohesion
      } else {
        
        temporaries[0] = separationScaleSlider.getValue();
        temporaries[1] = alignmentScaleSlider.getValue();
        temporaries[2] = cohesionScaleSlider.getValue();
        /*
        temporaries[0] = 2;
        temporaries[1] = 1;
        temporaries[2] = 1;
        */
      }
      boid.flock(query);
      boid.wrapAround();
      boid.update();
      boid.display(pg);
    }
  }
}

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
      position.x = animation.getDisplay().width;
    }
    if (position.x > animation.getDisplay().width) {
      position.x = 0;
    }

    if (position.y < 0) {
      position.y = animation.getDisplay().height;
    }
    if (position.y > animation.getDisplay().height) {
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

  void display(PGraphics pg) {
    pg.pushMatrix();
    pg.translate(position.x, position.y);
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
      pg.fill(255);
      if(isSticky) pg.fill(255);
      //noFill();
      pg.noStroke();
      //strokeWeight(boidsStrokeWeightSlider.getValue());
      //stroke(boidsStrokeColorPicker.getColorValue());
      if(isSticky) {
        //if (boidsSizeSlider != null) circle(0, 0, boidsSizeSlider.getValue()*10);
        //for(int i = 0; i<int(random(30)); i++) {
          //if (boidsSizeSlider != null) circle(random(-10, 10), random(-10,10), boidsSizeSlider.getValue()*10);
        //}
        if (boidsSizeSlider != null) pg.circle(0, 0, boidsSizeSlider.getValue()*20);
      } else if (boidsSizeSlider != null) pg.circle(0, 0, boidsSizeSlider.getValue()*20); 

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
    pg.popMatrix();

    this.highlighted = false;
  }
  
  void stickyCheck() {
    //if(millis() - timestamp > interval) {
      //timestamp = millis();
    //println(constrain((int)position.y, 0, frame.height-1) + "/" + constrain((int)position.x, 0, frame.width-1));
    if(globalFrame == null) return;
    color c = globalFrame.pixels[constrain((int)position.y, 0, globalFrame.height-1)*globalFrame.width+constrain((int)position.x, 0, globalFrame.width-1)];
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


/***
*/



void reachDesiredNumberOfBoids() {
  if (qtflock.boids.size() < int(desiredBoidsTextField.getStringValue())) {
    if (slowChangeCheckBox.getArrayValue()[0] == 0) {
      for (int i = qtflock.boids.size(); i < int(desiredBoidsTextField.getStringValue()); i++) {
        qtflock.boids.add(new qtBoid());
      }
    } else {
      qtflock.boids.add(new qtBoid());
    }
  }

  if (qtflock.boids.size() > int(desiredBoidsTextField.getStringValue())) {
    if (slowChangeCheckBox.getArrayValue()[0] == 0) {
      for (int i = qtflock.boids.size(); i > int(desiredBoidsTextField.getStringValue()); i--) {
        qtflock.boids.remove(qtflock.boids.size()-1);
      }
    } else {
      qtflock.boids.remove(qtflock.boids.size()-1);
    }
  }
}

void stabilizeFrameRate() {
  if (frameRate < 50) {
    qtflock.boids.remove(qtflock.boids.size()-1);
  }
  if (frameRate > 50) {
    qtflock.boids.add(new qtBoid());
  }
}

/*
*/

CheckBox seekMouseOnClickCheckBox;
Slider seekMouseForceSlider;
Slider maxSpeedSlider;
Slider separationScaleSlider;
Slider separationRadiusSlider;
Slider separationMaxForceSlider; 
Slider cohesionScaleSlider;
Slider cohesionRadiusSlider;
Slider cohesionMaxForceSlider;
Slider alignmentScaleSlider;
Slider alignmentRadiusSlider;
Slider alignmentMaxForceSlider;

Textfield desiredBoidsTextField;

ColorPicker backgroundColorPicker;
boolean showBackgroundColorPicker = true;
Button backgroundColorButton;

CheckBox slowChangeCheckBox;
RadioButton mouseActionCheckBox;

Button settingsMenuButton;
boolean showSettings = false;
Accordion settingsMenu;

Slider boidsSizeSlider;
ColorPicker boidsFillColorPicker;
ColorPicker boidsStrokeColorPicker;
Slider boidsStrokeWeightSlider;
RadioButton boidApparenceRadioButton;

RadioButton mouseBehaviorRadioButton;
CheckBox showMouseCursorCheckBox;
CheckBox showMouseRadiusCheckBox;
Slider mouseRadiusSlider;
Slider mouseForceSlider;
ColorPicker mouseFillColorPicker;
ColorPicker mouseStrokeColorPicker;

CheckBox showQuadTreeCheckBox;
Slider quadTreeBoidPerSquareLimitSlider;
ColorPicker quadTreeLinesColorPicker;
Slider quadTreeBoidsPerceptionRadiuslider;

void setupUI() {
  cp5 = new ControlP5(this);

  setupSettingsMenu();
  setupBackgroundColorPicker();
  setupBarUI();
}

void setupBarUI() {

  cp5.addTextlabel("MouseClickLabel")
    .setText("Mouse click:")
    .setPosition(600, 125)
    .setColorValue(255)
    .moveTo("quadtree")
    ;
    
  //cp5.getController("MouseClickLabel").moveTo("quadtree");

  mouseActionCheckBox = cp5.addRadioButton("mouseActionCheckBox")
    .setPosition(602, 160)
    .setColorForeground(color(200))
    .setColorBackground(color(150))
    .setColorLabel(color(255))
    .setSize(10, 10)
    .setItemsPerRow(4)
    .setSpacingColumn(35)
    .setSpacingRow(20)
    .addItem("Seek", 0)
    .addItem("+ boid", 2)
    .addItem("+ Prdtr", 3)
    .activate(0)
    .moveTo("quadtree")
    ;


  slowChangeCheckBox = cp5.addCheckBox("slowChangeCheckBox")
    .setPosition(602, 140)
    .setColorForeground(color(200))
    .setColorBackground(color(150))
    .setColorLabel(color(255))
    .setSize(10, 10)
    .setItemsPerRow(3)
    .setSpacingColumn(5)
    .setSpacingRow(20)
    .addItem("Slow change", 0)
    .moveTo("quadtree")
    ;

  desiredBoidsTextField = cp5.addTextfield("desiredBoids")
    .setPosition(700, 140)
    .setSize(40, 16)
    .setStringValue("100")
    .setValue("100")
    .setFocus(false)
    .setColor(color(250))
    .setColorForeground(color(250)) 
    .setColorBackground(color(50))
    .setAutoClear(false)
    .moveTo("quadtree")
    ;

  desiredBoidsTextField.getCaptionLabel().align(ControlP5.LEFT, ControlP5.TOP_OUTSIDE);
}

void setupSettingsMenu() {
  settingsMenuButton =   cp5.addButton("SettingsButton")
    .setCaptionLabel("Settings")
    .setValue(0)
    .setPosition(600, 105)
    .setSize(60, 16)
    .moveTo("quadtree")
    ;

  Group basicGroup = cp5.addGroup("basicGroup")
    .setLabel("Boids appearance")
    .setBackgroundColor(color(0, 210))
    .setHeight(15)
    .setBackgroundHeight(250) 
    ;


  //////
  float basicGroupY = 4;
  cp5.addTextlabel("boidApparenceLabel")
    .setText("Apparence")
    .setPosition(2, basicGroupY)
    .setColorValue(255)
    .moveTo(basicGroup)
    ;

  basicGroupY += 15;
  boidApparenceRadioButton = cp5.addRadioButton("radioButton")
    .setPosition(4, basicGroupY)
    .setSize(10, 10)
    .setColorForeground(color(120))
    .setColorActive(color(255))
    .setColorLabel(color(255))
    .setItemsPerRow(3)
    .setSpacingColumn(35)
    .addItem("Arrow", 1)
    .addItem("Circle", 2)
    .addItem("Fish", 3)
    .activate(0)
    .moveTo(basicGroup)
    ;

  basicGroupY +=20;
  boidsSizeSlider = cp5.addSlider("boidsSizeSlider")
    .setLabel("Scale")
    .setPosition(4, basicGroupY)
    .setWidth(184)
    .setRange(0, 1)
    .setValue(0.5)
    .moveTo(basicGroup)
    ;

  boidsSizeSlider.getCaptionLabel().align(ControlP5.LEFT, ControlP5.CENTER);
  boidsSizeSlider.getValueLabel().align(ControlP5.RIGHT, ControlP5.CENTER);


  basicGroupY += 20;
  cp5.addTextlabel("FillColorLabel")
    .setText("Fill color")
    .setPosition(2, basicGroupY)
    .setColorValue(255)
    .moveTo(basicGroup)
    ;

  basicGroupY += 15;
  boidsFillColorPicker = cp5.addColorPicker("Boids fill color", 0, (int)basicGroupY, 150, 12)
    .moveTo(basicGroup)
    .setValue(color(255))
    ;

  basicGroupY +=75;
  boidsStrokeWeightSlider = cp5.addSlider("boidsStrokeWeightSlider")
    .setLabel("Stroke Weight")
    .setPosition(4, basicGroupY)
    .setWidth(184)
    .setRange(0, 5)
    .setValue(1)
    .moveTo(basicGroup)
    ;

  boidsStrokeWeightSlider.getCaptionLabel().align(ControlP5.LEFT, ControlP5.CENTER);
  boidsStrokeWeightSlider.getValueLabel().align(ControlP5.RIGHT, ControlP5.CENTER);

  basicGroupY +=15;
  cp5.addTextlabel("StrokeColorLabel")
    .setText("Stroke color")
    .setPosition(2, basicGroupY)
    .setColorValue(255)
    .moveTo(basicGroup)
    ;

  basicGroupY += 15;
  boidsStrokeColorPicker = cp5.addColorPicker("Boids stroke color", 0, (int)basicGroupY, 150, 12)
    .moveTo(basicGroup)
    .setValue(color(255))
    ;

  ///////
  /*
  FLOCKING GROUP
   */
  //////

  Group flockingGroup = cp5.addGroup("FlockingGroup")
    .setLabel("Flocking behavior")
    .setBackgroundColor(color(0, 210))
    .setHeight(15)
  ;
  flockingGroup.setBackgroundHeight (330);

  float y = 4;
  cp5.addTextlabel("SpeedLabel")
    .setText("Speed")
    .setPosition(2, y)
    .setColorValue(255)
    .moveTo(flockingGroup)
    ;

  y +=15;
  maxSpeedSlider = cp5.addSlider("MaxSpeed")
    .setPosition(4, y)
    .setWidth(184)
    .setRange(0, 20)
    .moveTo(flockingGroup)
    ;

  maxSpeedSlider.getCaptionLabel().align(ControlP5.LEFT, ControlP5.CENTER);
  maxSpeedSlider.getValueLabel().align(ControlP5.RIGHT, ControlP5.CENTER);

  y += 25;
  cp5.addTextlabel("SeekMouseLabel")
    .setText("Seek Mouse")
    .setPosition(2, y)
    .setColorValue(255)
    .moveTo(flockingGroup)
    ;

  y += 15;
  seekMouseForceSlider = cp5.addSlider("seekMouseForceSlider")
    .setPosition(4, y)
    .setWidth(184)
    .setRange(0, 1)
    .setValue(0.1)
    .moveTo(flockingGroup)
    ;

  seekMouseForceSlider.getCaptionLabel().align(ControlP5.LEFT, ControlP5.CENTER);
  seekMouseForceSlider.getValueLabel().align(ControlP5.RIGHT, ControlP5.CENTER);

  y += 15;
  seekMouseOnClickCheckBox = cp5.addCheckBox("seekMouseOnClickCheckBox")
    .setPosition(4, y)
    .setColorActive(color(255))
    .setColorLabel(color(255))
    .setSize(10, 10)
    .setSpacingRow(20)
    .addItem("Seek Mouse on click", 0)
    .activate(0)
    .moveTo(flockingGroup)
    ;


  ////
  y += 25;
  cp5.addTextlabel("SeparationLabel")
    .setText("Separation")
    .setPosition(2, y)
    .setColorValue(255)
    .moveTo(flockingGroup)
    ;

  y += 15;
  separationScaleSlider = cp5.addSlider("SeparationScale")
    .setPosition(4, y)
    .setWidth(184)
    .setRange(0, 10)
    .moveTo(flockingGroup)
    ;

  separationScaleSlider.getCaptionLabel().align(ControlP5.LEFT, ControlP5.CENTER);
  separationScaleSlider.getValueLabel().align(ControlP5.RIGHT, ControlP5.CENTER);

  y +=20;
  separationRadiusSlider = cp5.addSlider("SeparationRadius")
    .setPosition(4, y)
    .setWidth(184)
    .setRange(0, 100)
    .moveTo(flockingGroup)
    ;

  separationRadiusSlider.getCaptionLabel().align(ControlP5.LEFT, ControlP5.CENTER);
  separationRadiusSlider.getValueLabel().align(ControlP5.RIGHT, ControlP5.CENTER);

  y +=20;
  separationMaxForceSlider = cp5.addSlider("SeparationMaxSteerForce")
    .setPosition(4, y)
    .setWidth(184)
    .setRange(0, 1)
    .moveTo(flockingGroup)
    ;

  separationMaxForceSlider.getCaptionLabel().align(ControlP5.LEFT, ControlP5.CENTER);
  separationMaxForceSlider.getValueLabel().align(ControlP5.RIGHT, ControlP5.CENTER);
  /////

  y += 25;
  cp5.addTextlabel("CohesionLabel")
    .setText("Cohesion")
    .setPosition(2, y)
    .setColorValue(255)
    .moveTo(flockingGroup)
    ;

  y += 15;
  cohesionScaleSlider = cp5.addSlider("CohesionScale")
    .setPosition(4, y)
    .setWidth(184)
    .setRange(0, 10)
    .moveTo(flockingGroup)
    ;

  cohesionScaleSlider.getCaptionLabel().align(ControlP5.LEFT, ControlP5.CENTER);
  cohesionScaleSlider.getValueLabel().align(ControlP5.RIGHT, ControlP5.CENTER);

  y += 20;
  cohesionRadiusSlider = cp5.addSlider("CohesionRadius")
    .setPosition(4, y)
    .setWidth(184)
    .setRange(0, 100)
    .moveTo(flockingGroup)
    ;

  cohesionRadiusSlider.getCaptionLabel().align(ControlP5.LEFT, ControlP5.CENTER);
  cohesionRadiusSlider.getValueLabel().align(ControlP5.RIGHT, ControlP5.CENTER);

  y +=20;
  cohesionMaxForceSlider = cp5.addSlider("cohesionMaxSteerForce")
    .setPosition(4, y)
    .setWidth(184)
    .setRange(0, 1)
    .moveTo(flockingGroup)
    ;

  cohesionMaxForceSlider.getCaptionLabel().align(ControlP5.LEFT, ControlP5.CENTER);
  cohesionMaxForceSlider.getValueLabel().align(ControlP5.RIGHT, ControlP5.CENTER);

  ////
  y += 25;
  cp5.addTextlabel("AlignmentLabel")
    .setText("Alignment")
    .setPosition(2, y)
    .setColorValue(255)
    .moveTo(flockingGroup)
    ;

  y += 15;
  alignmentScaleSlider = cp5.addSlider("AlignmentScale")
    .setPosition(4, y)
    .setWidth(184)
    .setRange(0, 10)
    .moveTo(flockingGroup)
    ;

  alignmentScaleSlider.getCaptionLabel().align(ControlP5.LEFT, ControlP5.CENTER);
  alignmentScaleSlider.getValueLabel().align(ControlP5.RIGHT, ControlP5.CENTER);

  y += 20;
  alignmentRadiusSlider = cp5.addSlider("AlignmentRadius")
    .setPosition(4, y)
    .setWidth(184)
    .setRange(0, 100)
    .moveTo(flockingGroup)
    ;

  alignmentRadiusSlider.getCaptionLabel().align(ControlP5.LEFT, ControlP5.CENTER);
  alignmentRadiusSlider.getValueLabel().align(ControlP5.RIGHT, ControlP5.CENTER);

  y +=20;
  alignmentMaxForceSlider = cp5.addSlider("alignmentMaxSteerForce")
    .setPosition(4, y)
    .setWidth(184)
    .setRange(0, 1)
    .moveTo(flockingGroup)
    ;

  alignmentMaxForceSlider.getCaptionLabel().align(ControlP5.LEFT, ControlP5.CENTER);
  alignmentMaxForceSlider.getValueLabel().align(ControlP5.RIGHT, ControlP5.CENTER);
  ////

  separationScaleSlider.setValue(2);
  separationRadiusSlider.setValue(20);
  cohesionRadiusSlider.setValue(20);
  cohesionScaleSlider.setValue(1);
  alignmentRadiusSlider.setValue(20);
  alignmentScaleSlider.setValue(1);
  separationMaxForceSlider.setValue(0.1);
  cohesionMaxForceSlider.setValue(0.1);
  alignmentMaxForceSlider.setValue(0.1);
  maxSpeedSlider.setValue(2);

  /////
  /*
   Mouse Group
   */
  //////
  Group mouseGroup = cp5.addGroup("mouseGroup")
    .setLabel("Mouse settings & behavior")
    .setBackgroundColor(color(0, 210))
    .setHeight(15)
    .setBackgroundHeight(270) 
    ;

  float mouseGroupY = 4;
  cp5.addTextlabel("MouseBehaviorLabel")
    .setText("Behavior")
    .setPosition(2, mouseGroupY)
    .setColorValue(255)
    .moveTo(mouseGroup)
    ;

  mouseGroupY += 15;
  mouseBehaviorRadioButton = cp5.addRadioButton("mouseBehaviorRadioButton")
    .setPosition(4, mouseGroupY)
    .setSize(10, 10)
    .setColorForeground(color(120))
    .setColorActive(color(255))
    .setColorLabel(color(255))
    .setItemsPerRow(2)
    .setSpacingColumn(55)
    .addItem("Attraction", 1)
    .addItem("Repulsion", 2)
    .activate(1)
    .moveTo(mouseGroup)
    ;

  mouseGroupY +=15;
  mouseForceSlider = cp5.addSlider("mouseBehaviorMaxForceSlider")
    .setPosition(4, mouseGroupY)
    .setLabel("Force")
    .setWidth(184)
    .setRange(0, 10)
    .moveTo(mouseGroup)
    ;
  mouseForceSlider.getCaptionLabel().align(ControlP5.LEFT, ControlP5.CENTER);
  mouseForceSlider.getValueLabel().align(ControlP5.RIGHT, ControlP5.CENTER);

  mouseGroupY +=20;
  showMouseCursorCheckBox = cp5.addCheckBox("showMouseCursorCheckBox")
    .setPosition(4, mouseGroupY)
    .setColorActive(color(255))
    .setColorLabel(color(255))
    .setSize(10, 10)
    .setSpacingRow(20)
    .addItem("Show cursor (c)", 0)
    .activate(0)
    .moveTo(mouseGroup)
    ;

  mouseGroupY +=20;
  showMouseRadiusCheckBox = cp5.addCheckBox("showMouseRadiusCheckBox")
    .setPosition(4, mouseGroupY)
    .setColorActive(color(255))
    .setColorLabel(color(255))
    .setSize(10, 10)
    .setSpacingRow(20)
    .addItem("Show radius", 0)
    .moveTo(mouseGroup)
    ;

  mouseGroupY +=15;
  mouseRadiusSlider = cp5.addSlider("mouseRadiusSlider")
    .setPosition(4, mouseGroupY)
    .setLabel("Radius")
    .setWidth(184)
    .setRange(0, width/2)
    .setValue(100)
    .moveTo(mouseGroup)
    ;
  mouseRadiusSlider.getCaptionLabel().align(ControlP5.LEFT, ControlP5.CENTER);
  mouseRadiusSlider.getValueLabel().align(ControlP5.RIGHT, ControlP5.CENTER);

  mouseGroupY += 20;
  cp5.addTextlabel("mouseFillColorLabel")
    .setText("Fill color")
    .setPosition(2, mouseGroupY)
    .setColorValue(255)
    .moveTo(mouseGroup)
    ;

  mouseGroupY += 15;
  mouseFillColorPicker = cp5.addColorPicker("mouseFillColorPicker", 0, (int)mouseGroupY, 150, 12)
    .moveTo(mouseGroup)
    .setColorValue(color(255, 255, 255, 0))
    ;

  mouseGroupY += 70;
  cp5.addTextlabel("mouseStrokeColorLabel")
    .setText("Stroke color")
    .setPosition(2, mouseGroupY)
    .setColorValue(255)
    .moveTo(mouseGroup)
    ;

  mouseGroupY += 15;
  mouseStrokeColorPicker = cp5.addColorPicker("mouseStrokeColorPicker", 0, (int)mouseGroupY, 150, 12)
    .moveTo(mouseGroup)
    .setColorValue(color(255, 0, 0))
    ;

  //////
  /*
   QuadTree Menu
   */
  //////
  Group quadTreeGroup = cp5.addGroup("quadTreeGroup")
    .setLabel("QuadTree")
    .setBackgroundColor(color(0, 210))
    .setHeight(15)
    .setBackgroundHeight(130) 
    ;

  float quadTreeGroupY = 4;      
  showQuadTreeCheckBox = cp5.addCheckBox("checkBox")
    .setPosition(4, quadTreeGroupY)
    .setColorForeground(color(200))
    .setColorBackground(color(150))
    .setColorLabel(color(255))
    .setSize(10, 10)
    .setItemsPerRow(3)
    .setSpacingColumn(5)
    .setSpacingRow(20)
    .addItem("Show tree", 0)
    .moveTo(quadTreeGroup)
    ;

  quadTreeGroupY += 20;
  quadTreeLinesColorPicker = cp5.addColorPicker("quadTreeLinesColorPicker", 0, (int)quadTreeGroupY, 150, 12)
    .moveTo(quadTreeGroup)
    .setColorValue(color(0, 255, 255, 200))
    ;

  quadTreeGroupY +=65;
  quadTreeBoidPerSquareLimitSlider = cp5.addSlider("quadTreeBoidPerSquareLimitSlider")
    .setPosition(4, quadTreeGroupY)
    .setLabel("Boid limit/square")
    .setWidth(184)
    .setRange(1, 20)
    .setValue(6)
    .setNumberOfTickMarks(20)
    .moveTo(quadTreeGroup)
    ;
  quadTreeBoidPerSquareLimitSlider.getCaptionLabel().align(ControlP5.LEFT, ControlP5.CENTER);
  quadTreeBoidPerSquareLimitSlider.getValueLabel().align(ControlP5.RIGHT, ControlP5.CENTER);

  quadTreeGroupY +=25;
  quadTreeBoidsPerceptionRadiuslider = cp5.addSlider("quadTreeBoidsPerceptionRadiuslider")
    .setPosition(4, quadTreeGroupY)
    .setLabel("Boid perception radius")
    .setWidth(184)
    .setRange(1, 200)
    .setValue(30)
    .moveTo(quadTreeGroup)
    ;
  quadTreeBoidsPerceptionRadiuslider.getCaptionLabel().align(ControlP5.LEFT, ControlP5.CENTER);
  quadTreeBoidsPerceptionRadiuslider.getValueLabel().align(ControlP5.RIGHT, ControlP5.CENTER);


  //////
  /*
   Walls Menu
   */
  //////
  

  /////
  settingsMenu = cp5.addAccordion("Settings")
    .setPosition(600, 180)
    .setWidth(190 )
    .addItem(basicGroup)
    .addItem(flockingGroup)
    .addItem(mouseGroup)
    .addItem(quadTreeGroup)
    ;

  //boidsMenu.open(0, 1);
  settingsMenu.setCollapseMode(Accordion.MULTI);
  settingsMenu.setVisible(true);
  settingsMenu.moveTo("quadtree");
}

void setupBackgroundColorPicker() {
  backgroundColorPicker = cp5.addColorPicker("backgroundColorPicker")
    .setPosition(680, 105)
    .setColorValue(color(50))
    ;

  backgroundColorPicker.setVisible(showBackgroundColorPicker);

  backgroundColorButton = cp5.addButton("BG Color")
    .setValue(0)
    .setPosition(660, 105)
    .setColorBackground(backgroundColorPicker.getColorValue())
    .setSize(60, 16)
    .moveTo("quadtree")
    ;
}

void controlEvent(ControlEvent theEvent) {
  if (theEvent.isFrom("SettingsButton")) {
    if (settingsMenu != null) {
      showSettings = !showSettings;
      settingsMenu.setVisible(showSettings);
    }
  }

  if (theEvent.isFrom("backgroundColorPicker")) {
    if (backgroundColorButton != null)
      backgroundColorButton.setColorBackground(backgroundColorPicker.getColorValue());
  }
  if (theEvent.isFrom("BG Color")) {
    showBackgroundColorPicker = !showBackgroundColorPicker;
    backgroundColorPicker.setVisible(showBackgroundColorPicker);
  }

  

  if (theEvent.isFrom("desiredBoids")) {
    println(desiredBoidsTextField.getStringValue());
  }

  if (theEvent.isFrom("boidsSizeSlider")) {
    if (boidsSizeSlider != null) {
      for (qtBoid boid : qtflock.boids) {
        boid.changeScale(boidsSizeSlider.getValue());
      }
    }
  }

  
  
  if(theEvent.isFrom("mouseActionCheckBox")){
    firstClick = false;
  }
}

void drawUI() {
  push();
  fill(10);
  noStroke();

  rectMode(CORNER);
  rect(0, 0, width, 20);
  //rect(0, height-30, width, 30);//Bottom bar

  fill(255);
  textAlign(RIGHT, CENTER);
  text((int)frameRate + " fps", width, 10);

  text(qtflock.boids.size() + " boids /", width - 95, 10);
  pop();
}

/////

class Point {
  float x;
  float y;
  Object obj;

  Point(float x, float y, Object obj) {
    this.x = x;
    this.y = y;
    this.obj = obj;
  }
}

class QuadTree {

  Rectangle boundary;
  int capacity;
  ArrayList<Point> points = new ArrayList<Point>();
  Boolean divided = false;

  QuadTree northWest;
  QuadTree northEast;
  QuadTree southWest;
  QuadTree southEast;

  QuadTree(Rectangle boundary, int capacity) {
    this.boundary = boundary;
    this.capacity = capacity;
  }

  boolean insert(Point point) {
    if (!this.boundary.contains(point)) {
      return false;
    }

    if (this.points.size() < this.capacity) {
      this.points.add(point);
      return true;
    }

    if (!this.divided) {
      this.subdivide();
    }

    return(
      this.northEast.insert(point) ||
      this.northWest.insert(point) ||
      this.southWest.insert(point) ||
      this.southEast.insert(point)
      );
  }

  void subdivide() {
    float x = this.boundary.x;
    float y = this.boundary.y;
    float w = this.boundary.w /2;
    float h = this.boundary.h /2;

    Rectangle ne = new Rectangle(x + w, y - h, w, h);
    this.northEast = new QuadTree(ne, this.capacity);

    Rectangle nw = new Rectangle(x - w, y - h, w, h);
    this.northWest = new QuadTree(nw, this.capacity);

    Rectangle se = new Rectangle(x + w, y + h, w, h);
    this.southEast = new QuadTree(se, this.capacity);

    Rectangle sw = new Rectangle(x - w, y + h, w, h);
    this.southWest = new QuadTree(sw, this.capacity);

    this.divided = true;
  }

  ArrayList<Point> query(SelectionShapeInterface range, ArrayList<Point> found) {
    if (found == null) {
      found = new ArrayList<Point>();
    }

    if (!range.intersects(this.boundary)) {
      return found;
    }

    for (Point p : this.points) {
      if (range.contains(p)) {
        found.add(p);
      }
    }

    if (this.divided) {
      this.northWest.query(range, found);
      this.northEast.query(range, found);
      this.southWest.query(range, found);
      this.southEast.query(range, found);
    }
    
    return found;
  }

  void show() {
    rectMode(RADIUS);
    noFill();
    strokeWeight(1);
    stroke(quadTreeLinesColorPicker.getColorValue());
    rect(boundary.x, boundary.y, boundary.w, boundary.h);

    if (this.divided) {
      this.northEast.show();
      this.northWest.show();
      this.southEast.show();
      this.southWest.show();
    }
    /*
    for (Point point : points) {
      fill(255);
      noStroke();
      circle(point.x, point.y, 5);
    }
    */
  }
}
class Obstacle {
  PVector position;
  Obstacle(PVector pos) {
    this.position = pos;
  }
}

class SelectionShape{
  float x;
  float y;
}
interface SelectionShapeInterface{
  boolean intersects(Rectangle shape);
  boolean contains(Point point);
}

class Rectangle extends SelectionShape implements SelectionShapeInterface {
  float w;
  float h;

  Rectangle(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    ;
    this.w = w;
    this.h = h;
  }

  float left() {
    return this.x - this.w / 2;
  }

  float right() {
    return this.x + this.w / 2;
  }

  float top() {
    return this.y - this.h / 2;
  }

  float bottom() {
    return this.y + this.h / 2;
  }

  boolean contains(Point point) {
    return (point.x >= this.x - this.w &&
      point.x <= this.x + this.w &&
      point.y >= this.y - this.h &&
      point.y <= this.y + this.h);
  }

  boolean intersects(Rectangle range) {
    return !(range.x - range.w > this.x + this.w ||
      range.x + range.w < this.x - this.w ||
      range.y - range.h > this.y + this.h ||
      range.y + range.h < this.y - this.h);
  }
}

/*
  Translated from https://github.com/CodingTrain/QuadTree/blob/master/quadtree.js
 */
class Circle extends SelectionShape implements SelectionShapeInterface {
  float r;
  float rSquared;

  Circle(float x, float y, float r) {
    this.x = x;
    this.y = y;
    this.r = r;
    this.rSquared = this.r * this.r;
  }

  boolean contains(Point point) {
    // check if the point is in the circle by checking if the euclidean distance of
    // the point and the center of the circle if smaller or equal to the radius of
    // the circle
    float d = pow((point.x - this.x), 2) + pow((point.y - this.y), 2);
    return d <= this.rSquared;
  }

  boolean intersects(Rectangle range) {
    float xDist = Math.abs(range.x - this.x);
    float yDist = Math.abs(range.y - this.y);

    // radius of the circle
    float r = this.r;

    float w = range.w;
    float h = range.h;

    float edges = pow((xDist - w), 2) + pow((yDist - h), 2);

    // no intersection
    if (xDist > (r + w) || yDist > (r + h))
      return false;

    // intersection within the circle
    if (xDist <= w || yDist <= h)
      return true;

    // intersection on the edge of the circle
    return edges <= this.rSquared;
  }
}
