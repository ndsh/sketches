final int TARGETBOX = 0;
final int WAVE = 1;
final int PAINT = 2;
final int DITHERTYPE = 3;
final int CLOUDS = 4;
final int RAIN = 5;
final int SUNRISE = 6;
final int SNOW = 7;
final int IMG = 8;
final int VIDEO = 9;

int state = TARGETBOX;
String[] namedStates = {"TARGETBOX", "WAVE", "PAINT", "DITHERTYPE", "CLOUDS", "RAIN", "SUNRISE", "SNOW", "IMG", "VIDEO"};



void stateMachine(int _state) {
  switch(_state) {

  case TARGETBOX:
    //tilesX = (int)map(mouseX, 0, width, 1, 66);
    //tilesY = (int)map(mouseY, 0, height, 1, 18);
    //tileW = int(width/tilesX);
    //tileH = int(height/tilesY);

    pg2.beginDraw();
    pg2.noStroke();
    pg2.background(0);
    //pg2.ellipse(pg.width/2, pg.height/2, tileW-4, tileH-4);
    pg2.textFont(font1);
    pg2.textSize( int( map( facetteX * facetteY, 0, wallW*wallH, 192, 7)));
    pg2.textAlign(CENTER, CENTER);

    pg2.translate(pg2.width/2-4, pg2.height/2+4);
    pg2.rotate(radians(targetRotation) + radians(map(sin(frameCount*targetRotation1), -1, 1, 0, 360)));
    pg2.text(cp5.get(Textfield.class, "input1").getText(), 0, 0);
    pg2.endDraw();

    float r = map(sin(frameCount*targetRotation2), -1, 1, 0.0, 0.1);
    sx = wallW/2-tileW/2;
    sy = wallH/2-tileH/2;
    sw = tileW;
    sh = tileH;
    dx = wallW/2;
    dy = wallH/2;
    dw = tileW;
    dh = tileH;


    pg.beginDraw();
    for (int y = 0; y <= (wallH/tileH)/2; y++) {
      for (int x = 0; x <= (wallW/tileW)/2; x++) {
        wave = sin( (frameCount + ( x*y ) ) * speed) * phasing;
        // x+ y+
        //for(int i = 0; i<=tilesY/2; i++) {
        int i = 0;
        pg.copy(pg2, sx + int( (tileW*x) *r + wave), sy + int( (tileH * (y+i) ) *r ), sw, sh, dx + int(tileW*x), dy + int(tileH*(y+i)), dw, dh);
        // x+ y-
        pg.copy(pg2, sx + int( (tileW*x) *r + wave), sy - int( (tileH * (y+i) ) *r ), sw, sh, dx + int(tileW*x), dy - int(tileH*(y+i)), dw, dh);
        // x- y+
        pg.copy(pg2, sx - int( (tileW*x) *r + wave), sy + int( (tileH * (y+i) ) *r ), sw, sh, dx - int(tileW*x), dy + int(tileH*(y+i)), dw, dh);
        // x- y-
        pg.copy(pg2, sx - int( (tileW*x) *r + wave), sy - int( (tileH * (y+i) ) *r ), sw, sh, dx - int(tileW*x), dy - int(tileH*(y+i)), dw, dh);
        //   }
      }
    }

    pg.endDraw();
    if (pixelate) {
      //image(pixelate(pg), -tileW/2, -tileH/2);
      source = pg.get();
      feed();
      pgTemp.beginDraw();
      pgTemp.clear();
      for (int i = 0; i<dots.size(); i++) {
        dots.get(i).display(pgTemp);
      }
      pgTemp.endDraw();
      //image(pgTemp, 0, 0);
    } else {
      pgTemp.beginDraw();
      pgTemp.image(pg, -tileW/2, -tileH/2);
      pgTemp.endDraw();
      //image(pg, -tileW/2, -tileH/2);
    }
    
    source = pgTemp.get();
    if (asciify) {
      pgTemp.beginDraw();
      pgTemp.background(0);
      pgTemp.textAlign(CENTER, CENTER);
      pgTemp.textFont(font1);
      pgTemp.textSize(20);
      color c = 0;
      float b = 0;
      for (int y = 0; y<tilesY; y++) {
        for (int x = 0; x<tilesX; x++) {
          c = averageColor(source, x*tileW, y*tileH, tileW, tileH);
          b = brightness(c);

          asciify(pgTemp, x, y, tileW, tileH, (int)b);
        }
      }
      pgTemp.endDraw();
    }
    
    image(pgTemp, 0, 0);


    // draw the target box with a yellow stroke
    boolean showTarget = false;
    if (showTarget) {
      push();
      noFill();
      stroke(255, 255, 0);
      rect(wallW/2, wallH/2, tileW, tileH);
      pop();
    }
    break;

  case WAVE:
    pg.beginDraw();
    //if(mode != 3) pg.background(0);
    //pg.fill(0, 120);
    //pg.rect(0,0,pg.width,pg.height);
    pg.fill(255);
    pg.pushMatrix();

    if (!doubleText) {
      pg.clear();
      pg.translate(wallW/2 + 12, wallH - (tileH*2) );
      pg.textFont(font1);
      if (bigText) {
        pg.textSize(192*2);
        pg.text(cp5.get(Textfield.class, "input1").getText(), 0, 0);
      } else {
        pg.textSize(192*1);
        pg.text(cp5.get(Textfield.class, "input1").getText(), 0, -(tileH*2));
      }
    } else {
      pg.translate(wallW/2 + 12, wallH - (tileH*1) );
      pg.textFont(font2);
      pg.textSize(192*1);
      pg.clear();
      pg.text(cp5.get(Textfield.class, "input2").getText(), 0, 0);
      pg.text(cp5.get(Textfield.class, "input1").getText(), 0, -(tileH*8));
    }
    pg.popMatrix();
    pg.endDraw();
    pgTemp.beginDraw();
    pgTemp.clear();
    for (int y = 0; y < tilesY; y++) {
      for (int x = 0; x < tilesX; x++) {

        // WAVE
        if (waveMode == 0) wave = sin( (frameCount + ( x*y ) ) * speed) * phasing;
        else if (waveMode == 1) wave = map(tan( radians(frameCount*speed + (x+y)) ), -1, 1, 0, phasing);
        else if (waveMode == 2) wave = map(tan( radians(frameCount*speed + (x+y)) ), -1, 1, phasing, -phasing);
        else if (waveMode == 3) wave = map(tan( radians(frameCount*speed + (sqrt(x)+y)) ), -1, 1, phasing, -phasing);
        else if (waveMode == 4) wave = 0;
        //int wave = (int)map(sin(radians(frameCount * 3 + x * 0.3 + y * 0.3)), -1, 1, 0, 1);
        //float wave3 = (int)map(sin(radians(frameCount+ (x*y))),-1,1,3,1.6);
        //float wave4 = map(sin(radians(frameCount)), -1, 1, 1.3, 2.4);
        //float wave5 = map(tan(radians(frameCount + (x*y)) ), -1, 1, -phasing, phasing);


        if (waveDirection) {
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

        pgTemp.copy(pg, sx, sy, sw, sh, dx, dy, dw, dh);
      }
    }
    pgTemp.endDraw();

    if (pixelate) {
      //image(pixelate(pg), -tileW/2, -tileH/2);
      source = pgTemp.get();
      feed();
      pgTemp.beginDraw();
      pgTemp.clear();
      for (int i = 0; i<dots.size(); i++) {
        dots.get(i).display(pgTemp);
      }
      pgTemp.endDraw();
      //image(pgTemp, 0, 0);
    }
    
    source = pgTemp.get();
    if (asciify) {
      pgTemp.beginDraw();
      pgTemp.background(0);
      pgTemp.textAlign(CENTER, CENTER);
      pgTemp.textFont(font1);
      pgTemp.textSize(20);
      color c = 0;
      float b = 0;
      for (int y = 0; y<tilesY; y++) {
        for (int x = 0; x<tilesX; x++) {
          c = averageColor(source, x*tileW, y*tileH, tileW, tileH);
          b = brightness(c);

          asciify(pgTemp, x, y, tileW, tileH, (int)b);
        }
      }
      pgTemp.endDraw();
    }
    image(pgTemp, 0, 0);

    break;

  case PAINT:
    pgTemp.beginDraw();
    if (ditherThis) pgTemp.fill(0, 10);
    else pgTemp.background(0);
    pgTemp.rect(0, 0, wallW, wallH);
    pgTemp.endDraw();

    if (ditherThis) {
      d.feed(pgTemp.get());
      image(d.dither(), 0, 0);
    } else image(pgTemp, 0, 0);
    break;

  case DITHERTYPE:
    pg.beginDraw();
    //if(mode != 3) pg.background(0);
    //pg.fill(0, 120);
    //pg.rect(0,0,pg.width,pg.height);
    pg.fill(255);
    pg.pushMatrix();

    if (!doubleText) {
      pg.clear();
      pg.translate(wallW/2 + 12, wallH - (tileH*2) );
      pg.textFont(font1);
      if (bigText) {
        pg.textSize(192*2);
        pg.text(cp5.get(Textfield.class, "input1").getText(), 0, 0);
      } else {
        pg.textSize(192*1);
        pg.text(cp5.get(Textfield.class, "input1").getText(), 0, -(tileH*2));
      }
    } else {
      pg.translate(wallW/2 + 12, wallH - (tileH*1) );
      pg.textFont(font2);
      pg.textSize(192*1);
      pg.clear();
      pg.text(cp5.get(Textfield.class, "input2").getText(), 0, 0);
      pg.text(cp5.get(Textfield.class, "input1").getText(), 0, -(tileH*8));
    }
    pg.popMatrix();
    pg.endDraw();

    pgTemp.beginDraw();
    pgTemp.clear();

    for (int y = 0; y < tilesY; y++) {
      for (int x = 0; x < tilesX; x++) {
        if (waveMode == 0) wave = sin( (frameCount + ( x*y ) ) * speed) * phasing;
        else if (waveMode == 1) wave = map(tan( radians(frameCount*speed + (x+y)) ), -1, 1, 0, phasing);
        else if (waveMode == 2) wave = map(tan( radians(frameCount*speed + (x+y)) ), -1, 1, phasing, -phasing);
        else if (waveMode == 3) wave = map(tan( radians(frameCount*speed + (sqrt(x)+y)) ), -1, 1, phasing, -phasing);
        else if (waveMode == 4) wave = 0;
        //int wave = (int)map(sin(radians(frameCount * 3 + x * 0.3 + y * 0.3)), -1, 1, 0, 1);
        //float wave3 = (int)map(sin(radians(frameCount+ (x*y))),-1,1,3,1.6);
        //float wave4 = map(sin(radians(frameCount)), -1, 1, 1.3, 2.4);
        //float wave5 = map(tan(radians(frameCount + (x*y)) ), -1, 1, -phasing, phasing);

        if (waveDirection) {
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

        pgTemp.copy(pg, sx, sy, sw, sh, dx, dy, dw, dh);
      }
    }
    pgTemp.endDraw();

    pgTemp.beginDraw();
    pgTemp.fill(0, ditherAlpha);
    pgTemp.rect(0, 0, wallW, wallH);
    pgTemp.endDraw();

    if (ditherThis) {
      d.feed(pgTemp.get());
      image(d.dither(), 0, 0);
    } else image(pgTemp, 0, 0);
    break;

  case CLOUDS:
    pgTemp.loadPixels();

    float xoff = 0.0;
    for (int x = 0; x < wallW; x++) {
      xoff += xincrement;
      float yoff = 0.0;
      for (int y = 0; y < wallH; y++) {
        yoff += yincrement;
        float bright = noise(xoff, yoff, zoff)*noiseBrightness;
        pgTemp.pixels[x+y*wallW] = color(bright, bright, bright);
      }
    }
    pgTemp.updatePixels();

    zoff += zincrement; // Increment zoff

    pg4.beginDraw();
    pg4.image(pgTemp, 0, 0);
    //pg4.fill(0, ditherAlpha);
    //pg4.rect(0, 0, wallW, wallH);
    pg4.endDraw();

    if (ditherThis) {
      d.feed(pg4.get());
      pg4 = d.dither();
    } // else image(pg4, 0, 0);

    //image(pg4, 0, 0);
    if (pixelate) {
      //image(pixelate(pg), -tileW/2, -tileH/2);
      source = pg4.get();
      feed();
      pgTemp.beginDraw();
      pgTemp.clear();
      for (int i = 0; i<dots.size(); i++) {
        dots.get(i).display(pgTemp);
      }
      pgTemp.endDraw();
      image(pgTemp, 0, 0);
    } else image(pg4, 0, 0);


    //image(pg4, 0, 0);

    break;

  case RAIN:
    //println("rain geht gerade nicht");
    pgTemp.beginDraw();
    pgTemp.background(0);
    for (int i = 0; i < drops.length; i++) {
      drops[i].fall(); // sets the shape and speed of drop
      drops[i].show(pgTemp); // render drop
    }
    pgTemp.endDraw();

    pg4.beginDraw();
    pg4.image(pgTemp, 0, 0);
    //pg4.fill(0, ditherAlpha);
    //pg4.rect(0, 0, wallW, wallH);
    pg4.endDraw();

    if (ditherThis) {
      d.feed(pg4.get());
      pg4 = d.dither();
    } // else image(pg4, 0, 0);

    //image(pg4, 0, 0);
    if (pixelate) {
      //image(pixelate(pg), -tileW/2, -tileH/2);
      source = pg4.get();
      feed();
      pgTemp.beginDraw();
      pgTemp.clear();
      for (int i = 0; i<dots.size(); i++) {
        dots.get(i).display(pgTemp);
      }
      pgTemp.endDraw();
      image(pgTemp, 0, 0);
    } else image(pg4, 0, 0);

    break;

  case SUNRISE:
    pgTemp.beginDraw();
    pgTemp.background(0);
    //pg5.fill(sunBrightness);
    //pg5.ellipse(wallW/2, sunPos, sunSize, sunSize);
    drawSun(wallW/2, sunPos, (int)sunSize, 20);
    pgTemp.endDraw();

    pg4.beginDraw();
    pg4.image(pgTemp, 0, 0);
    //pg4.fill(0, ditherAlpha);
    //pg4.rect(0, 0, wallW, wallH);
    pg4.endDraw();

    /*
    if (ditherThis) {
     d.feed(pg4.get());
     image(d.dither(), 0, 0);
     } else image(pg4, 0, 0);
     */
    if (ditherThis) {
      d.feed(pg4.get());
      pg4 = d.dither();
    } // else image(pg4, 0, 0);

    //image(pg4, 0, 0);
    if (pixelate) {
      //image(pixelate(pg), -tileW/2, -tileH/2);
      source = pg4.get();
      feed();
      pgTemp.beginDraw();
      pgTemp.clear();
      for (int i = 0; i<dots.size(); i++) {
        dots.get(i).display(pgTemp);
      }
      pgTemp.endDraw();
      image(pgTemp, 0, 0);
    } else image(pg4, 0, 0);
    break;

  case SNOW:
    //println("snow geht gerade nicht");
    pgTemp.beginDraw();
    pgTemp.background(0);
    for (int i = 0; i < flakes.length; i++) {
      flakes[i].fall(); // sets the shape and speed of drop
      flakes[i].show(pgTemp); // render drop
    }
    pgTemp.endDraw();

    pg4.beginDraw();
    pg4.image(pgTemp, 0, 0);
    //pg4.fill(0, ditherAlpha);
    //pg4.rect(0, 0, wallW, wallH);
    pg4.endDraw();

    if (ditherThis) {
      d.feed(pg4.get());
      pg4 = d.dither();
    } // else image(pg4, 0, 0);

    //image(pg4, 0, 0);
    if (pixelate) {
      //image(pixelate(pg), -tileW/2, -tileH/2);
      source = pg4.get();
      feed();
      pgTemp.beginDraw();
      pgTemp.clear();
      for (int i = 0; i<dots.size(); i++) {
        dots.get(i).display(pgTemp);
      }
      pgTemp.endDraw();
      image(pgTemp, 0, 0);
    } else image(pg4, 0, 0);

    break;

  case IMG:
    pgTemp.beginDraw();
    pgTemp.image(p, 0, 0, pgTemp.width, pgTemp.height);
    pgTemp.endDraw();
    source = pgTemp.get();
    if (pixelate) {
      feed();
      pgTemp.beginDraw();
      pgTemp.clear();
      for (int i = 0; i<dots.size(); i++) {
        dots.get(i).display(pgTemp);
      }
      pgTemp.endDraw();
    }

    if (asciify) {
      pgTemp.beginDraw();
      pgTemp.background(0);
      pgTemp.textAlign(CENTER, CENTER);
      pgTemp.textFont(font1);
      pgTemp.textSize(20);
      color c = 0;
      float b = 0;
      for (int y = 0; y<tilesY; y++) {
        for (int x = 0; x<tilesX; x++) {
          c = averageColor(source, x*tileW, y*tileH, tileW, tileH);
          b = brightness(c);

          asciify(pgTemp, x, y, tileW, tileH, (int)b);
        }
      }
      pgTemp.endDraw();
    }
    image(pgTemp, 0, 0);

    break;

  case VIDEO:
    pgTemp.beginDraw();
    pgTemp.image(myMovie, 0, 0, pgTemp.width, pgTemp.height);
    pgTemp.endDraw();
    source = pgTemp.get();
    if (pixelate) {
      feed();
      pgTemp.beginDraw();
      pgTemp.clear();
      for (int i = 0; i<dots.size(); i++) {
        dots.get(i).display(pgTemp);
      }
      pgTemp.endDraw();
    }

    if (asciify) {
      pgTemp.beginDraw();
      pgTemp.background(0);
      pgTemp.textAlign(CENTER, CENTER);
      pgTemp.textFont(font1);
      pgTemp.textSize(20);
      color c = 0;
      float b = 0;
      for (int y = 0; y<tilesY; y++) {
        for (int x = 0; x<tilesX; x++) {
          c = averageColor(source, x*tileW, y*tileH, tileW, tileH);
          b = brightness(c);

          asciify(pgTemp, x, y, tileW, tileH, (int)b);
        }
      }
      pgTemp.endDraw();
    }
    image(pgTemp, 0, 0);


    /*
    if (!pixelate) image(myMovie, 0, 0);
     else {
     PImage pTemp = pixelate(myMovie.get());
     image(pTemp, 0, 0);
     }
     //image(myMovie, 0, 0, 0, 0);
     */
    break;
  }
}
