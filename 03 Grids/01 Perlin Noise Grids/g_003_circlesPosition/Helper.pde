void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      // something
    } else if (keyCode == DOWN) {
      // something else
    }
  } else {
    if (key == 's' || key == 'S') {
        saveFrame("data/export/###.jpg");
    }
  }
}
