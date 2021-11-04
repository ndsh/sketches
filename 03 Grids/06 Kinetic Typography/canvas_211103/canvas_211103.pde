PGraphics pg;
PGraphics pg2;
PGraphics pg3;
PGraphics pg4;
PFont font1;
PFont font2;
Dither d;

PImage p;

float speed = 0;
int phasing = 00;
boolean waveDirection = true;

int sx, sy, sw, sh, dx, dy, dw, dh;

int counter = 0;
boolean showGrid = true;
boolean showCursor = true;
boolean doubleText = false;
boolean ditherThis = true;
int mode = 3; // targetBox, kinetic, drawing with dither

int[] targetStart = {28, 1};
int[] targetEnd = {8, 14};

int waveMode = 1;

float wave = 0;

int tilesX = 65;
int tilesY = 17;
long timestamp = 0;
long interval = 500;

String text1 = "L";
String text2 = "TECHNOLOGIES";

int tileW = 0;
int tileH = 0;

int ditherMode = 0;

void setup() {
  size(1560, 408, P2D);
  frameRate(60);
  surface.setLocation(0, 0);
  pg = createGraphics(1560, 408, P2D);
  font1 = createFont("ASSETS/Standard0757.ttf", 192*2);
  font2 = createFont("ASSETS/Standard0757.ttf", 192*1);
  
  p = loadImage("medusa.jpg");
  
  pg.beginDraw();
  pg.textAlign(CENTER, BASELINE);
  pg.endDraw();
  
  pg2 = createGraphics(1560, 408, P2D);
  pg2.beginDraw();
  pg2.textAlign(CENTER,CENTER);
  pg2.noStroke();
  pg2.background(0, 255, 255);
  pg2.ellipse(pg.width/2, pg.height/2, 20, 20);
  pg2.endDraw();
  
  pg3 = createGraphics(1560, 408, P2D);
  pg3.beginDraw();
  pg3.endDraw();
  
  pg4 = createGraphics(1560, 408, P2D);
  pg4.beginDraw();
  pg4.endDraw();
  
  d = new Dither();
  d.setCanvas(1560, 408);
  d.setMode(0);
  
  tileW = int(width/tilesX);
  tileH = int(height/tilesY);
}

