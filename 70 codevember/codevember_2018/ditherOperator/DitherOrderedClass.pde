class DitherOrdered {
  PGraphics pg;
  PImage src;
  PGraphics res;
  
  
  
  // Bayer matrix
  int[][] matrix = {   
    {      1, 9, 3, 11    }    , 
    {      13, 5, 15, 7    }    , 
    {      4, 12, 2, 10    }    , 
    {      16, 8, 14, 6    }  };
  
  float mratio = 1.0 / 17;
  float mfactor = 255.0 / 5;
  
  int stepRatio;

  public DitherOrdered(int _step) {
    stepRatio = _step;
  }
  
  void setSrc(PImage p) {
    src = p;
    res = createGraphics(p.width, p.height);
  }
  
  PGraphics getImage() {
    return res;
  }
  
  void update() {
    // Define step
  int s = stepRatio;
    res.beginDraw();
    // Scan image
    for (int x = 0; x < src.width; x+=s) {
      for (int y = 0; y < src.height; y+=s) {
        // Calculate pixel
        color oldpixel = src.get(x, y);
        color value = color( brightness(oldpixel) + (mratio*matrix[x%4][y%4] * mfactor));
        color newpixel = findClosestColor(value);
        
        src.set(x, y, newpixel);
  
  
        // Draw
        res.stroke(newpixel);   
        res.point(x, y);
      }
    }
    res.endDraw();
  }
  
  // Threshold function
  color findClosestColor(color in) {  
    color out;
    if (brightness(in) < 128) {
      out = color(0);
    }
    else {
      out = color(255);
    }
    return out;
  }
}
