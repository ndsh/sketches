void keyPressed() {
  if (key == CODED) {
    if (keyCode == LEFT) {
      
    } else if (keyCode == RIGHT) {
      
    } 
  } else if (key == 'h') {
    showCP5 = !showCP5;
    if(showCP5) cp5.show();
    else cp5.hide();
  }
}
