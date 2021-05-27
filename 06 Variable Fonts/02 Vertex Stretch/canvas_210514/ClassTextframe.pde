class Textframe {
  PVector pos;
  String text;
  float left = 0;
  float right = 0;
  PGraphics pg;
  
  Ani movementLeftAni;
  Ani movementRightAni;
  int animationSide;
  int leftGoal = 0;
  int rightGoal = 0;
  
  long timestamp = 0;
  long interval = 3000;
  
  boolean ready = false;
  
  Textframe(String s) {
    //movementRightAni = new Ani(this, 5, "right", 1.5, Ani.EXPO_IN_OUT, "onEnd:reachedRight");
    pos = new PVector(0, height/2);
    pg = createGraphics((int)textWidth(s)+4, (int)ca+4);
    pg.beginDraw();
    pg.textFont(font);
    pg.textAlign(CENTER, CENTER);
    //pg.background(0, 0, 255);
    pg.fill(255);
    float cw = pg.textWidth(displayText);
    println(cw);
    
    pg.push();
    pg.translate(pg.width/2, pg.height/2);
    for(int x = -2; x < 3; x++) {
        pg.text(displayText, x,0);
        pg.text(displayText, 0,x);
    }
    pg.pop();
    pg.fill(0);
    pg.text(displayText, pg.width/2, pg.height/2);
    
    pg.endDraw();
    left = width;
    right = width;
  }
  
  void display() {
    push();
    translate(pos.x, pos.y);
    beginShape();
    texture(pg);
    //vertex(mouseX, mouseY, map(mouseX, 0, 600, 0, mouseX), map(mouseY, 0, 600, 0, mouseY));
    vertex(left, 0, 0, 0);
    vertex(right, 0, pg.width, 0);
    vertex(right, pg.height, pg.width, pg.height);
    vertex(left, pg.height, 0, pg.height);
    //vertex(mouseX, mouseY+600, map(mouseX, 0, 600, 0, mouseX), map(mouseY, 0, 600, 0, mouseY)+600);
    endShape();
    pop();
    //image(pg, width/2, height/2);
  }
  
  void update() {
    //println(left);
    //if(ready) {
      if(animationSide == 0) {
        leftGoal = 0;
        Ani.to(this, 1.5, "left", leftGoal, Ani.EXPO_OUT);
        if((int)left <= 0) {
          animationSide = 1;
        }
      } else if(animationSide == 1) {
        rightGoal = 0;
        Ani.to(this, 1.5, "right", rightGoal, Ani.EXPO_OUT);
        if((int)right <= 0) {
          animationSide = 2;
          
        }
      } else if(animationSide == 2) {
        if(millis() - timestamp > interval) {
          timestamp = millis();
          leftGoal = width;
          rightGoal = width;
          left = width;
          right = width;
          animationSide = 0;
          Ani.to(this, 0, "left", leftGoal);
          Ani.to(this, 0, "right", rightGoal);
          ready = false;
        }
      }
      //println(animationSide);
      
   // }
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
  
}
