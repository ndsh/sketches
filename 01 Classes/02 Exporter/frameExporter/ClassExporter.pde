class Exporter {
  // Exports in format:
  // Exports / {Application Name} / {Date_Time} / {Frame} .ext
  
  // frameLimit = wieviele Frames wir haben wollen
  int frameRate;
  String path;
  long frameNr;
  boolean closeAfterExport = false;
  long frameLimit = 0;
  int saveMode = 0;
  
  String y = year()+"";
  String m = leadingZero(month());
  String d = leadingZero(day());
  String h = leadingZero(hour());
  String i = leadingZero(minute());
  String s = leadingZero(second());

  Exporter(int _frameRate) {
    y = y.substring(2);
    frameRate = _frameRate;
  }
  
  void update() {
  }
  
  void export() {
    // for more information about which file extension to pick:
    // https://forum.processing.org/one/topic/saveframe-framerate-comparison-discussion-on-capturing-high-resolution-sketch-output.html
    String folderFormat = y + m + d + "_" + h + i + s;
    String fullExportPath = "../../../Exports/"+ path +"/"+ folderFormat +"/";
    println("saving frameNr = "+ frameNr + " of " + frameLimit);
    if(saveMode == 0) {
      // tga is the fastest export. no compression
      save(fullExportPath + frameNr +".tga");
    } else if(saveMode == 1) {
      // png sucks ass
      save(fullExportPath + frameNr +".png");
    }
    frameNr++;
    
    if(frameNr >= frameLimit && frameLimit != 0) {
      println("Exporter= Finished saving frames until limit ( "+ frameLimit +" ).\nQuitting now");
      exit();
    }
    
    // show the record frame
    push();
    stroke(255,0,0);
    strokeWeight(2);
    noFill();
    rect(0,0,width-1,height-1);
    pop();
    
  }
  
  void export(PImage p) {
    // for more information about which file extension to pick:
    // https://forum.processing.org/one/topic/saveframe-framerate-comparison-discussion-on-capturing-high-resolution-sketch-output.html
    String folderFormat = y + m + d + "_" + h + i + s;
    String fullExportPath = "../../../Exports/"+ path +"/"+ folderFormat +"/";
    println("saving frameNr = "+ frameNr + " of " + frameLimit);
    if(saveMode == 0) {
      // tga is the fastest export. no compression
      p.save(fullExportPath + frameNr +".tga");
    } else if(saveMode == 1) {
      // png sucks ass
      save(fullExportPath + frameNr +".png");
    }
    frameNr++;
    
    if(frameNr >= frameLimit && frameLimit != 0) {
      println("Exporter= Finished saving frames until limit ( "+ frameLimit +" ).\nQuitting now");
      exit();
    }
    
    // show the record frame
    // if we have a peasycam
    //if(cam != null) cam.beginHUD();
    push();
    stroke(255,0,0);
    strokeWeight(2);
    noFill();
    rect(0,0,width-1,height-1);
    pop();
    // if(cam != null) cam.endHUD();
    
  }
  
  void setPath(String s) {
    path = s;
  }
  
  void setMode(int m) {
    saveMode = m;
  }
  
  void setLimit(long limit) {
    frameLimit = limit;
  }
  
  void setMinutes(long minutes) {
    // minutes to second conversion
    // seconds * frameRate = frames we need to capture at our desired frameRate
    minutes = minutes * 60;
    setLimit(minutes * frameRate);
  }
  
  String leadingZero(int i) {
    String s = ""+i;
    if(i < 10) return s = "0"+s;
    else return s;
  }
}
