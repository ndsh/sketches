class Textframe {
  PVector pos;
  String[] texts;
  
  PGraphics[] pgs;
  
  Ani movementLeftAni;
  Ani movementRightAni;
  int animationSide;
  
  float left = 0;
  float right = 0;
  int leftGoal = 0;
  int rightGoal = 0;
  
  float nextLeft = 0;
  float nextRight = 0;
  int nextLeftGoal = 0;
  int nextRightGoal = 0;
  
  long timestamp = 0;
  long interval = 3000;
  
  boolean ready = false;
  int currentText = 0;
  int nextText = 0;
  int frameHeight = 0;
  
  float aniTime = 1.5;
  boolean startNext = false;
  
  boolean cycle = false;
  
  Textframe(String[] s, int _frameHeight) {
    //movementRightAni = new Ani(this, 5, "right", 1.5, Ani.EXPO_IN_OUT, "onEnd:reachedRight");
    texts = s;
    frameHeight = _frameHeight;
    pgs = new PGraphics[texts.length];
    pos = new PVector(0, height/2);
    initCanvases();
    
    // randomize start
    currentText = (int)random(texts.length-1);
    nextText++;
    nextText %= texts.length;
    
    aniTime = random(2,5);
    
    left = width;
    right = width;
    nextLeft = 0;
    nextRight = 0;
  }
  
  void display() {
    PGraphics pg = pgs[currentText];
    PGraphics pg2 = pgs[nextText];
    //image(pg, width/2, height/2);
    push();
    noStroke();
    translate(pos.x, pos.y);
    beginShape();
    texture(pg);
    vertex(left, 0, 0, 0);
    vertex(right, 0, pg.width, 0);
    vertex(right, pg.height*frameHeight, pg.width, pg.height);
    vertex(left, pg.height*frameHeight, 0, pg.height);
    endShape();
    pop();
    

    push();
    translate(pos.x, pos.y);
    noStroke();
    beginShape();
    texture(pg2);

    vertex(nextLeft, 0, 0, 0);
    vertex(nextRight, 0, pg2.width, 0);
    vertex(nextRight, pg2.height*frameHeight, pg2.width, pg2.height);
    vertex(nextLeft, pg2.height*frameHeight, 0, pg2.height);
    endShape();
    pop();
    
  }
  
  void update() {
      if(animationSide == 0) {       
        Ani.to(this, aniTime, "left", leftGoal, Ani.EXPO_OUT);
        Ani.to(this, aniTime, "nextRight", nextRightGoal, Ani.EXPO_OUT);
        if((int)left <= 0) {
          animationSide = 1;
          reset2nd();
          nextText = currentText + 1;
          nextText %= texts.length;
          float w = pgs[nextText].width;
          aniTime = w/200;
          //println(aniTime);
        }
      } else if(animationSide == 1) {
        Ani.to(this, aniTime, "right", rightGoal, Ani.EXPO_OUT);
        Ani.to(this, aniTime, "nextLeft", nextLeftGoal, Ani.EXPO_OUT);
       
        if((int)right <= 0) {
          reset1st();
          animationSide = 0;
          currentText+=2;
          currentText %= texts.length;
          float w = pgs[currentText].width;
          aniTime = w/200;
          //println(aniTime);
        }
      }
  }
  
  void reset1st() {
    left = width;
    right = width;
    leftGoal = width;
    rightGoal = width;
    Ani.to(this, 0, "left", leftGoal);
    Ani.to(this, 0, "right", rightGoal);
    
    leftGoal = 0;
    rightGoal = 0;
  }
  
  void reset2nd() {
    nextLeft = width;
    nextRight = width;
    nextLeftGoal = width;
    nextRightGoal = width;
    
    Ani.to(this, 0, "nextLeft", nextLeftGoal);
    Ani.to(this, 0, "nextRight", nextRightGoal);

    nextLeftGoal = 0;
    nextRightGoal = 0;
  }
  
  void initCanvases() {
    for(int i = 0; i<texts.length; i++) {
      pgs[i] = createGraphics((int)textWidth(texts[i])+4, (int)ca+4);
      pgs[i].beginDraw();
      pgs[i].textFont(font);
      pgs[i].textAlign(CENTER, CENTER);
      //pgs[i].background(0);
      pgs[i].fill(255);
      float cw = pgs[i].textWidth(texts[i]);
      
      
      pgs[i].push();
      pgs[i].translate(pgs[i].width/2, pgs[i].height/2);
      for(int x = -2; x < 3; x++) {
          pgs[i].text(texts[i], x,0);
          pgs[i].text(texts[i], 0,x);
      }
      pgs[i].pop();
      pgs[i].fill(0);
      pgs[i].text(texts[i], pgs[i].width/2, pgs[i].height/2);
      
      pgs[i].endDraw();
    }
  }
  
  void setPos(float x, float y) {
    pos = new PVector(x, y);
  }
  
  void setLeft(float f) {
    left = f;
  }
  
  void setRight(float f) {
    right = f;
  }
  
  float getLeft() {
    return left;
  }
  
  float getRight() {
    return right;
  }
  
  void reachedLeft() {
    println("done left");
    //movementRightAni.start();
  }
  
  void reachedRight() {
    println("done right");
    //movementLeftAni.start();
    left = width;
    right = width;
    
  }
  
  boolean isReady() {
    return ready;
  }
  
  void go() {
    ready = true;
  }
  
  void pause() {
    ready = false;
  }
  
  void setFrameheight(int i) {
    frameHeight = i;
  }
  
}
