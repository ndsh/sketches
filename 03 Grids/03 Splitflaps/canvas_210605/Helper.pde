void keyPressed() {
  if (key == CODED) {
    if(keyCode == LEFT) {
      if(animation != null) animation.prevState();
    } else if(keyCode == RIGHT) {
      if(animation != null) animation.nextState();
    } 
  } else {
    if (key == 'e' || key == 'E' ) {
      exportToggle = !exportToggle;
      println("export= " + exportToggle);
    } else if (key == 'b' || key == 'B' ) {
      brightnessToggle = !brightnessToggle;
      println("brightnessToggle= " + brightnessToggle);
    } else if (key == 'f' || key == 'F' ) { 
      if(animation != null) animation.flock.addBoid(new Boid(mouseX,mouseY));
    } else if (key == 'a' || key == 'A' ) {
      toggleFeed = !toggleFeed;
    } else if (key == 'i' || key == 'I' ) {
      toggleIncrement = !toggleIncrement;
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
//ScrollableList imageList;

color black = color(0, 0, 0);
color white = color(0, 0, 255);
color gray = color(0, 0, 125);

void initCP5() {
  cp5 = new ControlP5(this);
  
  stateLabel = cp5.addTextlabel("label1")
  .setText("ANIMATION")
  .setPosition(600, 100)
  ;
  
  cp5.addButton("PREVSTATE")
  .setValue(0)
  .setPosition(680,100)
  .setSize(40,16)
  .setCaptionLabel("<")
  ;
  
  cp5.addButton("NEXTSTATE")
  .setValue(0)
  .setPosition(720,100)
  .setSize(40,16)
  .setCaptionLabel(">")
  ;
  
  fpsLabel = cp5.addTextlabel("label2")
  .setText("FRAMERATE=")
  .setPosition(600, 120)
  ;
  
  cp5.addButton("PREVFONT")
  .setValue(0)
  .setPosition(680,140)
  .setSize(40,16)
  .setCaptionLabel("<")
  ;
  
  cp5.addButton("NEXTFONT")
  .setValue(0)
  .setPosition(720,140)
  .setSize(40,16)
  .setCaptionLabel(">")
  ;
  
  fontLabel = cp5.addTextlabel("label3")
  .setText("FONT=")
  .setPosition(600, 160)
  ;
  
  cp5.addButton("PREVCHARS")
  .setValue(0)
  .setPosition(680,160)
  .setSize(40,16)
  .setCaptionLabel("<")
  ;
  
  cp5.addButton("NEXTCHARS")
  .setValue(0)
  .setPosition(720,160)
  .setSize(40,16)
  .setCaptionLabel(">")
  ;
  
  charsLabel = cp5.addTextlabel("label4")
  .setText("CHARS=")
  .setPosition(600, 180)
  ;
  
  cp5.addSlider("gridSize")
  .setPosition(600,300)
  .setRange(0,300)
  //.setNumberOfTickMarks(60)
  .setValue(80)
  ;
  
  cp5.addSlider("splitflapInterval")
  .setPosition(600,220)
  .setRange(0,255)
  ;
  
  cp5.addSlider("splitflapCooldown")
  .setPosition(600,240)
  .setRange(0,2000)
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
    if(selectSet < 0) selectFont = charSets.length-1;
    initGrid();
  }
  println("prev char set");
}

public void NEXTCHARS(int i) {
  if(!cpInitDone) return;
  if(animation != null) {
    selectSet++;
    selectSet %= charSets.length;
    initGrid();
  }
  println("next char set");
}

public void export(int i) {
  if(!cpInitDone) return;
  exportToggle = !exportToggle;
  println("export= " + exportToggle);
}

void updateGUI() {
  if (!(stateLabel.getStringValue().equals(animation.getStateName()))) stateLabel.setText(animation.getStateName());
  fpsLabel.setText("FRAMERATE: "+ frameRate);
  fontLabel.setText("FONT: "+ fontNames[selectFont]);
  charsLabel.setText("SET: "+ charSets[selectSet]);
}

void movieEvent(Movie m) {
  m.read();
}
