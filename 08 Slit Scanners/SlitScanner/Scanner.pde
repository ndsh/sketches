class Scanner {
  int mPos = 0;
  int mDirection; // 0 = left-right, 1 = right-left, 2 = top-down, 3 = down-top
  color mPixels[];
  Scanner(int direction) {
    mDirection = direction;
    //if(mDirection == 0 || mDirection == 1) mPixels = new color[height];
    //else mPixels = new color[width];
    mPixels = new color[width*height];
  }
  
  void changeDirection(int tDirection) {
    mDirection = tDirection;
  }
  
  void draw() {
    loadPixels();
    if(mDirection == 0) {
      for (int i = 0; i < height; i++) {
        pixels[i*width+mPos] = mPixels[i];
      }
    } else if(mDirection == 1) {
      for (int i = 0; i < height; i++) {
        pixels[i*width+mPos] = mPixels[i];
      }
    } else if(mDirection == 2) {
      for (int i = 0; i < width; i++) {
        pixels[mPos*width+i] = mPixels[i];
        
      }
    } else if(mDirection == 3) {
      for (int i = 0; i < width; i++) {
        pixels[mPos*width+i] = mPixels[i];
        
      }
    }
    updatePixels();
  }
  
  void scan() {
    pg.beginDraw();
    pg.loadPixels();
    if(mDirection == 0 || mDirection == 1) {
      for (int i = 0; i < width; i++) {
          //mPixels[i] = get(width/4, i);
          mPixels[i] = pg.pixels[i*width+(width/2)];
      }
    } else {
        for (int i = 0; i < height; i++) {
          //mPixels[i] = get(width/4, i);
          mPixels[i] = pg.pixels[(height/2)*width+i];
      }
    }
    pg.endDraw();
    if(mDirection == 0) {
      mPos++;
      mPos%=width;
    } else if(mDirection == 1) {
      mPos--;
      if(mPos < 0) mPos=width-1;
    } else if(mDirection == 2) {
      
      mPos++;
      mPos%=height;
    } else if(mDirection == 3) {
      mPos--;
      if(mPos < 0) mPos=height-1;
    }
  }
}