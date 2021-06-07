class Splitflap {
  int value = 0;
  int target = 0;
  boolean busy = false;
  float timestamp = 0;
  float interval = 0; // war 80
  float originalInterval = 0;
  float cooldown = 0;
  boolean hold = false;
  
  int nuance = 0;
  String vocabulary = "";
  
  boolean slowTrail = false; // mode if the trailing is linear or some kind of "slowing" down
  float inc = 1;
  float decrease = 0.1; // 0.032;
  
  PVector pos;
  
  Splitflap(float x, float y, int n, String sorted, float _interval, float _cooldown) {
    vocabulary = sorted;
    nuance = n;
    pos = new PVector(x, y);
    interval = _interval;
    originalInterval = interval;
    cooldown = _cooldown;
  }
  
  Splitflap(int x, int y) {
    pos = new PVector(x, y);
  }
  
  void display() {
    int mapped = (int)map(value, 0, nuance, 0, vocabulary.length()-1);
    text(vocabulary.charAt(mapped), pos.x, pos.y);
  }
  
  void display(PGraphics pg) {
    int mapped = (int)map(value, 0, nuance, 0, vocabulary.length()-1);;
    pg.text(vocabulary.charAt(mapped), pos.x, pos.y);
  }
  
  void update() {
    if(hold) {
      if(millis() - timestamp > cooldown) {
        timestamp = millis();
        hold = false;
        //cooldown = 1; //int(random(350, 550));
      }
    } else {
      if(millis() - timestamp > interval) {
        timestamp = millis();
        if(value != target) {
          if(slowTrail) {
            if(interval >= decrease) interval -= decrease;
            
          }
          value += inc;
          
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
      interval = originalInterval;
      decrease = interval/nuance;
    }
  }
  
  void updateInterval(float f) {
    interval = f;
  }
  
  void updateCooldown(float f) {
    cooldown = f;
  }
  
  void toggleSlowtrail() {
    slowTrail = !slowTrail;
  }
}
