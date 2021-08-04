void keyPressed() {
  if (key == CODED) {
    if(keyCode == LEFT) {
      if(animation != null) animation.prevState();
    } else if(keyCode == RIGHT) {
      if(animation != null) animation.nextState();
    } 
  } else {
    if (key == 'e' || key == 'E' ) {
      toggleExport = !toggleExport;
      println("toggleExport= " + toggleExport);
      if(toggleExport) exportCounter++;
    } else if (key == 'b' || key == 'B' ) {
      brightnessToggle = !brightnessToggle;
      println("brightnessToggle= " + brightnessToggle);
    } else if (key == 'f' || key == 'F' ) { 
      if(animation != null) animation.flock.addBoid(new Boid(mouseX,mouseY));
    } else if (key == 'a' || key == 'A' ) {
      toggleFeed = !toggleFeed;
      println("toggleFeed=" + toggleFeed);
    } else if (key == 'i' || key == 'I' ) {
      toggleIncrement = !toggleIncrement;
    }
  }
  if (str(key).toLowerCase().equals("c")) {
    showMouseCursorCheckBox.toggle(0);
  }
  
}

void mousePressed() {
  if (firstClick == false) {
    firstClick = true;
  } else {
    if (mouseActionCheckBox.getArrayValue()[2] == 1) {
      qtflock.boids.add(new qtBoid(new PVector(mouseX, mouseY)));
    }
  }
}


String leadingZero(int i) {
  String s = ""+i;
  if(i < 10) return s = "0"+s;
  else return s;
}

void initGrid() {
  if(grid != null) {
    grid = null;
    System.gc();
  }
  grid = new Grid(resolutions[selectResolution][0], resolutions[selectResolution][1], charSets[selectSet], fontNames[selectFont], gridSize, splitflapInterval, splitflapCooldown);
  if(grid != null && animation != null) animation.updateSize(grid.getTilesize()[0]);
}

Textlabel stateLabel;
Textlabel fpsLabel;
Textlabel fontLabel;
Textlabel charsLabel;
Textlabel imgLabel;
Textlabel movLabel;
//ScrollableList imageList;

color black = color(0, 0, 0);
color white = color(0, 0, 255);
color gray = color(0, 0, 125);

void initCP5() {
  cp5 = new ControlP5(this);
  
  fpsLabel = cp5.addTextlabel("label1")
  .setText("FRAMERATE=")
  .setPosition(10, 10)
  ;
  
  stateLabel = cp5.addTextlabel("label2")
  .setText("ANIMATION")
  .setPosition(600, 105)
  ;
  
  cp5.addButton("PREVSTATE")
  .setValue(0)
  .setPosition(745,100)
  .setSize(20,20)
  .setCaptionLabel("<")
  ;
  cp5.addButton("NEXTSTATE")
  .setValue(0)
  .setPosition(770,100)
  .setSize(20,20)
  .setCaptionLabel(">")
  ;
  
  
  fontLabel = cp5.addTextlabel("label3")
  .setText("FONT=")
  .setPosition(600, 130)
  ;
  
  cp5.addButton("PREVFONT")
  .setValue(0)
  .setPosition(745,125)
  .setSize(20,20)
  .setCaptionLabel("<")
  ;
  cp5.addButton("NEXTFONT")
  .setValue(0)
  .setPosition(770,125)
  .setSize(20,20)
  .setCaptionLabel(">")
  ;
  
  charsLabel = cp5.addTextlabel("label4")
  .setText("CHARS=")
  .setPosition(600, 160)
  ;
  
  cp5.addButton("PREVCHARS")
  .setValue(0)
  .setPosition(745,150)
  .setSize(20,20)
  .setCaptionLabel("<")
  ;
  
  cp5.addButton("NEXTCHARS")
  .setValue(0)
  .setPosition(770,150)
  .setSize(20,20)
  .setCaptionLabel(">")
  ;
  
  imgLabel = cp5.addTextlabel("label5")
  .setText("IMG=")
  .setPosition(600, 190)
  ;
  
  cp5.addButton("PREVIMG")
  .setValue(0)
  .setPosition(745,175)
  .setSize(20,20)
  .setCaptionLabel("<")
  ;
  cp5.addButton("NEXTIMG")
  .setValue(0)
  .setPosition(770,175)
  .setSize(20,20)
  .setCaptionLabel(">")
  ;
  
  movLabel = cp5.addTextlabel("label6")
  .setText("MOV=")
  .setPosition(600, 210)
  ;
  cp5.addButton("PREVMOV")
  .setValue(0)
  .setPosition(745,200)
  .setSize(20,20)
  .setCaptionLabel("<")
  ;
  cp5.addButton("NEXTMOV")
  .setValue(0)
  .setPosition(770,200)
  .setSize(20,20)
  .setCaptionLabel(">")
  ;
  
  
  
  // SLIDERS
  cp5.addSlider("gridSize")
  .setPosition(600,280)
  .setRange(0,199)
  //.setNumberOfTickMarks(200)
  .setValue(gridSize)
  ;
  
  cp5.addSlider("splitflapInterval")
  .setPosition(600,290)
  .setRange(0,255)
  .setValue(splitflapInterval)
  ;
 
  
  cp5.addSlider("splitflapCooldown")
  .setPosition(600,300)
  .setRange(0,2000)
  .setValue(splitflapCooldown)
  ;
  
  // BUTTONS
  cp5.addButton("toggleReverseBrightness")
  .setValue(0)
  .setPosition(700,470)
  .setSize(90,20)
  .setLabel("Brightness flip")
  ;
  
  cp5.addButton("toggleBackground")
  .setValue(0)
  .setPosition(600,470)
  .setSize(90,20)
  .setLabel("BG ON/OFF")
  ;
  
  cp5.addButton("toggleFill")
  .setValue(0)
  .setPosition(600,495)
  .setSize(90,20)
  .setLabel("FILL ON/OFF")
  ;
  
  cp5.addButton("toggleStroke")
  .setValue(0)
  .setPosition(700,495)
  .setSize(90,20)
  .setLabel("STROKE ON/OFF")
  ;
  
  cp5.addButton("play")
  .setValue(0)
  .setPosition(600,520)
  .setSize(90,20)
  .setLabel("PLAY ON/OFF")
  ;
  
  cp5.addButton("feed")
  .setValue(0)
  .setPosition(700,520)
  .setSize(90,20)
  .setLabel("FEED ON/OFF")
  ;
  
  cp5.addButton("debugView")
  .setValue(0)
  .setPosition(600,545)
  .setSize(90,20)
  .setLabel("DEBUGVIEW ON/OFF")
  ;
  
  cp5.addButton("toggleFlapping")
  .setValue(0)
  .setPosition(700,545)
  .setSize(90,20)
  .setLabel("FLAP ON/OFF")
  ;
  
  cp5.addButton("export")
  .setValue(0)
  .setPosition(600,570)
  .setSize(190,20)
  ;
  
  
  cp5.setColorForeground(gray);
  cp5.setColorBackground(black);
  cp5.setColorActive(white);
}

