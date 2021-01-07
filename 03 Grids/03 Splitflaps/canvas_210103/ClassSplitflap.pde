class Splitflap {
  int value = 0;
  int target = 0;
  boolean busy = false;
  float timestamp = 0;
  float interval = 10;
  
  Splitflap() {
  }
  
  void display() {
    push();
    fill(color(0,0,value));
    rect(width/2, height/2, 60, 60);
    fill(255);
    int mapped = (int)map(value, 0, nuance, 0, vocabulary.length-1);
    
    text(vocabulary[mapped], width/2, height/2);
    pop();
  }
  
  void update() {
    if(millis() - timestamp > interval) {
      timestamp = millis();
      if(value != target) {
        value++;
        if(value > nuance) value = 0;
      } else if(value == target) busy = false;
    }
    
  }
  
  void setTarget(int i) {
    if(!busy) {
      target = i;
      busy = true;
    }
  }
}
