PGraphics pg;
PGraphics pg2;

void setup() {
  size(400, 400, P2D);
  surface.setLocation(0, 0);
  
  pg = createGraphics(400, 400, P2D);
  pg.beginDraw();
  pg.noStroke();
  pg.background(0, 0, 255);
  pg.ellipse(pg.width/2, pg.height/2, 40, 40);
  pg.endDraw();
  
  pg2 = createGraphics(400, 400, P2D);
  pg2.beginDraw();
  pg2.noStroke();
  pg2.background(0, 255, 255);
  pg2.ellipse(pg.width/2, pg.height/2, 40, 40);
  pg2.endDraw();
  
}

void draw() {
  background(0);
  /*
  int sx = mouseX -25; //width/2 - 25;
  int sy = mouseY -25; //height/2 - 25;
  */
  int sx = width/2 - 25;
  int sy = height/2 - 25;
  int sw = 50;
  int sh = 50;
  int dx = width/2 - 25;
  int dy = height/2 - 25;
  int dw = 50;
  int dh = 50;
  
  int tileW = 50;
  int tileH = 50;
  
  
  /*for(int i = 0; i<=(width/tileW)/2; i++) {
    copy(pg, sx-int((tileW*i)*0.1), sy, sw, sh, dx-(tileW*i), dy, dw, dh);
  }*/
  float r = 0;
  for(int i = 0; i<=(width/tileW)/2; i++) {
    for(int j = 0; j<=(height/tileH)/2; j++) {
      
      // + - + -
      copy(pg, sx + int((tileW*i)*r), sy - int((tileH*(i))*r), sw, sh, dx + int(tileW*i), dy - int(tileH*(i)), dw, dh);
      copy(pg, sx + int((tileW*i)*r), sy - int((tileH*(i+1))*r), sw, sh, dx + int(tileW*i), dy - int(tileH*(i+1)), dw, dh);
      copy(pg, sx + int((tileW*i)*r), sy - int((tileH*(i+2))*r), sw, sh, dx + int(tileW*i), dy - int(tileH*(i+2)), dw, dh);
      copy(pg, sx + int((tileW*i)*r), sy - int((tileH*(i+3))*r), sw, sh, dx + int(tileW*i), dy - int(tileH*(i+3)), dw, dh);
      copy(pg, sx + int((tileW*i)*r), sy - int((tileH*(i+4))*r), sw, sh, dx + int(tileW*i), dy - int(tileH*(i+4)), dw, dh);
      
      copy(pg, sx + int((tileW*i)*r), sy + int((tileH*(i))*r), sw, sh, dx + int(tileW*i), dy + int(tileH*(i)), dw, dh);
      copy(pg, sx + int((tileW*i)*r), sy + int((tileH*(i+1))*r), sw, sh, dx + int(tileW*i), dy + int(tileH*(i+1)), dw, dh);
      copy(pg, sx + int((tileW*i)*r), sy + int((tileH*(i+2))*r), sw, sh, dx + int(tileW*i), dy + int(tileH*(i+2)), dw, dh);
      copy(pg, sx + int((tileW*i)*r), sy + int((tileH*(i+3))*r), sw, sh, dx + int(tileW*i), dy + int(tileH*(i+3)), dw, dh);
      copy(pg, sx + int((tileW*i)*r), sy + int((tileH*(i+4))*r), sw, sh, dx + int(tileW*i), dy + int(tileH*(i+4)), dw, dh);
      
      copy(pg, sx - int((tileW*i)*r), sy + int((tileH*(i))*r), sw, sh, dx - int(tileW*i), dy + int(tileH*(i)), dw, dh);
      copy(pg, sx - int((tileW*i)*r), sy + int((tileH*(i+1))*r), sw, sh, dx - int(tileW*i), dy + int(tileH*(i+1)), dw, dh);
      copy(pg, sx - int((tileW*i)*r), sy + int((tileH*(i+2))*r), sw, sh, dx - int(tileW*i), dy + int(tileH*(i+2)), dw, dh);
      copy(pg, sx - int((tileW*i)*r), sy + int((tileH*(i+3))*r), sw, sh, dx - int(tileW*i), dy + int(tileH*(i+3)), dw, dh);
      copy(pg, sx - int((tileW*i)*r), sy + int((tileH*(i+4))*r), sw, sh, dx - int(tileW*i), dy + int(tileH*(i+4)), dw, dh);
      
      copy(pg, sx - int((tileW*i)*r), sy - int((tileH*(i))*r), sw, sh, dx - int(tileW*i), dy - int(tileH*(i)), dw, dh);
      copy(pg, sx - int((tileW*i)*r), sy - int((tileH*(i+1))*r), sw, sh, dx - int(tileW*i), dy - int(tileH*(i+1)), dw, dh);
      copy(pg, sx - int((tileW*i)*r), sy - int((tileH*(i+2))*r), sw, sh, dx - int(tileW*i), dy - int(tileH*(i+2)), dw, dh);
      copy(pg, sx - int((tileW*i)*r), sy - int((tileH*(i+3))*r), sw, sh, dx - int(tileW*i), dy - int(tileH*(i+3)), dw, dh);
      copy(pg, sx - int((tileW*i)*r), sy - int((tileH*(i+4))*r), sw, sh, dx - int(tileW*i), dy - int(tileH*(i+4)), dw, dh);
      
      //
      
      copy(pg, sx + int((tileW*i)*r), sy - int((tileH*(i))*r), sw, sh, dx + int(tileW*i), dy - int(tileH*(i)), dw, dh);
      copy(pg, sx + int((tileW*i)*r), sy - int((tileH*(i-1))*r), sw, sh, dx + int(tileW*i), dy - int(tileH*(i-1)), dw, dh);
      copy(pg, sx + int((tileW*i)*r), sy - int((tileH*(i-2))*r), sw, sh, dx + int(tileW*i), dy - int(tileH*(i-2)), dw, dh);
      copy(pg, sx + int((tileW*i)*r), sy - int((tileH*(i-3))*r), sw, sh, dx + int(tileW*i), dy - int(tileH*(i-3)), dw, dh);
      copy(pg, sx + int((tileW*i)*r), sy - int((tileH*(i-4))*r), sw, sh, dx + int(tileW*i), dy - int(tileH*(i-4)), dw, dh);
      
      copy(pg, sx + int((tileW*i)*r), sy + int((tileH*(i))*r), sw, sh, dx + int(tileW*i), dy + int(tileH*(i)), dw, dh);
      copy(pg, sx + int((tileW*i)*r), sy + int((tileH*(i-1))*r), sw, sh, dx + int(tileW*i), dy + int(tileH*(i-1)), dw, dh);
      copy(pg, sx + int((tileW*i)*r), sy + int((tileH*(i-2))*r), sw, sh, dx + int(tileW*i), dy + int(tileH*(i-2)), dw, dh);
      copy(pg, sx + int((tileW*i)*r), sy + int((tileH*(i-3))*r), sw, sh, dx + int(tileW*i), dy + int(tileH*(i-3)), dw, dh);
      copy(pg, sx + int((tileW*i)*r), sy + int((tileH*(i-4))*r), sw, sh, dx + int(tileW*i), dy + int(tileH*(i-4)), dw, dh);
      
      copy(pg, sx - int((tileW*i)*r), sy + int((tileH*(i))*r), sw, sh, dx - int(tileW*i), dy + int(tileH*(i)), dw, dh);
      copy(pg, sx - int((tileW*i)*r), sy + int((tileH*(i-1))*r), sw, sh, dx - int(tileW*i), dy + int(tileH*(i-1)), dw, dh);
      copy(pg, sx - int((tileW*i)*r), sy + int((tileH*(i-2))*r), sw, sh, dx - int(tileW*i), dy + int(tileH*(i-2)), dw, dh);
      copy(pg, sx - int((tileW*i)*r), sy + int((tileH*(i-3))*r), sw, sh, dx - int(tileW*i), dy + int(tileH*(i-3)), dw, dh);
      copy(pg, sx - int((tileW*i)*r), sy + int((tileH*(i-4))*r), sw, sh, dx - int(tileW*i), dy + int(tileH*(i-4)), dw, dh);
      
      copy(pg, sx - int((tileW*i)*r), sy - int((tileH*(i))*r), sw, sh, dx - int(tileW*i), dy - int(tileH*(i)), dw, dh);
      copy(pg, sx - int((tileW*i)*r), sy - int((tileH*(i-1))*r), sw, sh, dx - int(tileW*i), dy - int(tileH*(i-1)), dw, dh);
      copy(pg, sx - int((tileW*i)*r), sy - int((tileH*(i-2))*r), sw, sh, dx - int(tileW*i), dy - int(tileH*(i-2)), dw, dh);
      copy(pg, sx - int((tileW*i)*r), sy - int((tileH*(i-3))*r), sw, sh, dx - int(tileW*i), dy - int(tileH*(i-3)), dw, dh);
      copy(pg, sx - int((tileW*i)*r), sy - int((tileH*(i-4))*r), sw, sh, dx - int(tileW*i), dy - int(tileH*(i-4)), dw, dh);
      
      //
      
      //copy(pg, sx + int((tileW*i)*r), sy - int((tileH*i)*r), sw, sh, dx + int(tileW*i), dy - int(tileH*(i-1)), dw, dh);
      //copy(pg2, sx + int((tileW*i)*r), sy - int((tileH*i)*r), sw, sh, dx + int(tileW*i), dy - int(tileH*(i-2)), dw, dh);
      //copy(pg2, sx + int((tileW*i)*r), sy - int((tileH*i)*r), sw, sh, dx + int(tileW*i), dy - int(tileH*(i-3)), dw, dh);
      
      //copy(pg, sx - int((tileW*i)*r), sy, sw, sh, dx - int(tileW*i), dy, dw, dh);
      //copy(pg, sx, sy - int((tileH*i)*r), sw, sh, dx, dy - int(tileH*i), dw, dh);
      //copy(pg, sx - int((tileW*i)*r), sy - int((tileH*i)*r), sw, sh, dx - int(tileW*i), dy - int(tileH*i), dw, dh);
      //copy(pg, sx + int((tileW*i)*r), sy - int((tileH*i)*r), sw, sh, dx + int(tileW*i), dy - int(tileH*i), dw, dh);
      

      
      
      //copy(pg, sx + int((tileW*i)*r), sy, sw, sh, dx + int(tileW*i), dy, dw, dh);
      //copy(pg, sx, sy + int((tileH*i)*r), sw, sh, dx, dy + int(tileH*i), dw, dh);
      //copy(pg, sx + int((tileW*i)*r), sy + int((tileH*i)*r), sw, sh, dx + int(tileW*i), dy + int(tileH*i), dw, dh);
     // copy(pg, sx - int((tileW*i)*r), sy + int((tileH*i)*r), sw, sh, dx - int(tileW*i), dy + int(tileH*i), dw, dh);
      

      
      
    }
  }
  
  copy(pg, sx, sy, sw, sh, dx, dy, dw, dh);
  
}