void draw() {
  background(0);
  
  /* interessanter effekt
  if(millis() - timestamp > interval) {
    timestamp = millis();
    tilesX++;
    if(tilesX >= 65) tilesX = 1;
  }
  */
  
  

  
  
  pg.beginDraw();
  //if(mode != 3) pg.background(0);
  //pg.fill(0, 120);
  //pg.rect(0,0,pg.width,pg.height);
  pg.fill(255);
  pg.pushMatrix();
  
  if(!doubleText) {
    pg.translate(width/2 + 12, height - (tileH*2) );
    pg.textFont(font1);
    pg.textSize(192*2);
    pg.text(text1, 0, 0);
  } else {
    pg.translate(width/2 + 12, height - (tileH*1) );
    pg.textFont(font2);
    pg.textSize(192*1);
    pg.text(text2, 0, 0);
    pg.text(text1, 0, -(tileH*8));
  }
  pg.popMatrix();
  pg.endDraw();

  
  if(mode == 0) {
    //tilesX = (int)map(mouseX, 0, width, 1, 66);
    //tilesY = (int)map(mouseY, 0, height, 1, 18);
    //tileW = int(width/tilesX);
    //tileH = int(height/tilesY);
    
    pg2.beginDraw();
    pg2.noStroke();
    pg2.background(0);
    //pg2.ellipse(pg.width/2, pg.height/2, tileW-4, tileH-4);
    pg2.textFont(font1);
    pg2.textSize(int(map(mouseX*mouseY, 0, width*height, 192, 7)));
    
    pg2.translate(pg2.width/2-4, pg2.height/2+4);
    pg2.rotate(radians(map(sin(frameCount*0.02), -1, 1, 0, 360)));
    pg2.text(text1, 0, 0);
    pg2.endDraw();
  
    float r = map(sin(frameCount*0.05), -1, 1, 0.0, 0.1);
    sx = width/2-tileW/2;
    sy = height/2-tileH/2;
    sw = tileW;
    sh = tileH;
    dx = width/2;
    dy = height/2;
    dw = tileW;
    dh = tileH;
    
  
    for(int y = 0; y<=(height/tileH)/2; y++) {
      for(int x = 0; x<=(width/tileW)/2; x++) {
        wave = sin( (frameCount + ( x*y ) ) * speed) * phasing;
        // x+ y+
        //for(int i = 0; i<=tilesY/2; i++) {
          int i = 0;
          copy(pg2, sx + int( (tileW*x) *r + wave), sy + int( (tileH * (y+i) ) *r ), sw, sh, dx + int(tileW*x), dy + int(tileH*(y+i)), dw, dh);
          // x+ y-
          copy(pg2, sx + int( (tileW*x) *r + wave), sy - int( (tileH * (y+i) ) *r ), sw, sh, dx + int(tileW*x), dy - int(tileH*(y+i)), dw, dh);
          // x- y+
          copy(pg2, sx - int( (tileW*x) *r + wave), sy + int( (tileH * (y+i) ) *r ), sw, sh, dx - int(tileW*x), dy + int(tileH*(y+i)), dw, dh);
          // x- y-
          copy(pg2, sx - int( (tileW*x) *r + wave), sy - int( (tileH * (y+i) ) *r ), sw, sh, dx - int(tileW*x), dy - int(tileH*(y+i)), dw, dh);
       //   }  
        
        
        push();
        noFill();
        stroke(255, 255, 0);
        //noStroke();
        rect(width/2, height/2, tileW, tileH);
        pop();
        //image(pg2, 0, 0);
        //copy(pg2, sx, sy, sw, sh, dx, dy, dw, dh);
      }
    }
  } else if(mode == 1) {
    for (int y = 0; y < tilesY; y++) {
      for (int x = 0; x < tilesX; x++) {
  
        // WAVE
        if(waveMode == 1) wave = sin( (frameCount + ( x*y ) ) * speed) * phasing;
        else if(waveMode == 2) wave = map(tan( radians(frameCount*speed + (x+y)) ), -1, 1, 0, phasing);
        else if(waveMode == 3) wave = map(tan( radians(frameCount*speed + (x+y)) ), -1, 1, phasing, -phasing);
        else if(waveMode == 4) wave = map(tan( radians(frameCount*speed + (sqrt(x)+y)) ), -1, 1, phasing, -phasing);
        else if(waveMode == 5) wave = 0;
        //int wave = (int)map(sin(radians(frameCount * 3 + x * 0.3 + y * 0.3)), -1, 1, 0, 1);
        //float wave3 = (int)map(sin(radians(frameCount+ (x*y))),-1,1,3,1.6);
        //float wave4 = map(sin(radians(frameCount)), -1, 1, 1.3, 2.4);
        //float wave5 = map(tan(radians(frameCount + (x*y)) ), -1, 1, -phasing, phasing);
  
        
        if(waveDirection) {
          sx = int(x*tileW + wave);
          sy = y*tileH;
        } else {
          sx = x*tileW;
          sy = int(y*tileH  + wave);
        }
        sw = tileW;
        sh = tileH;
        
        // diagonal movement obviously
          //sx = int(x*tileW + wave);
          //sy = int(y*tileH + wave);
  
  
        // DESTINATION
        dx = x*tileW;
        dy = y*tileH;
        dw = tileW;
        dh = tileH;
        
        copy(pg, sx, sy, sw, sh, dx, dy, dw, dh);
   
      }
    }
  } else if(mode == 2) {
    pg3.beginDraw();
    if(ditherThis) pg3.fill(0, 10);
    else pg3.background(0);
    pg3.rect(0, 0, pg3.width, pg3.height);
    pg3.endDraw();
    
    if(ditherThis) {
      d.feed(pg3.get());
      image(d.dither(), 0, 0);
    } else image(pg3, 0, 0);
  } else if(mode == 3) {
    
    
    
    pg4.beginDraw();
    
    for (int y = 0; y < tilesY; y++) {
      for (int x = 0; x < tilesX; x++) {
        if(waveMode == 1) wave = sin( (frameCount + ( x*y ) ) * speed) * phasing;
        else if(waveMode == 2) wave = map(tan( radians(frameCount*speed + (x+y)) ), -1, 1, 0, phasing);
        else if(waveMode == 3) wave = map(tan( radians(frameCount*speed + (x+y)) ), -1, 1, phasing, -phasing);
        else if(waveMode == 4) wave = map(tan( radians(frameCount*speed + (sqrt(x)+y)) ), -1, 1, phasing, -phasing);
        else if(waveMode == 5) wave = 0;
        //int wave = (int)map(sin(radians(frameCount * 3 + x * 0.3 + y * 0.3)), -1, 1, 0, 1);
        //float wave3 = (int)map(sin(radians(frameCount+ (x*y))),-1,1,3,1.6);
        //float wave4 = map(sin(radians(frameCount)), -1, 1, 1.3, 2.4);
        //float wave5 = map(tan(radians(frameCount + (x*y)) ), -1, 1, -phasing, phasing);
  
        if(waveDirection) {
          sx = int(x*tileW + wave);
          sy = y*tileH;
        } else {
          sx = x*tileW;
          sy = int(y*tileH  + wave);
        }
        sw = tileW;
        sh = tileH;
        
        // diagonal movement obviously
        //sx = int(x*tileW + wave);
        //sy = int(y*tileH + wave);
  
  
        // DESTINATION
        dx = x*tileW;
        dy = y*tileH;
        dw = tileW;
        dh = tileH;
        
        pg4.copy(pg, sx, sy, sw, sh, dx, dy, dw, dh);
        
      }
    }
    pg4.endDraw();
    
    pg4.beginDraw();
    pg4.fill(0, 20);
    pg4.rect(0, 0, pg4.width, pg4.height);
    pg4.endDraw();
    
    if(ditherThis) {
      d.feed(pg4.get());
      image(d.dither(), 0, 0);
    } else image(pg4, 0, 0);
    
    
  }
  
  if(showGrid) {
    push();
    stroke(255);
      for (int x = 0; x < tilesX; x++) {
        line(x *tileW, 0, x*tileW, height);
      }
      for (int y = 0; y < tilesX; y++) {
        line(0, y *tileW, width, y*tileW);
      }
    pop();
    text(mode, 10, 10);
  }
  
}

