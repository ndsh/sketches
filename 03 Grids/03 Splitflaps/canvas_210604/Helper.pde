void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      val++;
      if(val > nuance) val = 0;
    } else if (keyCode == DOWN) {
      val--;
      if(val < 0) val = nuance;
    }
    //flap.setTarget(val);
  }
}
