GEN7 g;

void setup() {
  size(600, 600);
  surface.setLocation(0, 0);
  g = new GEN7(width, height);
  
}

void draw() {
  background(255);
  g.update();
  g.display();
}

class GEN7 {
  int index = 14;
  int limit = 15;
  float progress = 0;
  boolean stateChanged = false;
  
  PVector[] start = new PVector[4];
  PVector[] end = new PVector[4];
  boolean[] draw = new boolean[4];
  
  PGraphics pg;
  
  float inc = 3;
  
  public GEN7(int _w, int _h) {
    pg = createGraphics(_w, _h);
    for(int i = 0; i<4; i++) {
      start[i] = new PVector(0, 0);
      end[i] = new PVector(0, 0);
      draw[i] = false;
    }
    
    
  }
  
  void update() {
    for(int i = 0; i<4; i++)  draw[i] = false;
    switch(index) {
      case 0:
        if(stateChanged) {
          stateChanged = false;
          start[0] = new PVector(0, pg.height/2);
          end[0] = new PVector(0, 0);
          end[0].y = pg.height/2;
          
        }
        draw[0] = true;
        end[0].x += inc;
        if(end[0].x >= pg.width) {
          stateChanged = true;
          index++;
        }
      break;
      
      case 1:
        if(stateChanged) {
          stateChanged = false;
          start[0] = new PVector(pg.width/2, pg.height);
          end[0].x = pg.width/2;
          end[0].y = pg.height;
        }
        draw[0] = true;
        end[0].y -= inc;
        if(end[0].y < 0) {
          stateChanged = true;
          index++;
        }
      break;
      
      case 2:
        if(stateChanged) {
          stateChanged = false;
          start[0] = new PVector(0, pg.height);
          end[0].x = 0;
          end[0].y = pg.height;
        }
        draw[0] = true;
        end[0].y -= inc;
        end[0].x += inc;
        if(end[0].x >= pg.width && end[0].y < 0) {
          stateChanged = true;
          index++;
        }
      break;
      
      case 3:
        if(stateChanged) {
          stateChanged = false;
          start[0] = new PVector(pg.width, pg.height);
          end[0].x = pg.width;
          end[0].y = pg.height;
        }
        draw[0] = true;
        end[0].y -= inc;
        end[0].x -= inc;
        if(end[0].x < 0 && end[0].y < 0) {
          stateChanged = true;
          index++;
        }
      break;
      
      case 4:
        if(stateChanged) {
          stateChanged = false;
          start[0] = new PVector(0, pg.height/2);
          start[1] = new PVector(pg.width/2, pg.height);
          end[0] = new PVector(0, 0);
          end[0].y = pg.height/2;
          end[1].x = pg.width/2;
          end[1].y = pg.height;
        }
        draw[0] = true;
        draw[1] = true;
        end[0].x += inc;
        end[1].y -= inc;
        if(end[0].x >= pg.width && end[1].y < 0) {
          stateChanged = true;
          index++;
        }
      break;
      
     case 5:
        if(stateChanged) {
          stateChanged = false;
          start[0] = new PVector(0, pg.height/2);
          end[0] = new PVector(0, 0);
          end[0].y = pg.height/2;
          start[1] = new PVector(0, pg.height);
          end[1].x = 0;
          end[1].y = pg.height;
        }
        draw[0] = true;
        draw[1] = true;
        end[0].x += inc;
        end[1].y -= inc;
        end[1].x += inc;
        if(end[0].x >= pg.width && end[1].x >= pg.width && end[1].y < 0) {
          stateChanged = true;
          index++;
        }
      break;
      
     case 6:
        if(stateChanged) {
          stateChanged = false;
          start[0] = new PVector(0, pg.height/2);
          end[0] = new PVector(0, 0);
          end[0].y = pg.height/2;
          start[1] = new PVector(pg.width, pg.height);
          end[1].x = pg.width;
          end[1].y = pg.height;
        }
        draw[0] = true;
        draw[1] = true;
        end[0].x += inc;
        end[1].y -= inc;
        end[1].x -= inc;
        if(end[0].x >= pg.width && end[1].x < 0 && end[1].y < 0) {
          stateChanged = true;
          index++;
        }
      break;
      
      case 7:
        if(stateChanged) {
          stateChanged = false;
          start[0] = new PVector(0, pg.height);
          end[0].x = 0;
          end[0].y = pg.height;
          start[1] = new PVector(pg.width/2, pg.height);
          end[1].x = pg.width/2;
          end[1].y = pg.height;
        }
        draw[0] = true;
        draw[1] = true;
        end[0].y -= inc;
        end[0].x += inc;
        end[1].y -= inc;
        
        
        if(end[0].x >= pg.width && end[1].y < 0) {
          stateChanged = true;
          index++;
        }
      break;
      
      case 8:
        if(stateChanged) {
          stateChanged = false;
          start[0] = new PVector(pg.width/2, pg.height);
          end[0].x = pg.width/2;
          end[0].y = pg.height;
          start[1] = new PVector(pg.width, pg.height);
          end[1].x = pg.width;
          end[1].y = pg.height;
        }
        draw[0] = true;
        draw[1] = true;
        end[0].y -= inc;
        end[1].y -= inc;
        end[1].x -= inc;
        if(end[0].y < 0 && end[1].x < 0 && end[1].y < 0) {
          stateChanged = true;
          index++;
        }
        
      break;
      
      case 9:
        if(stateChanged) {
          stateChanged = false;
          start[0] = new PVector(0, pg.height);
          end[0].x = 0;
          end[0].y = pg.height;
          start[1] = new PVector(pg.width, pg.height);
          end[1].x = pg.width;
          end[1].y = pg.height;
        }
        draw[0] = true;
        draw[1] = true;
        end[0].y -= inc;
        end[0].x += inc;
        end[1].y -= inc;
        end[1].x -= inc;
        if(end[0].x >= pg.width && end[0].y < 0 && end[1].x < 0 && end[1].y < 0) {
          stateChanged = true;
          index++;
        }
      break;
      
      case 10:
        if(stateChanged) {
          stateChanged = false;
          start[0] = new PVector(0, pg.height/2);
          start[1] = new PVector(pg.width/2, pg.height);
          end[0] = new PVector(0, 0);
          end[0].y = pg.height/2;
          end[1].x = pg.width/2;
          end[1].y = pg.height;
          start[2] = new PVector(0, pg.height);
          end[2].x = 0;
          end[2].y = pg.height;
        }
        draw[0] = true;
        draw[1] = true;
        draw[2] = true;
        end[0].x += inc;
        end[1].y -= inc;
        end[2].y -= inc;
        end[2].x += inc;
        
        if(end[0].x >= pg.width && end[1].y < 0 && end[2].x >= pg.width && end[2].y < 0) {
          stateChanged = true;
          index++;
        }
      break;
      
      case 11:
        if(stateChanged) {
          stateChanged = false;
          start[0] = new PVector(0, pg.height/2);
          start[1] = new PVector(pg.width/2, pg.height);
          end[0] = new PVector(0, 0);
          end[0].y = pg.height/2;
          end[1].x = pg.width/2;
          end[1].y = pg.height;
          start[2] = new PVector(pg.width, pg.height);
          end[2].x = pg.width;
          end[2].y = pg.height;
        }
        draw[0] = true;
        draw[1] = true;
        draw[2] = true;
        end[0].x += inc;
        end[1].y -= inc;
        end[2].y -= inc;
        end[2].x -= inc;
        
        if(end[0].x >= pg.width && end[1].y < 0 && end[2].x < 0 && end[2].y < 0) {
          stateChanged = true;
          index++;
        }
      break;
      
      case 12:
        if(stateChanged) {
          stateChanged = false;
          start[0] = new PVector(0, pg.height);
          end[0].x = 0;
          end[0].y = pg.height;
          start[1] = new PVector(pg.width, pg.height);
          end[1].x = pg.width;
          end[1].y = pg.height;
          start[2] = new PVector(0, pg.height/2);
          end[2] = new PVector(0, 0);
          end[2].y = pg.height/2;
        }
        draw[0] = true;
        draw[1] = true;
        draw[2] = true;
        end[0].y -= inc;
        end[0].x += inc;
        end[1].y -= inc;
        end[1].x -= inc;
        end[2].x += inc;
        if(end[0].x >= pg.width && end[0].y < 0 && end[1].x < 0 && end[1].y < 0 && end[2].x >= pg.width) {
          stateChanged = true;
          index++;
        }
      break;
      
      case 13:
        if(stateChanged) {
          stateChanged = false;
          start[0] = new PVector(0, pg.height);
          end[0].x = 0;
          end[0].y = pg.height;
          start[1] = new PVector(pg.width, pg.height);
          end[1].x = pg.width;
          end[1].y = pg.height;
          start[2] = new PVector(pg.width/2, pg.height);
          end[2].x = pg.width/2;
          end[2].y = pg.height;
        }
        draw[0] = true;
        draw[1] = true;
        draw[2] = true;
        end[0].y -= inc;
        end[0].x += inc;
        end[1].y -= inc;
        end[1].x -= inc;
        end[2].y -= inc;
        if(end[0].x >= pg.width && end[0].y < 0 && end[1].x < 0 && end[1].y < 0 && end[2].y < 0) {
          stateChanged = true;
          index++;
        }
      break;
      
      case 14:
        if(stateChanged) {
          stateChanged = false;
          start[0] = new PVector(0, pg.height);
          end[0].x = 0;
          end[0].y = pg.height;
          start[1] = new PVector(pg.width, pg.height);
          end[1].x = pg.width;
          end[1].y = pg.height;
          start[2] = new PVector(pg.width/2, pg.height);
          end[2].x = pg.width/2;
          end[2].y = pg.height;
          start[3] = new PVector(0, pg.height/2);
          end[3] = new PVector(0, 0);
          end[3].y = pg.height/2;
        }
        draw[0] = true;
        draw[1] = true;
        draw[2] = true;
        draw[3] = true;
        end[0].y -= inc;
        end[0].x += inc;
        end[1].y -= inc;
        end[1].x -= inc;
        end[2].y -= inc;
        end[3].x += inc;
        if(end[0].x >= pg.width && end[0].y < 0 && end[1].x < 0 && end[1].y < 0 && end[2].y < 0 && end[3].x >= pg.width) {
          stateChanged = true;
          index = 0;
        }
      break;
    }
  }
  
  void display() {
    strokeWeight(100);
    strokeCap(RECT);
    rect(0, 0, pg.width, pg.height);
    for(int i = 0; i<4; i++) {
      if(draw[i]) line(start[i].x , start[i].y, end[i].x, end[i].y);
    }
  }
  
  
}
