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
    }
  }
  
}


String leadingZero(int i) {
  String s = ""+i;
  if(i < 10) return s = "0"+s;
  else return s;
}

void initGrid() {
  grid = new Grid(resolutions[selectResolution][0], resolutions[selectResolution][1], charSets[selectSet], fontNames[selectFont], gridSize, splitflapInterval, splitflapCooldown);
}

Textlabel stateLabel;
Textlabel fpsLabel;
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
  
  cp5.addSlider("gridSize")
  .setPosition(600,300)
  .setRange(0,200)
  .setNumberOfTickMarks(20)
  .setValue(20)
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

public void export(int i) {
  if(!cpInitDone) return;
  exportToggle = !exportToggle;
  println("export= " + exportToggle);
}

void updateGUI() {
  if (!(stateLabel.getStringValue().equals(animation.getStateName()))) stateLabel.setText(animation.getStateName());
  fpsLabel.setText("FRAMERATE: "+ frameRate);
}

void movieEvent(Movie m) {
  m.read();
}
