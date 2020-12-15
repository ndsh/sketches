class Zoomer {
 
  SawOsc saw;
  SqrOsc sqr;
  TriOsc triOsc;
  
  Env env;
  Env env2; 
  
  // Times and levels for the ASR envelope
  float attackTime = 0.001;
  float sustainTime = 0.004;
  float sustainLevel = 0.55;
  float releaseTime = 0.45;
  
  float attackTime2 = 0.001;
  float sustainTime2 = 0.004;
  float sustainLevel2 = 0.2;
  float releaseTime2 = 0.2; 
  
  // Play a new note every 200ms
  int duration = 200;
  
  // This variable stores the point in time when the next note should be triggered
  int trigger = millis(); 
  
  // An index to count up the notes
  int note = 0; 
  
  // **** ? 
  
  int pentatonics[] = {0, 60, 63, 51, 66, 67, 69, 70, 72};
  
  // a zoomer "zooms" to a pixel
  // gets its value and plays back the value against a map of pentatonics
  PVector position;
  float radius = 24;
  
  long previousMillis = 0;
  long interval = 20;
  
  long tuneMillis = 0;
  long tuneInterval = 1;
  
  boolean reachDestination = false;
  boolean snapped = false;
  boolean doneCounting = false;
  PGraphics pg; // for the snapshot
  
  float xoff = 0.0;
  float xincrement = 0.01;
  
  float yoff = 0.0;
  float yincrement = 0.01;
  
  int margin;
  float boxDimension;
  
  PGraphics src;
  
  PApplet pa;
  
  int counted = 0;
  boolean sameTune = false;
  
  public Zoomer(PApplet _pa, int _margin, float _boxDimension) {
    pa = _pa;
    
    triOsc = new TriOsc(pa);
    sqr = new SqrOsc(pa);
    saw = new SawOsc(pa);
    // Create the envelope 
    env = new Env(pa);
    env2 = new Env(pa);
    
    
    
    
    boxDimension = _boxDimension;
    margin = _margin;
    pg = createGraphics((int)radius, (int)radius);
    ellipseMode(CENTER);
    //position = new PVector(random(_margin, _boxDimension), random(_margin, _boxDimension));
    position = new PVector(width/2, height/2);
  }
  
  void update() {
    if(millis() - previousMillis > interval) {
      previousMillis = millis();
      interval = 20;
      if(reachDestination) {
        println("reset");
        snapped = false;
        reachDestination = false;
      } else {
        snap();
        // snap + tune
        // snap()
      }
    }
    if(snapped) {
      //previousMillis = millis();
      tune();
    }
    if(!reachDestination) {
      float n = noise(xoff, yoff)*boxDimension;
      float m = noise(yoff)*boxDimension;
      xoff += xincrement;
      yoff += yincrement;
      position = new PVector(n, m);
    }
  }
  
  void display() {
    ellipse(position.x, position.y, radius, radius);
  }
  void setBackground(PGraphics _src) {
    src = _src;
  }
  PGraphics getSnap() {
    return pg;
  }
  
  void snap() {
    //println("snap");
    if(!snapped) {
      //println("snap it");
      snapped = true;
      color point = color(0);
      loadPixels();
      int count = 0;
      for (int x = (int)position.x-((int)radius/2); x < (int)position.x+(int)radius/2; x+=1) {
        for (int y = (int)position.y-((int)radius/2); y < (int)position.y+(int)radius/2; y+=1) {
          point = get(x,y);
          if(brightness(point) > 128) count++;
        }
      }
      println(count);
      if(count >= 25) count = 24;
      if(counted == count) sameTune = true;
      else sameTune = false;
      counted = count;
      
    } else  ;
    //previousMillis = millis();
  }
  float midiToFreq(int note) {
    return (pow(2, ((note-69)/12.0))) * 440;
  }

  void tune() {
    if(millis() - tuneMillis > tuneInterval) {
      tuneMillis = millis();
      
      //println("count'n'tune");
      
      // count
      //if(!doneCounting) {
        //println("count");
        //p = 
      //} else {  
      // tune
      //println("tune");
      int calculated = pentatonics[(int)map(counted,0,25, 0, pentatonics.length-1)];
      float[] pitches = {calculated, calculated+3, calculated+3+4, calculated+4+3+3}; // c major 7th
      
      if(!sameTune) {
        ellipse(position.x, position.y, radius-5, radius-5);
        sqr.play(midiToFreq(calculated), 1);
        env.play(sqr, attackTime, sustainTime, sustainLevel, releaseTime);
        //sound.playNote(calculated+(int)(random(0, 4)), 100, 0);
        //sound.playChord(pitches, 100, 10);
      } else {
        //saw.play(midiToFreq(calculated), 0.3);
        //env2.play(saw, attackTime2, sustainTime2, sustainLevel2, releaseTime2);
      }
      // count and then tune it out
      //previousMillis = millis();
      reachDestination = true;
      //}
    }
  }
  
}
