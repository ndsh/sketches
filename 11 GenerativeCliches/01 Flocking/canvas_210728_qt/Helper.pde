void keyPressed() {
  if (str(key).toLowerCase().equals("c")) {
    showMouseCursorCheckBox.toggle(0);
  }
}

void mousePressed() {

  if (firstClick == false) {
    firstClick = true;
  } else {
    if (mouseActionCheckBox.getArrayValue()[1] == 1) {//Create wall
      if (!currentWall.finished) {
        if (currentWall.addPoint(new PVector(mouseX, mouseY))) {
          currentWall = new Wall();
          walls.add(currentWall);
        }
      }
    }
    if (mouseActionCheckBox.getArrayValue()[2] == 1) {
      flock.boids.add(new Boid(new PVector(mouseX, mouseY)));
    }

    if (mouseActionCheckBox.getArrayValue()[3] == 1) {
      predators.add(new Predator(new PVector(mouseX, mouseY)));
    }
  }
}

void runPredators() {

  for (Predator predator : predators) {
    ArrayList<Point> query = qtree.query(new Circle(predator.position.x, predator.position.y, 
      300), 
      null);

    predator.wrapAround();
    predator.applyForce(predator.seekClosestBoid(query));
    predator.eatCloseBoids(query);
    predator.update();
    predator.lookForward();
    predator.display();
  }
}

void reachDesiredNumberOfBoids() {
  if (flock.boids.size() < int(desiredBoidsTextField.getStringValue())) {
    if (slowChangeCheckBox.getArrayValue()[0] == 0) {
      for (int i = flock.boids.size(); i < int(desiredBoidsTextField.getStringValue()); i++) {
        flock.boids.add(new Boid());
      }
    } else {
      flock.boids.add(new Boid());
    }
  }

  if (flock.boids.size() > int(desiredBoidsTextField.getStringValue())) {
    if (slowChangeCheckBox.getArrayValue()[0] == 0) {
      for (int i = flock.boids.size(); i > int(desiredBoidsTextField.getStringValue()); i--) {
        flock.boids.remove(flock.boids.size()-1);
      }
    } else {
      flock.boids.remove(flock.boids.size()-1);
    }
  }
}

void stabilizeFrameRate() {
  if (frameRate < 50) {
    flock.boids.remove(flock.boids.size()-1);
  }
  if (frameRate > 50) {
    flock.boids.add(new Boid());
  }
}