void gridSize(int f) {
  if(!cpInitDone) return;
  gridSize = f;
  initGrid();
}

void splitflapInterval(float f) {
  splitflapInterval = f;
  if(grid != null) grid.updateInterval(splitflapInterval);
}

void splitflapCooldown(float f) {
  splitflapCooldown = f;
  if(grid != null) grid.updateCooldown(splitflapCooldown);
}


/* BUTTONS */
public void PREVSTATE(int i) {
  if(!cpInitDone) return;
  if(animation != null) {
    animation.prevState();
    //stateLabel.setText(animation.getStateName());
  }
  println("prev ani state");
}

public void NEXTSTATE(int i) {
  if(!cpInitDone) return;
  if(animation != null) {
    animation.nextState();
    //stateLabel.setText(animation.getStateName());
  }
  println("next ani state");
}

public void PREVFONT(int i) {
  if(!cpInitDone) return;
  if(animation != null) {
    selectFont--;
    if(selectFont < 0) selectFont = fontNames.length-1;
    initGrid();
  }
  println("prev font");
}

public void NEXTFONT(int i) {
  if(!cpInitDone) return;
  if(animation != null) {
    selectFont++;
    selectFont %= fontNames.length;
    initGrid();
  }
  println("next font");
}

public void PREVCHARS(int i) {
  if(!cpInitDone) return;
  if(animation != null) {
    selectSet--;
    if(selectSet < 0) selectSet = charSets.length-1;
    initGrid();
  }
  println("prev char set");
  print("PREV -- ");
  println("charSets=" + charSets[selectSet]);
}

public void NEXTCHARS(int i) {
  if(!cpInitDone) return;
  if(animation != null) {
    selectSet++;
    selectSet %= charSets.length;
    initGrid();
  }
  println("next char set");
  print("NEXT -- ");
  println("charSets=" + charSets[selectSet]);
}

public void PREVIMG(int i) {
  if(!cpInitDone) return;
  if(animation != null) {
    imgIndex--;
    if(imgIndex < 0) imgIndex = imgFiles.size()-1;
  }
  println("prev img");
}

public void NEXTIMG(int i) {
  if(!cpInitDone) return;
  if(animation != null) {
    imgIndex++;
    imgIndex %= imgFiles.size();
  }
  println("next img");
}

public void PREVMOV(int i) {
  if(!cpInitDone) return;
  if(animation != null) {
    movIndex--;
    if(movIndex < 0) movIndex = movFiles.size()-1;
    animation.stopMovie();
    animation.setMovie(movFiles.get(movIndex));
    
  }
  println("prev mov");
}

