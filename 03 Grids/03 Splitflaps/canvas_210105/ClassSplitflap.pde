class Splitflap {
  int value = 0;
  int target = 0;
  boolean busy = false;
  float timestamp = 0;
  float interval = 80;
  float cooldown = 550;
  boolean hold = false;
  float rotation = 0;
  
  PVector pos;
  
  Splitflap() {
    pos = new PVector(width/2, height/2);
  }
  
  Splitflap(int x, int y) {
    pos = new PVector(x, y);
  }
  
  void display() {
    push();
    fill(color(0,0,value));
    noStroke();
    //rect(pos.x, pos.y, 60, 60);
    fill(0,0,nuance);
    int mapped = (int)map(value, 0, nuance, 0, vocabulary.length-1);
    
    text(vocabulary[mapped], pos.x, pos.y);
    pop();
  }
  
  void update() {
    if(hold) {
      if(millis() - timestamp > cooldown) {
        timestamp = millis();
        hold = false;
        cooldown = int(random(350, 550));
      }
    } else {
      if(millis() - timestamp > interval) {
        timestamp = millis();
        if(value != target) {
          value++;
          if(value > nuance) value = 0;
        } else if(value == target) {
          busy = false;
          hold = true;
          timestamp = millis();
        }
      }
    }
  }
  
  void setTarget(int i) {
    if(!busy) {
      target = i;
      busy = true;
    }
  }
}
