void keyPressed() {
  if (str(key).toLowerCase().equals("c")) {
    showMouseCursorCheckBox.toggle(0);
  }
}

void mousePressed() {

  if (firstClick == false) {
    firstClick = true;
  } else {
    if (mouseActionCheckBox.getArrayValue()[2] == 1) {
      qtflock.boids.add(new qtBoid(new PVector(mouseX, mouseY)));
    }

    
  }
}

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