void mouseDragged() {
  if(mode == 2) {
    pg3.beginDraw();
    //pg3.fill(0, 10);
    //pg3.rect(0, 0, pg3.width, pg3.height);
    pg3.fill(255);
    pg3.noStroke();
    pg3.rect(mouseX/tileW * tileW, mouseY/tileH * tileH, 24, 24);
    pg3.endDraw();
  } else {
    if(mouseButton == 37) {
      speed = map(mouseX, 0, width, 0.0001, 1.0);
      println("phase shifting speed = " + speed);
    } else if(mouseButton == 39) {
      phasing = (int)map(mouseX, 0, width, 0, 600);
      println("phasing= " + phasing);
    }
  }
}
void keyPressed() {
  if (key == CODED) {
    if(keyCode == LEFT) {
      if(mode == 2 || mode == 3) {
        ditherMode--;
        if(ditherMode == 0) ditherMode = 3;
        d.setMode(ditherMode);
      }
    } else if(keyCode == RIGHT) {
      if(mode == 2 || mode == 3) {
        ditherMode++;
        ditherMode %= 4;
        d.setMode(ditherMode);
      }
    } else if(keyCode == UP) {
      phasing += 10;
    } else if(keyCode == DOWN) {
      phasing -= 10;
    }
  } else {
    if (key == 'w' || key == 'W' ) {
      waveDirection = !waveDirection;
      println("waveDirection= " + waveDirection);
    } else if (key == 'g' || key == 'G' ) {
      showGrid = !showGrid;
      println("showGrid= " + showGrid);
    } else if(key == 'c' || key == 'C') {
      showCursor = !showCursor;
      if(showCursor) cursor();
      else noCursor();
    } else if(key == 't' || key == 'T') {
      doubleText = !doubleText;
      println("doubleText=" + doubleText);
    } else if(key == 'm' || key == 'M') {
      mode++;
      mode %= 4;
      println("mode=" + mode);
    } else if(key == 'd' || key == 'D') {
      ditherThis = !ditherThis;
      println("ditherThis=" + ditherThis);
    } else if(key == '1') {
      waveMode = 1;
    } else if(key == '2') {
      waveMode = 2;
    } else if(key == '3') {
      waveMode = 3;
    } else if(key == '4') {
      waveMode = 4;
    } else if(key == '5') {
      waveMode = 5;
    }
    
  }
}
