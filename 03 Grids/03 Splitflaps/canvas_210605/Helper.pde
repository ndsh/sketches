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
    } else if (key == 'l' || key == 'L' ) {
      toggleUsefillBG = !toggleUsefillBG;
      println("toggleUsefillBG=" + toggleUsefillBG);
    } else if (key == 'k' || key == 'K' ) {
      // changes the way the flaps are behaving
      // either up in the classic way or the new down way
      toggleFlapDir = !toggleFlapDir;
      println("toggleFlapDir=" + toggleFlapDir);
    } else if (key == 'j' || key == 'J' ) {
      // turn off alpha bg for smearing
      toggleAlphaBG = !toggleAlphaBG;
      println("toggleAlphaBG=" + toggleAlphaBG);
    } else if (key == 'd' || key == 'D' ) {
      // turn off alpha bg for smearing
      toggleBrightnessDetails = !toggleBrightnessDetails;
      println("toggleBrightnessDetails=" + toggleBrightnessDetails);
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
  if(!toggleFullscreen) {
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
  } else {
    cp5.hide();
    image(grid.getDisplay(), 0, 0, width, height);
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
  println("Loaded resolutions.ini with " + lines.length + " different resolutions!");
  resolutions = new int[lines.length][2];
  for (int i = 0 ; i < lines.length; i++) {
    String[] split = split(lines[i], ",");
    resolutions[i][0] = int(split[0]);
    resolutions[i][1] = int(split[1]);
  }
  
  charSets = loadStrings("settings/characters.ini");
  println("Loaded characters.ini with " + charSets.length + " different character sets!");
  fontNames = loadStrings("settings/fonts.ini");
  println("Loaded fonts.ini with " + fontNames.length + " different font!");  
}


// Daniel Shiffman
// http://youtube.com/thecodingtrain
// http://codingtra.in

// Coding Challenge #112: 3D Rendering with Rotation and Projection
// https://youtu.be/p4Iz0XJY-Qk

// Matrix Multiplication
// https://youtu.be/tzsgS19RRc8

float[][] vecToMatrix(PVector v) {
  float[][] m = new float[3][1];
  m[0][0] = v.x;
  m[1][0] = v.y;
  m[2][0] = v.z;
  return m;
}

PVector matrixToVec(float[][] m) {
  PVector v = new PVector();
  v.x = m[0][0];
  v.y = m[1][0];
  if (m.length > 2) {
    v.z = m[2][0];
  }
  return v;
}

void logMatrix(float[][] m) {
  int cols = m[0].length;
  int rows = m.length;
  println(rows + "x" + cols);
  println("----------------");
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      print(m[i][j] + " ");
    }
    println();
  }
  println();
}


PVector matmul(float[][] a, PVector b) {
  float[][] m = vecToMatrix(b);
  return matrixToVec(matmul(a,m));
}

float[][] matmul(float[][] a, float[][] b) {
  int colsA = a[0].length;
  int rowsA = a.length;
  int colsB = b[0].length;
  int rowsB = b.length;

  if (colsA != rowsB) {
    println("Columns of A must match rows of B");
    return null;
  }

  float result[][] = new float[rowsA][colsB];

  for (int i = 0; i < rowsA; i++) {
    for (int j = 0; j < colsB; j++) {
      float sum = 0;
      for (int k = 0; k < colsA; k++) {
        sum += a[i][k] * b[k][j];
      }
      result[i][j] = sum;
    }
  }
  return result;
}
