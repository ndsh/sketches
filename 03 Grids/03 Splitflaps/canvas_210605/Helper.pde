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
      exportSettingsFile();
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



color black = color(0);
color white = color(255);
color gray = color(125);

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

void exportSettingsFile() {
  String[] list = {
   "EXPORT","--------------",
   "Resolution=\t" + resolutions[selectResolution][0] +"x"+resolutions[selectResolution][1] + " ["+ selectResolution +"]",
   "Grid size=\t" + gridSize,
   "Char sets=\t" + charSets[selectSet],
   "Font=\t\t" + fontNames[selectFont],
   "Image=\t\t" + getFilename(imgFiles.get(imgIndex)),
   "Video=\t\t" + getFilename(movFiles.get(movIndex))
  };
  saveStrings("_EXPORT/"+folderFormat+"-"+exportCounter+"/_settings.txt", list);
}

void loadSettings() {
  String[] lines = loadStrings("settings/resolutions.ini");
  println("there are " + lines.length + " lines");
  for (int i = 0 ; i < lines.length; i++) {
    println(lines[i]);
  }

}
