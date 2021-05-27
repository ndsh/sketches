class Textframe {
  PVector pos;
  PGraphics pg;
  String text;
  float[] rotations; // in radians
  float[] positions; // x pos
  float[] widths; // pixel width of each character

  float origin = 0;

  long[] timestamps = new long[2];
  long[] intervals = new long[2];

  float spacing = 0.0; // 0 -> 1 -- 0 -> width
  float align = 0.0; // 0, 0.5, 1 = left, center, right

  boolean update = false;
  int maxSpacing = 0;

  int alignMode = 0;
  
  int aniMoveIndex = 0;
  int aniSpacingIndex = 0;
  int aniMoveMaxFrames;
  int aniSpacingMaxFrames;
  int[] aniMoveTiming;
  int[] aniSpacingTiming;
  float[] aniMovePattern;
  float[] aniSpacingPattern;
  
  float targetAlign = 0;
  float targetSpacing = 0;

  Textframe(String s, float y, int maxMoveFrames, int maxSpacingFrames, int[] moveT, int[] spacingT, float[] moveP, float[] moveS) {
    
    pos = new PVector(0, y);
    pg = createGraphics(width, (int)ca);
    text = s.toUpperCase();
    
    aniMoveMaxFrames = maxMoveFrames;
    aniSpacingMaxFrames = maxSpacingFrames;
    aniMoveTiming = moveT;
    aniSpacingTiming = spacingT;
    aniMovePattern = moveP;
    aniSpacingPattern = moveS;    

    initArrays();
    calcMaxSpacing();
    initGraphics();
    
    
    intervals[0] = aniMoveTiming[aniMoveIndex];
    intervals[1] = aniSpacingTiming[aniSpacingIndex];
    
  }

  void initArrays() {
    rotations = new float[text.length()];
    positions = new float[text.length()];
    widths = new float[text.length()];

    for (int i = 0; i<text.length(); i++) {
      positions[i] = 0;
      rotations[i] = 0;
      widths[i] = textWidth(text.charAt(i));
      //println(widths[i]);
    }
  }

  void display() {
    push();
    translate(0, pos.y);
    image(pg, 0, 0);
    pop();
  }
  
  void getDisplay() {
    push();
    translate(0, pos.y);
    image(pg, 0, 0);
    pop();
  }


  void update() {
    // only for debug
    //spacing = map(mouseX, 0, width, 0, 1);
    //align = map(mouseY, 0, height, 0, 1);
    
    if(millis() - timestamps[0] > (intervals[0]+200)) {
      timestamps[0] = millis();
      Ani.to(this, (aniMoveTiming[aniMoveIndex]/1000f), "align", aniMovePattern[aniMoveIndex], Ani.EXPO_OUT);
      aniMoveIndex++;
      aniMoveIndex %= aniMoveMaxFrames;
      intervals[0] = aniMoveTiming[aniMoveIndex];
    }
    
    if(millis() - timestamps[1] > intervals[1]+200) {
      timestamps[1] = millis();
      
      Ani.to(this, (aniSpacingTiming[aniSpacingIndex]/1000f), "spacing", aniSpacingPattern[aniSpacingIndex], Ani.EXPO_OUT);
      aniSpacingIndex++;
      aniSpacingIndex %= aniSpacingMaxFrames;
      intervals[1] = aniSpacingTiming[aniSpacingIndex];
    }
    updateGraphics();
  }

  void initGraphics() {   
    pg.beginDraw();
    pg.background(0);
    pg.fill(white);
    pg.textFont(font);
    pg.textAlign(LEFT);
    pg.endDraw();
  }

  void updateGraphics() {
    // rearrange all letters and positions
    int cursor = 0;
    float m = map(spacing, 0, 1, 0, maxSpacing );
    //align = 0.5;
    float a = map(align, 0, 1, 0, width-textWidth(text));
    if(round(align) >= 1) alignMode = 1;
    else if(round(align) <= 0) alignMode = 0;
    pg.beginDraw();
    pg.background(0);
    pg.fill(white);
    
    pg.translate(a, ca);
    //println(a);
    // für links
    
    if(alignMode == 0) {
     for(int i = 0; i<text.length(); i++) {
         pg.text(text.charAt(i), cursor + ((m)*i), 0);
         cursor += widths[i];
       }
    } else if(alignMode == 1) { 
     
     // für rechts
    //pg.translate(0, 60);
      //pg.fill(0, 125, 255, 60);
      cursor = 0;
      for (int i = text.length()-1; i>=0; i--) {
        int flip = (int)map(i, 0, text.length()-1, text.length()-1, 0); 
        pg.text(text.charAt(flip), cursor - ((m)*i), 0);
        cursor += widths[flip];
      }
    }
    // für mitte
    // BAUSTELLE
    
    //int median = round(text.length()/2.0)-1; // -1 für unser array

    //ungerade zahlen
    /*
    boolean debug = true;
    if (text.length()%2 == 1 && debug) {
      int centeredCursor = 0;
      cursor = 0;
      for(int i = 0; i<median; i++) {
        centeredCursor += widths[i];
      }
      
      pg.fill(255, 255, 0);
      pg.text(text.charAt(median), centeredCursor, 0);
      pg.fill(255, 120);
      // linke seite, von der mitte nach links ausweiten
      cursor = 0;
      for (int i = median; i>=0; i--) {
        int flip = (int)map(i, 0, median, median, 0);
        pg.text(text.charAt(flip), cursor - ((m)*i), 0);
        cursor += widths[flip];
      }

      // rechte seite, vice versa
      // adjust the cursor so it has the right width
      m = map(spacing, 0, 1.5, 0, maxSpacing );
      cursor = centeredCursor + (int)widths[median+1];
      for (int i = median+1; i<text.length(); i++) {
        pg.text(text.charAt(i), cursor + ((m)*i), 0);
        cursor += widths[i];
      }
    }

    */
    


    pg.endDraw();
  }

  void calcMaxSpacing() {
    int cursor = 0;
    boolean found = false;
    for (int j = 0; j<width; j++) {
      cursor = 0;
      int result = 0;
      for (int i = 0; i<text.length(); i++) {
        if (i == text.length()-1) {
          result = cursor + ((j)*i);
          int intermediate = (result+(int)widths[text.length()-1]);

          if (intermediate > width) found = true;
          if (found) break;
          maxSpacing = j;
        }
        if (found) break;
        cursor += widths[i]; // + (m-widths[i]);
      }
      if (found) break;
    }
    println("maxSpacing=" + maxSpacing);
  } 

  void setY(float y) {
    pos.y = y;
  }

  void setOrigin(float o) {
    origin = o;
  }
}
