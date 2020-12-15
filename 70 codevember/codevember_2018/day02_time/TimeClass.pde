class Timer {
  PGraphics pg;
  PFont font = loadFont("AkkuratStd-Bold-200.vlw");
  int lastMinute = 0;
  
  boolean activated = false;
  
  public Timer() {
    pg = createGraphics(width, height);
    pg.beginDraw();
    pg.textFont(font, 200);
    pg.textAlign(CENTER, CENTER);
    pg.fill(255);
    //pg.background(0);
    pg.endDraw();
  }
  
  void update() {
    
    String s = second()+"";  // Values from 0 - 59
    String m = minute()+"";  // Values from 0 - 59
    String h = hour()+"";    // Values from 0 - 23
    
    if(h.length() == 1) h = "0"+h;
    if(m.length() == 1) m = "0"+m;
    if(s.length() == 1) s = "0"+s;
  
    pg.beginDraw();
    pg.pushMatrix();
    pg.clear();
    pg.fill(0);
    //pg.translate(pg.width/2, pg.height/2);
    //pg.text(h+":"+m+":"+s, 0, 0);
    pg.text(h, width/2, (150*1)-50);
    pg.text(m, width/2, (150*2));
    pg.text(s, width/2, (150*3)+50);
    pg.popMatrix();
    if(lastMinute != minute()) {
      lastMinute = minute();
      pg.pushStyle();
      pg.fill(0,20);
      pg.rect(0, 0, pg.width, pg.height);
      pg.popStyle();
    }
    
    
    pg.endDraw();
  }
  
  void display() {
    image(pg, 0, 0);
  }
  
  PGraphics getDisplay() {
    return pg;
  }
  
  
  
  
}
