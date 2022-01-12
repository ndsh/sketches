class GEN7 {
  int index = 14;
  int limit = 15;
  float progress = 0;
  boolean stateChanged = false;

  PVector[] start = new PVector[4];
  PVector[] end = new PVector[4];
  boolean[] draw = new boolean[4];

  PGraphics pg;

  float inc = 10;

  public GEN7(int _w, int _h) {
    pg = createGraphics(_w, _h);
    for (int i = 0; i<4; i++) {
      start[i] = new PVector(0, 0);
      end[i] = new PVector(0, 0);
      draw[i] = false;
    }
  }

  void update() {
    for (int i = 0; i<4; i++)  draw[i] = false;
    switch(index) {
    case 0:
      if (stateChanged) {
        stateChanged = false;
        start[0] = new PVector(0, pg.height/2);
        end[0] = new PVector(0, 0);
        end[0].y = pg.height/2;
      }
      draw[0] = true;
      end[0].x += inc;
      if (end[0].x >= pg.width) {
        stateChanged = true;
        index++;
      }
      break;

    case 1:
      if (stateChanged) {
        stateChanged = false;
        start[0] = new PVector(pg.width/2, pg.height);
        end[0].x = pg.width/2;
        end[0].y = pg.height;
      }
      draw[0] = true;
      end[0].y -= inc;
      if (end[0].y < 0) {
        stateChanged = true;
        index++;
      }
      break;

    case 2:
      if (stateChanged) {
        stateChanged = false;
        start[0] = new PVector(0, pg.height);
        end[0].x = 0;
        end[0].y = pg.height;
      }
      draw[0] = true;
      end[0].y -= inc;
      end[0].x += inc;
      if (end[0].x >= pg.width && end[0].y < 0) {
        stateChanged = true;
        index++;
      }
      break;

    case 3:
      if (stateChanged) {
        stateChanged = false;
        start[0] = new PVector(pg.width, pg.height);
        end[0].x = pg.width;
        end[0].y = pg.height;
      }
      draw[0] = true;
      end[0].y -= inc;
      end[0].x -= inc;
      if (end[0].x < 0 && end[0].y < 0) {
        stateChanged = true;
        index++;
      }
      break;

    case 4:
      if (stateChanged) {
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
      if (end[0].x >= pg.width && end[1].y < 0) {
        stateChanged = true;
        index++;
      }
      break;

    case 5:
      if (stateChanged) {
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
      if (end[0].x >= pg.width && end[1].x >= pg.width && end[1].y < 0) {
        stateChanged = true;
        index++;
      }
      break;

    case 6:
      if (stateChanged) {
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
      if (end[0].x >= pg.width && end[1].x < 0 && end[1].y < 0) {
        stateChanged = true;
        index++;
      }
      break;

    case 7:
      if (stateChanged) {
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


      if (end[0].x >= pg.width && end[1].y < 0) {
        stateChanged = true;
        index++;
      }
      break;

    case 8:
      if (stateChanged) {
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
      if (end[0].y < 0 && end[1].x < 0 && end[1].y < 0) {
        stateChanged = true;
        index++;
      }

      break;

    case 9:
      if (stateChanged) {
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
      if (end[0].x >= pg.width && end[0].y < 0 && end[1].x < 0 && end[1].y < 0) {
        stateChanged = true;
        index++;
      }
      break;

    case 10:
      if (stateChanged) {
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

      if (end[0].x >= pg.width && end[1].y < 0 && end[2].x >= pg.width && end[2].y < 0) {
        stateChanged = true;
        index++;
      }
      break;

    case 11:
      if (stateChanged) {
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

      if (end[0].x >= pg.width && end[1].y < 0 && end[2].x < 0 && end[2].y < 0) {
        stateChanged = true;
        index++;
      }
      break;

    case 12:
      if (stateChanged) {
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
      if (end[0].x >= pg.width && end[0].y < 0 && end[1].x < 0 && end[1].y < 0 && end[2].x >= pg.width) {
        stateChanged = true;
        index++;
      }
      break;

    case 13:
      if (stateChanged) {
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
      if (end[0].x >= pg.width && end[0].y < 0 && end[1].x < 0 && end[1].y < 0 && end[2].y < 0) {
        stateChanged = true;
        index++;
      }
      break;

    case 14:
      if (stateChanged) {
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
      if (end[0].x >= pg.width && end[0].y < 0 && end[1].x < 0 && end[1].y < 0 && end[2].y < 0 && end[3].x >= pg.width) {
        stateChanged = true;
        index = 0;
      }
      break;
    }
  }

  void display(PGraphics p) {
    p.strokeWeight(20);
    p.strokeCap(RECT);

    float mapped = 0;
    for (int i = 0; i<4; i++) {

      if (draw[i]) {
        mapped = map(i, 0, 4, 200, 255);
        p.stroke(mapped);
        p.line(start[i].x, start[i].y, end[i].x, end[i].y);
      }
    }

    p.stroke(240);
    p.rect(0, 0, pg.width, pg.height);
  }
}

class GEN8a {
  int w = 0;
  int h = 0;

  int num = 600;
  float mx[] = new float[num];
  float my[] = new float[num];
  int which = 0;

  int x = 0;
  int y = 0;
  int pX = 0;
  int pY = 0;
  float inc = 30;

  public GEN8a(int _w, int _h) {
    w = _w;
    h = _h;
    x = w/2;
    y = h/2;
  }

  void update() {
    which = frameCount % num;

    int r = (int)random(8);
    pX = x;
    pY = y;
    switch(r) {
    case 0:
      x += inc;
      break;

    case 1:
      x += inc;
      y += inc;
      break;

    case 2:
      y += inc;
      break;

    case 3:
      y += inc;
      x -= inc;
      break;

    case 4:
      x -= inc;
      break;

    case 5:
      x -= inc;
      y -= inc;
      break;

    case 6:
      y -= inc;
      break;

    case 7:
      x += inc;
      y -= inc;
      break;
    }

    x = constrain(x, 0, w);
    y = constrain(y, 0, h);

    mx[which] = x;
    my[which] = y;
  }

  void display(PGraphics pg) {
    pg.push();
    pg.strokeWeight(3);
    for (int i = 0; i < num; i++) {
      // which+1 is the smallest (the oldest in the array)
      int index = (which+1 + i) % num;
      //pg.noStroke();

      //pg.ellipse(mx[index], my[index], i, i);
      if (i+1 == num) {
        pg.noStroke();
        pg.ellipse(mx[index], my[index], 2, 2);
      } else {
        pg.stroke(map(i, 0, num, 0, 255));
        pg.line(mx[index], my[index], mx[(index+1)%num], my[(index+1)%num]);
        pg.noStroke();
        pg.fill(255);
        if (i == which+1) pg.ellipse(mx[index], my[index], 20, 20);
      }
    }
    pg.pop();
  }
}


class GEN8 {
  float x = 0;
  float y = 0;
  int w = 0;
  int h = 0;
  float inc = 60;
  float pX = 0;
  float pY = 0;

  float[] off = new float[8];
  float[] increment = new float[8];
  float[] n = new float[8];

  long timestamp = 0;
  long interval = 100;

  public GEN8(int _w, int _h) {
    w = _w;
    h = _h;
    x = w/2;
    y = h/2;
    for (int i  = 0; i<increment.length; i++) {
      increment[i] += random(0.01);
      off[i] = random(0, w);
    }

    off[2] = 0;
    off[3] = h/2;
    off[4] = w;
    off[5] = h/2;
  }

  void update() {
    //if(millis() - timestamp < interval) return;
    timestamp = millis();

    int r = (int)random(8);
    pX = x;
    pY = y;
    switch(r) {
    case 0:
      x += inc;
      break;

    case 1:
      x += inc;
      y += inc;
      break;

    case 2:
      y += inc;
      break;

    case 3:
      y += inc;
      x -= inc;
      break;

    case 4:
      x -= inc;
      break;

    case 5:
      x -= inc;
      y -= inc;
      break;

    case 6:
      y -= inc;
      break;

    case 7:
      x += inc;
      y -= inc;
      break;
    }

    x = constrain(x, 0, w);
    y = constrain(y, 0, h);
  }

  void update2() {
    for (int i = 0; i<8; i++) {
      if (i < 2 || i > 5) {
        n[i] = noise(off[i])*w;
        off[i] += increment[i];
      }
    }
  }

  void display(PGraphics pg) {
    pg.push();
    //pg.noStroke();
    pg.stroke(255);
    //pg.ellipse(x, y, 20, 20);
    pg.line(x, y, pX, pY);
    pg.pop();
  }

  void display2(PGraphics pg) {
    pg.push();
    pg.stroke(255);
    pg.strokeWeight(40);
    pg.strokeCap(RECT);
    pg.curve(n[0], n[1], n[2], n[3], n[4], n[5], n[6], n[7]);
    pg.pop();
  }
}

class GEN9 {
  // 1 point view, rectangles that go from bottom to top and have the perspective. done.
  int w = 0;
  int h = 0;
  ArrayList<Building> buildings = new ArrayList<>();

  long timestamp = 0;
  long interval = 10000;
  boolean reset = false;

  public GEN9(int _w, int _h) {
    w = _w;
    h = _h;
    for (int i = 0; i<5; i++) buildings.add(new Building());
    timestamp = millis();
  }

  void update() {
    if (millis() - timestamp > interval) {
      timestamp = millis();
    }

    for (Building b : buildings) b.update();
  }

  void display(PGraphics pg) {
    for (Building b : buildings) b.display2(pg);
  }

  class Building {
    float depth = 10;
    int bw = 400;
    int bh = 10;
    PVector pos = new PVector(300, 500);
    float inc = 1;
    float dist = random(1);
    boolean reset = false;

    Building() {
      pos = new PVector(random(600), h + random(200, 500));
      inc = random(1, 5);
      bw = (int)random(600);
      bh = (int)random(100);
    }

    void update() {
      //pos = new PVector(mouseX, mouseY);
      pos.y -= inc;
      if (pos.y < (bh*2)*-1) {
        pos = new PVector(random(600), h + random(200, 500));
        bw = (int)random(600);
        bh = (int)random(50);
        inc = random(1, 5);
        dist = random(0.1, 0.8);
      }
    }

    void display(PGraphics pg) {
      pg.push();
      pg.rectMode(CENTER);
      pg.noFill();
      pg.stroke(255);
      PVector c0 = new PVector(pos.x - bw/2, pos.y - bh/2);
      PVector c1 = new PVector(pos.x + bw/2, pos.y - bh/2);
      PVector c2 = new PVector(pos.x - bw/2, pos.y + bh/2);
      PVector c3 = new PVector(pos.x + bw/2, pos.y + bh/2);
      PVector center = new PVector(w/2, h/2);


      PVector l0 = new PVector( lerp(c0.x, center.x, dist), lerp(c0.y, center.y, dist));
      PVector l1 = new PVector( lerp(c1.x, center.x, dist), lerp(c1.y, center.y, dist));
      PVector l2 = new PVector( lerp(c2.x, center.x, dist), lerp(c2.y, center.y, dist));
      PVector l3 = new PVector( lerp(c3.x, center.x, dist), lerp(c3.y, center.y, dist));
      //pg.line(c0.x, c0.y, center.x, center.y);
      pg.line(c0.x, c0.y, l0.x, l0.y);
      pg.line(c1.x, c1.y, l1.x, l1.y);
      pg.line(c2.x, c2.y, l2.x, l2.y);
      pg.line(c3.x, c3.y, l3.x, l3.y);
      /*pg.line(c1.x, c1.y, center.x, center.y);
       pg.line(c2.x, c2.y, center.x, center.y);
       pg.line(c3.x, c3.y, center.x, center.y);
       */
      //PVector lerpPoint = new PVector( (l0.x + l1.x + l2.x + l3.x) / 4, (l0.y + l1.y + l2.y + l3.y) / 4 );
      pg.rectMode(CORNER);
      //pg.rect(lerpPoint.x, lerpPoint.y, bw * dist, bh * dist);
      pg.rect(l0.x, l0.y, dist(l0.x, l0.y, l1.x, l1.y), dist(l0.x, l0.y, l2.x, l2.y));
      pg.rectMode(CENTER);
      pg.fill(0);
      pg.rect(pos.x, pos.y, bw, bh);
      if (pos.y < h/2) {
        pg.push();
        pg.beginShape();
        pg.fill(255);
        pg.vertex(c2.x, c2.y);
        pg.vertex(l2.x, l2.y);
        pg.vertex(l3.x, l3.y);
        pg.vertex(c3.x, c3.y);
        pg.endShape();
        pg.pop();
      } else if (pos.y >= h/2) {
        pg.push();
        pg.beginShape();
        pg.fill(0);
        pg.vertex(c0.x, c0.y);
        pg.vertex(l0.x, l0.y);
        pg.vertex(l1.x, l1.y);
        pg.vertex(c1.x, c1.y);
        pg.endShape();
        pg.pop();
      }
      pg.pop();
    }

    void display2(PGraphics pg) {
      pg.push();
      pg.rectMode(CENTER);
      pg.noFill();

      PVector c0 = new PVector(pos.x, pos.y);
      PVector center = new PVector(w/2, h/2);
      PVector l0 = new PVector( lerp(c0.x, center.x, dist), lerp(c0.y, center.y, dist));
      pg.stroke(map(dist, 0.1, 0.8, 70, 255));
      pg.strokeWeight(map(dist, 0.1, 0.8, 2, 8));
      pg.strokeCap(CORNER);
      pg.line(c0.x, c0.y, l0.x, l0.y);

      pg.pop();
    }

    void reset() {
      reset = true;
    }
  }
}

class GEN9b {
  PVector point = new PVector(0, 0);
  PVector npoint = new PVector(0, 0);
  PVector rect = new PVector(60, 60);
  PVector nrect = new PVector(60, 60);
  int w = 0;
  int h = 0;
  int constrain;
  long timestamp = 0;
  long interval = 1000;
  long timestamp2 = 0;
  long lockInterval = 60000;
  float inc = 1.5;
  //float tresh = 0.1;

  boolean transition = false;
  boolean rectDone = false;
  boolean locked = false;

  public GEN9b(int _w, int _h) {
    w = _w;
    h = _h;
    point.x = w/2;
    point.y = h/2;
    constrain = w/4;
    timestamp = millis();
    timestamp2 = millis();
  }

  void update() {
    float r = map(sin(frameCount*0.001), -1, 1, 0, 200);
    point.x = map(sin(frameCount*0.05), -1, 1, r, w-r);
    point.y = map(cos(frameCount*0.05), -1, 1, r, h-r);

    if (millis() - timestamp > interval) {
      timestamp = millis();
      nrect = new PVector(random(300, 500)/2, random(100, 300)/2);
      rectDone = true;
    }

    if (!rectDone) {
      if (rect.x < nrect.x) rect.x += inc*2;
      else rect.x -= inc*2;
      if (rect.y < nrect.y) rect.y += inc*2;
      else rect.y -= inc*2;
    }

    if (rect.x/2 - nrect.x/2 <= inc*2 && rect.y/2 - nrect.y/2 <= inc*2) {
      rectDone = false;
    }
  }

  void display(PGraphics pg) {
    pg.push();
    pg.strokeWeight(20);
    pg.rectMode(CENTER);
    pg.stroke(0);
    PVector p1 = new PVector(0, 0);
    PVector p2 = new PVector(point.x-rect.x/2, point.y-rect.y/2);
    PVector p3 = new PVector(w, 0);
    PVector p4 = new PVector(point.x+rect.x/2, point.y-rect.y/2);
    PVector p5 = new PVector(0, h);
    PVector p6 = new PVector(point.x-rect.x/2, point.y+rect.y/2);
    PVector p7 = new PVector(w, h);
    PVector p8 = new PVector(point.x+rect.x/2, point.y+rect.y/2);
    gradient(p1, p2, p3, p4, 20, pg);
    gradient(p3, p4, p7, p8, 20, pg);
    gradient(p7, p8, p5, p6, 20, pg);
    gradient(p5, p6, p1, p2, 20, pg);

    pg.line(p1.x, p1.y, p2.x, p2.y);
    pg.line(p3.x, p3.y, p4.x, p4.y);

    pg.line(p5.x, p5.y, p6.x, p6.y);
    pg.line(p7.x, p7.y, p8.x, p8.y);

    pg.fill(0);
    pg.push();
    pg.translate(point.x, point.y);
    pg.rect(0, 0, rect.x, rect.y);

    //pg.ellipse(0, 0, 10, 10);
    //pg.fill(255, 255, 0);
    //pg.text(point.x +" / " + point.y, 0, 0);
    pg.pop();


    pg.pop();
  }

  void gradient(PVector p1, PVector p2, PVector p3, PVector p4, int steps, PGraphics pg) {
    pg.push();
    pg.strokeWeight(20);
    for (int i = 0; i<steps; i++) {

      float mapped = map(i, 0, steps, 0.0, 1.0);
      float mapped2 = map(i, 0, steps, 185, 0);
      pg.stroke(mapped2);
      pg.line(lerp(p1.x, p2.x, mapped), lerp(p1.y, p2.y, mapped), lerp(p3.x, p4.x, mapped), lerp(p3.y, p4.y, mapped));
    }
    pg.pop();
  }
}

class GEN9x {
  PVector point = new PVector(0, 0);
  PVector npoint = new PVector(0, 0);
  PVector rect = new PVector(60, 60);
  PVector nrect = new PVector(60, 60);
  int w = 0;
  int h = 0;
  int constrain;
  long timestamp = 0;
  long interval = 1000;
  long timestamp2 = 0;
  long lockInterval = 60000;
  float inc = 1.5;
  //float tresh = 0.1;

  boolean transition = false;
  boolean rectDone = false;
  boolean locked = false;

  public GEN9x(int _w, int _h) {
    w = _w;
    h = _h;
    point.x = w/2;
    point.y = h/2;
    constrain = w/4;
    timestamp = millis();
    timestamp2 = millis();
  }

  void update() {
    if (locked) {
      npoint.x = w/2;
      npoint.y = h/2;
      nrect = new PVector(60, 60);
    }
    if (millis() - timestamp2 > lockInterval) {
      println("locked" + millis());
      if (point.x < npoint.x) point.x += inc;
      else point.x -= inc;
      if (point.y < npoint.y) point.y += inc;
      else point.y -= inc;
      if (rect.x < nrect.x) rect.x += inc*2;
      else rect.x -= inc*2;
      if (rect.y < nrect.y) rect.y += inc*2;
      else rect.y -= inc*2;
      locked = true;

      if (locked && point.x - npoint.x <= inc && point.y - npoint.y <= inc) {
        locked = false;
        timestamp2 = millis();
      }
      return;
    }
    if (millis() - timestamp > interval && !transition) {
      timestamp = millis();
      //npoint = new PVector(random(constrain, w-constrain), random(constrain, h-constrain));
      npoint = new PVector(random(150, (w*2)-300), random(150, (h*2)-300));
      transition = true;
      rectDone = false;
      nrect = new PVector(random(300, 500)/2, random(100, 300)/2);
    }

    if (transition) {
      if (point.x < npoint.x) point.x += inc;
      else point.x -= inc;
      if (point.y < npoint.y) point.y += inc;
      else point.y -= inc;

      if (!rectDone) {
        if (rect.x < nrect.x) rect.x += inc*2;
        else rect.x -= inc*2;
        if (rect.y < nrect.y) rect.y += inc*2;
        else rect.y -= inc*2;
      }

      if (rect.x/2 - nrect.x/2 <= inc*2 && rect.y/2 - nrect.y/2 <= inc*2) {
        rectDone = false;
      }

      if (point.x - npoint.x <= inc && point.y - npoint.y <= inc) {
        transition = false;
      }
    }
  }

  void display(PGraphics pg) {
    pg.push();
    pg.strokeWeight(20);
    pg.rectMode(CENTER);
    pg.stroke(0);
    PVector p1 = new PVector(0, 0);
    PVector p2 = new PVector(point.x-rect.x/2, point.y-rect.y/2);
    PVector p3 = new PVector(w, 0);
    PVector p4 = new PVector(point.x+rect.x/2, point.y-rect.y/2);
    PVector p5 = new PVector(0, h);
    PVector p6 = new PVector(point.x-rect.x/2, point.y+rect.y/2);
    PVector p7 = new PVector(w, h);
    PVector p8 = new PVector(point.x+rect.x/2, point.y+rect.y/2);
    gradient(p1, p2, p3, p4, 20, pg);
    gradient(p3, p4, p7, p8, 20, pg);
    gradient(p7, p8, p5, p6, 20, pg);
    gradient(p5, p6, p1, p2, 20, pg);

    pg.line(p1.x, p1.y, p2.x, p2.y);
    pg.line(p3.x, p3.y, p4.x, p4.y);

    pg.line(p5.x, p5.y, p6.x, p6.y);
    pg.line(p7.x, p7.y, p8.x, p8.y);

    pg.fill(0);
    pg.push();
    pg.translate(point.x, point.y);
    pg.rect(0, 0, rect.x, rect.y);
    //pg.ellipse(0, 0, 10, 10);
    //pg.fill(255, 255, 0);
    //pg.text(point.x +" / " + point.y, 0, 0);
    pg.pop();
    pg.pop();
  }

  void gradient(PVector p1, PVector p2, PVector p3, PVector p4, int steps, PGraphics pg) {
    pg.push();
    pg.strokeWeight(20);
    for (int i = 0; i<steps; i++) {

      float mapped = map(i, 0, steps, 0.0, 1.0);
      float mapped2 = map(i, 0, steps, 185, 0);
      pg.stroke(mapped2);
      pg.line(lerp(p1.x, p2.x, mapped), lerp(p1.y, p2.y, mapped), lerp(p3.x, p4.x, mapped), lerp(p3.y, p4.y, mapped));
    }
    pg.pop();
  }
}

class GEN10 {
  int tw = 12;
  int th = 6;
  int w;
  int h;
  float[] inc;
  float[] off;
  int Y_AXIS = 1;
  int X_AXIS = 2;

  public GEN10(int _w, int _h) {
    w = _w;
    h = _h;
    off = new float[tw*th];
    inc = new float[tw*th];
    for (int i = 0; i<off.length; i++) {
      inc[i] = random(0.01, 0.02);
      off[i] = random(tw*th);
    }
  }

  void update() {
  }

  void display(PGraphics pg) {
    float wTile = w/tw;
    float hTile = h/th;

    pg.push();
    pg.rectMode(CORNER);
    pg.noStroke();

    for (int y = 0; y<th; y++) {
      for (int x = 0; x<tw; x++) {
        int i = y*tw+x;
        float n = noise(off[i])*255;
        off[i] += inc[i];
        pg.fill(n);
        if (y == 3 || y == 2) {
          //setGradient(int x, int y, float w, float h, color c1, color c2, int axis, float r)
          setGradient((int)(x*wTile*2), (int)(y*hTile), (int)wTile*2, (int)hTile, color(n), color((n+60)%255), X_AXIS, 0, pg);
          //pg.rect(x*wTile*2, y*hTile, wTile*2, hTile);
        } else if (y == 5) {
          //pg.rect(x*wTile*4, y*hTile, wTile*4, hTile);
          setGradient((int)(x*wTile*4), (int)(y*hTile), (int)wTile*4, (int)hTile, color(n), color((n+60)%255), X_AXIS, 0, pg);
        } else {
          setGradient((int)(x*wTile), (int)(y*hTile), (int)wTile, (int)hTile, color(n), color((n+60)%255), Y_AXIS, 0, pg);
          //pg.rect(x*wTile, y*hTile, wTile, hTile);
        }
      }
    }
    pg.pop();
  }


  void setGradient(int x, int y, float w, float h, color c1, color c2, int axis, float r, PGraphics pg) {
    pg.push();
    //pg.translate(x, y);
    //pg.rotate(radians(r));
    pg.noFill();

    if (axis == Y_AXIS) {  // Top to bottom gradient
      for (int i = y; i <= y+h; i++) {
        float inter = map(i, y, y+h, 0, 1);
        color c = lerpColor(c1, c2, inter);
        pg.stroke(c);
        pg.line(x, i, x+w, i);
      }
    }  
    else if (axis == X_AXIS) {  // Left to right gradient
      for (int i = x; i <= x+w; i++) {
        float inter = map(i, x, x+w, 0, 1);
        color c = lerpColor(c1, c2, inter);
        pg.stroke(c);
        pg.line(i, y, i, y+h);
      }
    }
    pg.pop();
  }
}

class GEN12 {
  int w;
  int h;
  
  int index = 0;
  int step = 0;
  int margin = 60;
  int max = 10;
  
  long timestamp1 = 0;
  long interval1 = 200;
  
  long timestamp2 = 0;
  long interval2 = 2000;
  
  boolean wait = false;
  
  public GEN12(int _w, int _h){
    w = _w;
    h = _h;
    
    
  } 
  
  void update() {
    if(millis() - timestamp1 > interval1 && !wait) {
      timestamp1 = millis();
      step++;
    }
    
    if(step >= 10) {
      step = 0;
      index++;
      wait = true;
    }
    
    if(index > 3) index = 0;
    
    if(millis() - timestamp2 > interval2) {
      timestamp2 = millis();
      wait = false;
    }
  }
  
  void display(PGraphics pg) {
    if(wait) return;
    pg.push();
    pg.strokeWeight(25);
    
    for(int i = 0; i<step; i++) {
      pg.push();
      pg.translate(pg.width/2 + i*margin, pg.height/2 + i*margin);
      pg.stroke(map(i, 0, step, 255, 140), 150);
      pg.line(-pg.width/2 + 20, -pg.height/2 + 20, pg.width/2-20, -pg.height/2 + 20);
      pg.line(-pg.width/2 + 20, -pg.height/2 + 20, -pg.width/2 + 20, pg.height/2 - 20);
      pg.pop();
    }
    pg.pop();
    pg.endDraw();
    
    PGraphics pg2 = createGraphics(pg.width, pg.height);
    pg2 = pg;
    
    pg.beginDraw();
    pg.push();
    pg.clear();
    pg.imageMode(CENTER);
    pg.rectMode(CENTER);
    pg.translate(pg.width/2, pg.height/2);
    if(index == 0) pg.rotate(radians(0));
    else if(index == 1) pg.rotate(radians(90));
    else if(index == 2) pg.rotate(radians(180));
    else if(index == 3) pg.rotate(radians(270));
    //pg.rotate(radians(0));
    pg.image(pg2, 0, 0);
    pg.pop();
  }
}

class GEN12a {
  Pack pack;

  boolean growing = false;
  int n_start = 100;
  
  int w;
  int h;
  
  long timestamp = 0;
  long interval = 10000;
  
  public GEN12a(int _w, int _h){
    w = _w;
    h = _h;
  
    noiseDetail(2, 0.1);
  
    pack = new Pack(n_start);
  } 
  
  void update() {
    if(millis() - timestamp > interval) {
      timestamp = millis();
      pack.addCircle(new Circle(w/2, h/2));
      pack.initiate(n_start);
      noiseSeed((long)random(100000));
    }
  }
  
  void display(PGraphics pg) {
    pg.push();
    pg.noFill();
    pg.strokeWeight(1.5);
    pg.stroke(5);
    
    background(0);

    pack.run(pg);

    if (growing) pack.addCircle(new Circle(w/2, h/2));
    pg.pop();
  }
  
  class Pack {
    ArrayList<Circle> circles;
  
    float max_speed = 2;
    float max_force = 1.5;
  
    float border = 5;
  
    float min_radius = 5;
    float max_radius = 200;
  
    Pack(int n) {  
      initiate(n);
    }
  
    void initiate(int n) {
      circles = new ArrayList<Circle>(); 
      for (int i = 0; i < n; i++) {
        addCircle(new Circle(w/2, h/2));
      }
    }
  
    void addCircle(Circle b) {
      circles.add(b);
    }
  
    void run(PGraphics pg) {
  
      PVector[] separate_forces = new PVector[circles.size()];
      int[] near_circles = new int[circles.size()];
  
      for (int i=0; i<circles.size(); i++) {
        checkBorders(i);
        updateCircleRadius(i);
        applySeparationForcesToCircle(i, separate_forces, near_circles);
        displayCircle(i, pg);
      }
    }
  
    void checkBorders(int i) {
      Circle circle_i=circles.get(i);
      if (circle_i.position.x-circle_i.radius/2 < border)
        circle_i.position.x = circle_i.radius/2 + border;
      else if (circle_i.position.x+circle_i.radius/2 > w - border)
        circle_i.position.x = w - circle_i.radius/2 - border;
      if (circle_i.position.y-circle_i.radius/2 < border)
        circle_i.position.y = circle_i.radius/2 + border;
      else if (circle_i.position.y+circle_i.radius/2 > h - border)
        circle_i.position.y = h - circle_i.radius/2 - border;
    }
  
    void updateCircleRadius(int i) {
      circles.get(i).updateRadius(min_radius, max_radius);
    }
  
    void applySeparationForcesToCircle(int i, PVector[] separate_forces, int[] near_circles) {
  
      if (separate_forces[i]==null)
        separate_forces[i]=new PVector();
  
      Circle circle_i=circles.get(i);
  
      for (int j=i+1; j<circles.size(); j++) {
  
        if (separate_forces[j] == null) 
          separate_forces[j]=new PVector();
  
        Circle circle_j=circles.get(j);
  
        PVector forceij = getSeparationForce(circle_i, circle_j);
  
        if (forceij.mag()>0) {
          separate_forces[i].add(forceij);        
          separate_forces[j].sub(forceij);
          near_circles[i]++;
          near_circles[j]++;
        }
      }
  
      if (near_circles[i]>0) {
        separate_forces[i].div((float)near_circles[i]);
      }
  
      if (separate_forces[i].mag() >0) {
        separate_forces[i].setMag(max_speed);
        separate_forces[i].sub(circles.get(i).velocity);
        separate_forces[i].limit(max_force);
      }
  
      PVector separation = separate_forces[i];
  
      circles.get(i).applyForce(separation);
      circles.get(i).update();
  
      // If they have no intersecting neighbours they will stop moving
      circle_i.velocity.x = 0.0;
      circle_i.velocity.y = 0.0;
    }
  
    PVector getSeparationForce(Circle n1, Circle n2) {
      PVector steer = new PVector(0, 0, 0);
      float d = PVector.dist(n1.position, n2.position);
      if ((d > 0) && (d < n1.radius/2+n2.radius/2 + border)) {
        PVector diff = PVector.sub(n1.position, n2.position);
        diff.normalize();
        diff.div(d);
        steer.add(diff);
      }
      return steer;
    }
  
    String getSaveName() {
      return  day()+""+hour()+""+minute()+""+second();
    }
  
  
    void displayCircle(int i, PGraphics pg) {
      circles.get(i).display(pg);
    }
  }
  
  class Circle {
  
    PVector position;
    PVector velocity;
    PVector acceleration;
  
    float radius = 1;
  
    Circle(float x, float y) {
      acceleration = new PVector(0, 0);
      velocity = PVector.random2D();
      position = new PVector(x, y);
    }
  
    void applyForce(PVector force) {
      acceleration.add(force);
    }
  
    void update() {
      //velocity.add(noise(100+position.x*0.01, 100+position.y*0.01)*0.5, noise(200+position.x*0.01, 200+position.y*0.01)*0.5); 
      velocity.add(acceleration);
      position.add(velocity);
      acceleration.mult(0);
    }
  
    void updateRadius(float min, float max) {
      radius = min + noise(position.x*0.01, position.y*0.01) * (max-min);
    }
  
    void display(PGraphics pg) {
      //pg.noStroke();
      //pg.fill(255);
      pg.stroke(255);
      pg.strokeWeight(16);
      pg.ellipse(position.x, position.y, radius-16, radius-16);
    }
  }
  /*
  void mouseDragged() {
    pack.addCircle(new Circle(mouseX, mouseY));
  }
  
  void mouseClicked() {
    pack.addCircle(new Circle(mouseX, mouseY));
  }
  
  void keyPressed() {
    if (key == 'r' || key == 'R') {
      pack.initiate(n_start);
      noiseSeed((long)random(100000));
    } else if (key == 'p' || key == 'P') {
      growing=!growing;
    }
  }
  */

}
