// this sketch shows tiled cells 64x64 or 32x32
// and layers time over it. every full minute the will be shown and
// then slowly fades away

// reference https://nicolassassoon.com/PATTERNS.html

import com.hamoid.*;

VideoExport videoExport;

Tiler tile;
Timer timer;
int lastMinute = 0;

void setup() {
  size(600, 600);
  
  videoExport = new VideoExport(this);
  videoExport.startMovie();
  
  tile = new Tiler();
  timer = new Timer();
  lastMinute = minute();
}

void draw() {
  tile.update();
  tile.display();
  timer.update();
  
  image(tile.getDisplay(), 0, 0);
  
  
  
  image(timer.getDisplay(), 0, 0);
  if(lastMinute != minute()) {
    println("switch");
    lastMinute = minute();
    tile.setParameters();
  }
  
  videoExport.saveFrame();
  
}

void keyPressed() {
  if (key == 's') {
    println("switch");
    lastMinute = minute();
    tile.setParameters();
  } else if (key == 'q') {
    videoExport.endMovie();
    exit();
  }
}