public void NEXTMOV(int i) {
  if(!cpInitDone) return;
  if(animation != null) {
    movIndex++;
    movIndex %= movFiles.size();
    animation.stopMovie();
    animation.setMovie(movFiles.get(movIndex));
  }
  println("next mov");
}


public void toggleReverseBrightness(int i) {
  if(!cpInitDone) return;
  toggleBrightnessFlip = !toggleBrightnessFlip;
  println("toggleBrightnessFlip=" + toggleBrightnessFlip);
}

public void toggleBackground(int i) {
  if(!cpInitDone) return;
  toggleBackground = !toggleBackground;
  println("toggleBackground= " + toggleBackground);
}

public void toggleBackground(boolean b) {
  if(!cpInitDone) return;
  toggleBackground = b;
  println("toggleBackground= " + toggleBackground);
}

public void toggleFill(int i) {
  if(!cpInitDone) return;
  toggleFill = !toggleFill;
  println("toggleFill= " + toggleFill);
}

public void toggleStroke(int i) {
  if(!cpInitDone) return;
  toggleStroke = !toggleStroke;
  println("toggleStroke= " + toggleStroke);
}

public void play(int i) {
  if(!cpInitDone) return;
  togglePlay = !togglePlay;
  println("togglePlay= " + togglePlay);
}

public void feed(int i) {
  if(!cpInitDone) return;
  toggleFeed = !toggleFeed;
  println("toggleFeed= " + toggleFeed);
}

public void toggleFlapping(int i) {
  if(!cpInitDone) return;
  toggleFlapping = !toggleFlapping;
  println("toggleFlapping= " + toggleFlapping);
}


public void debugView(int i) {
  if(!cpInitDone) return;
  toggleDebugView = !toggleDebugView;
  println("toggleDebugView= " + toggleDebugView);
}

public void export(int i) {
  if(!cpInitDone) return;
  toggleExport = !toggleExport;
  println("toggleExport= " + toggleExport);
  if(toggleExport) exportCounter++;
}

void updateGUI() {
  if (!(stateLabel.getStringValue().equals(animation.getStateName()))) stateLabel.setText(animation.getStateName());
  fpsLabel.setText("FPS / "+ round(frameRate));
  fontLabel.setText(shortenThis(fontNames[selectFont]));
  charsLabel.setText(shortenThis(charSets[selectSet]));
  imgLabel.setText(shortenThis(getFilename(imgFiles.get(imgIndex))));
  movLabel.setText(shortenThis(getFilename(movFiles.get(movIndex))));
}

void movieEvent(Movie m) {
  m.read();
  frameReady = true;
}

void reloadFiles(String s) {
  println("reloading files");
  importer = new Importer("assets");
  importer.loadFiles(s);
  if(importer.getFiles().size() > 0) {
    if(s.equals("_MOV")) {
      movIndex = 0;
      movFiles = importer.getFiles();
    } else if(s.equals("_IMG")) {
      imgIndex = 0;
      imgFiles = importer.getFiles();
    }
  } 
}

String getFilename(String path) {
  String[] e = split(path, "/");
  return e[e.length-1];
}

String shortenThis(String s) {
  if(s.length() > 21) return s.substring(0, 21) + "...";
  else return s;
  
}

void exportFrames(boolean b) {
  if(b) {
    grid.getDisplay().save("_EXPORT/"+folderFormat+"-"+exportCounter+"/"+ frameNr +".tga");
    frameNr++;
    push();
    fill(255, 0, 0);
    ellipse(570, 570, 20, 20);
    pop();
  }
}

void randomCharSet() {
  selectSet = (int)random(0, charSets.length-1);
  println("charSets=" + charSets[selectSet]);
  initGrid();
}

void randomGridSize() {
  int f = (int)random(20, 100);
  gridSize(f);
}

int detectResolution(int w, int h) {
  int result = 0;
  if(w == h) result = 0;
  else if(w > h) result = 1;
  else if(w < h) result = 2;
  return result;
}


void showWindows(int aspectRatio) {
  if(toggleDebugView) {
    if(aspectRatio == 0) image(animation.getDisplay(), 10, 10, 580, 580);
    else if(aspectRatio == 1) image(animation.getDisplay(), 10, 10, 580, 326);
    if(aspectRatio == 2) image(animation.getDisplay(), 10, 10, 326, 580);
    image(grid.getDisplay(), 600, 10, 80, 80);
  } else {
    if(aspectRatio == 0) image(grid.getDisplay(), 10, 10, 580, 580);
    else if(aspectRatio == 1) image(grid.getDisplay(), 10, 10, 580, 326);
    if(aspectRatio == 2) image(grid.getDisplay(), 10, 10, 326, 580);
    image(animation.getDisplay(), 600, 10, 80, 80);
  }
}
