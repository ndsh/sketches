class Textframe {
  String text;
  float left = 0;
  float right = 0;
  PGraphics pg;
  
  Textframe(String s) {
    
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
}
