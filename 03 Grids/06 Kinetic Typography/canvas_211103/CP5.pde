boolean cpInitDone = false;

Textlabel labelStatemachine;
Textlabel labelDitherState;
Textlabel labelWaveMode;
Textlabel labelImg;
Textlabel labelVideo;
CheckBox checkboxDither;
CheckBox checkboxGrid;
CheckBox checkboxExport;
CheckBox checkboxTwoLines;
CheckBox checkboxShowCursor;
CheckBox checkboxWaveDirection;
CheckBox checkboxBigText;

void initCP5() {
  cp5 = new ControlP5(this);
  float[] y = {1f};
  float[] n = {0f};

  // LABELS
  labelStatemachine = cp5.addTextlabel("labelStatemachine")
    .setText("(StateMachine)")
    .setPosition(80, 426)
    ;

  labelWaveMode = cp5.addTextlabel("labelWaveMode")
    .setText("(WaveState)")
    .setPosition(700, 420)
    ;

  labelDitherState = cp5.addTextlabel("labelDitherState")
    .setText("(DitherState)")
    .setPosition(700, 450)
    ;
  labelImg = cp5.addTextlabel("labelImg")
    .setText("(Img)")
    .setPosition(1260, 520)
    ;
  labelVideo = cp5.addTextlabel("labelVideo")
    .setText("(Video)")
    .setPosition(1260, 550)
    ;

  // INPUTS
  cp5.addTextfield("input1")
    .setPosition(300, 420)
    .setSize(200, 20)
    .setFont(uiFont)

    ;

  cp5.addTextfield("input2")
    .setPosition(300, 460)
    .setSize(200, 20)
    .setFont(uiFont)
    ;

  // SLIDERS
  cp5.addSlider("sliderPhasing")
    .setPosition(300, 520)
    .setRange(0, 1024)
    .setValue(phasing)
    .setCaptionLabel("phasing")
    ;

  cp5.addSlider("sliderSpeed")
    .setPosition(300, 540)
    .setRange(0, 1024)
    .setValue(20)
    .setCaptionLabel("speed")
    ;

  cp5.addSlider("sliderFacetteX")
    .setPosition(300, 560)
    .setRange(0, wallW)
    .setValue(20)
    .setCaptionLabel("facetteX")
    ;

  cp5.addSlider("sliderFacetteY")
    .setPosition(300, 580)
    .setRange(0, wallH)
    .setValue(20)
    .setCaptionLabel("facetteY")
    ;

  cp5.addSlider("sliderTargetRotation")
    .setPosition(520, 520)
    .setRange(0, 360)
    .setValue(180)
    .setCaptionLabel("rotate")
    ;
  cp5.addSlider("sliderAlpha")
    .setPosition(520, 540)
    .setRange(0, 255)
    .setValue(20)
    .setCaptionLabel("alpha")
    ;

  cp5.addSlider("sliderRotation1")
    .setPosition(520, 560)
    .setRange(0.0, 0.009)
    .setValue(20)
    .setCaptionLabel("rotation1speed")
    ;

  cp5.addSlider("sliderRotation2")
    .setPosition(520, 580)
    .setRange(0.0, 0.009)
    .setValue(20)
    .setCaptionLabel("rotation2speed")
    ;

  //
  cp5.addSlider("sliderNoiseBrightness")
    .setPosition(800, 520)
    .setRange(0, 512)
    .setValue(0.01)
    .setCaptionLabel("brightness")
    ;
  cp5.addSlider("sliderXinc")
    .setPosition(800, 540)
    .setRange(0.0009, 0.1)
    .setValue(0.01)
    .setCaptionLabel("xinc")
    ;

  cp5.addSlider("sliderYinc")
    .setPosition(800, 560)
    .setRange(0.0009, 0.1)
    .setValue(0.01)
    .setCaptionLabel("yinc")
    ;

  cp5.addSlider("sliderZinc")
    .setPosition(800, 580)
    .setRange(0.0009, 1.0)
    .setValue(0.01)
    .setCaptionLabel("zinc")
    ;

  cp5.addSlider("sliderSunPos")
    .setPosition(1020, 520)
    .setRange(wallH+(sunSize*2), -(sunSize*2))
    .setValue(wallH)
    .setCaptionLabel("sunpos")
    ;
  cp5.addSlider("sliderSunSize")
    .setPosition(1020, 540)
    .setRange(0, wallW*2)
    .setValue(wallW)
    .setCaptionLabel("sunsize")
    ;
  cp5.addSlider("sliderSunBrightness")
    .setPosition(1020, 560)
    .setRange(0, 255)
    .setValue(255)
    .setCaptionLabel("sunbrightness")
    ;




  // BUTTONS
  cp5.addButton("btnPrevState")
    .setValue(0)
    .setPosition(10, 420)
    .setSize(31, 31)
    .setCaptionLabel("‹")
    .setColorCaptionLabel(white)
    ;

  cp5.addButton("btnNextState")
    .setValue(0)
    .setPosition(50, 420)
    .setSize(31, 31)
    .setCaptionLabel("›")
    .setColorCaptionLabel(white)
    ;

  ButtonBar b = cp5.addButtonBar("bar")
    .setPosition(600, 420)
    .setSize(100, 20)
    .addItems(split("1 2 3 4 5", " "))
    ;

  cp5.addButton("btnPrevDither")
    .setValue(0)
    .setPosition(600, 440)
    .setSize(31, 31)
    .setCaptionLabel("‹")
    .setColorCaptionLabel(white)
    ;

  cp5.addButton("btnNextDither")
    .setValue(0)
    .setPosition(640, 440)
    .setSize(31, 31)
    .setCaptionLabel("›")
    .setColorCaptionLabel(white)
    ;

  cp5.addButton("btnReloadAllAssets")
    .setValue(0)
    .setPosition(width-150, 420)
    .setSize(140, 31)
    .setCaptionLabel("Reload Assets")
    .setColorCaptionLabel(white)
    ;
  cp5.addButton("btnPixelate")
    .setValue(0)
    .setPosition(width-300, 420)
    .setSize(140, 31)
    .setCaptionLabel("Pixelate")
    .setColorCaptionLabel(white)
    ;
  cp5.addButton("btnPrevImg")
    .setValue(0)
    .setPosition(width-300, 450)
    .setSize(140, 31)
    .setCaptionLabel("PREV IMG")
    .setColorCaptionLabel(white)
    ;
  cp5.addButton("btnNextImg")
    .setValue(0)
    .setPosition(width-150, 450)
    .setSize(140, 31)
    .setCaptionLabel("NEXT IMG")
    .setColorCaptionLabel(white)
    ;
  cp5.addButton("btnPrevVideo")
    .setValue(0)
    .setPosition(width-300, 480)
    .setSize(140, 31)
    .setCaptionLabel("PREV VIDEO")
    .setColorCaptionLabel(white)
    ;
  cp5.addButton("btnNextVideo")
    .setValue(0)
    .setPosition(width-150, 480)
    .setSize(140, 31)
    .setCaptionLabel("NEXT VIDEO")
    .setColorCaptionLabel(white)
    ;

  // CHECKBOX
  checkboxDither = cp5.addCheckBox("checkboxDither")
    .setPosition(10, 460)
    .setSize(31, 31)
    .addItem("dither", 1)
    ;

  checkboxGrid = cp5.addCheckBox("checkboxGrid")
    .setPosition(10, 500)
    .setSize(31, 31)
    .addItem("grid", 1)
    ;

  checkboxTwoLines = cp5.addCheckBox("checkboxTwoLines")
    .setPosition(10, 540)
    .setSize(31, 31)
    .addItem("twolines", 1)
    ;

  checkboxExport = cp5.addCheckBox("checkboxExport")
    .setPosition(10, 580)
    .setSize(31, 31)
    .addItem("export", 1)
    ;

  checkboxShowCursor = cp5.addCheckBox("checkboxShowCursor")
    .setPosition(120, 460)
    .setSize(31, 31)
    .addItem("showcursor", 1)
    ;

  checkboxWaveDirection = cp5.addCheckBox("checkboxWaveDirection")
    .setPosition(120, 500)
    .setSize(31, 31)
    .addItem("wave dir", 1)
    ;

  checkboxWaveDirection = cp5.addCheckBox("checkboxBigText")
    .setPosition(120, 540)
    .setSize(31, 31)
    .addItem("bigtext", 1)
    ;

  cp5.setColorForeground(gray);
  cp5.setColorBackground(black);
  cp5.setColorActive(white);
  cp5.setFont(uiFont);



  checkboxDither.setArrayValue((ditherThis?y:n));
  checkboxGrid.setArrayValue((showGrid?y:n));
  checkboxTwoLines.setArrayValue((doubleText?y:n));
  checkboxExport.setArrayValue((export?y:n));
  checkboxShowCursor.setArrayValue((showCursor?y:n));
  labelStatemachine.setText("StateMachine:" + namedStates[state]);
  labelDitherState.setText("Dither:" + namedDithers[ditherMode]);
  cp5.getController("sliderSpeed").setValue(speed);
  cp5.getController("sliderPhasing").setValue(phasing);
  cp5.get(Textfield.class, "input1").setText(text1);
  cp5.get(Textfield.class, "input2").setText(text2);

  cpInitDone = true;
}

// CHECKBOX EVENTS
void checkboxDither(float[] a) {
  if (a[0] == 1f) ditherThis = true;
  else ditherThis = false;
}

void checkboxGrid(float[] a) {
  if (a[0] == 1f) showGrid = true;
  else showGrid = false;
}

void checkboxTwoLines(float[] a) {
  if (a[0] == 1f) doubleText = true;
  else doubleText = false;
}

void checkboxExport(float[] a) {
  if (a[0] == 1f) export = true;
  else export = false;
}

void checkboxShowCursor(float[] a) {
  if (a[0] == 1f) showCursor = true;
  else showCursor = false;
}

void checkboxWaveDirection(float[] a) {
  if (a[0] == 1f) waveDirection = true;
  else waveDirection = false;
}

void checkboxBigText(float[] a) {
  if (a[0] == 1f) bigText = true;
  else bigText = false;
}

// SLIDERS
public void sliderSpeed(float f) {
  if (!cpInitDone) return;
  speed = map(f, 0, 1024, 0.0001, 1.0);
  println("phase shifting speed = " + speed);
}

public void sliderPhasing(float f) {
  if (!cpInitDone) return;
  phasing = (int)map(f, 0, 1024, 0, 600);
  println("phasing= " + phasing);
}

public void sliderFacetteX(float f) {
  if (!cpInitDone) return;
  facetteX = f;
}

public void sliderFacetteY(float f) {
  if (!cpInitDone) return;
  facetteY = f;
}

public void sliderTargetRotation(float f) {
  if (!cpInitDone) return;
  targetRotation = f;
}
public void sliderAlpha(float f) {
  if (!cpInitDone) return;
  ditherAlpha = (int)f;
}

public void sliderRotation1(float f) {
  if (!cpInitDone) return;
  targetRotation1 = f;
}

public void sliderRotation2(float f) {
  if (!cpInitDone) return;
  targetRotation2 = f;
}

public void sliderNoiseBrightness(float f) {
  if (!cpInitDone) return;
  noiseBrightness = f;
}

public void sliderXinc(float f) {
  if (!cpInitDone) return;
  xincrement = f;
}

public void sliderYinc(float f) {
  if (!cpInitDone) return;
  yincrement = f;
}

public void sliderZinc(float f) {
  if (!cpInitDone) return;
  zincrement = f;
}

public void sliderSunPos(float f) {
  if (!cpInitDone) return;
  sunPos = f;
}

public void sliderSunSize(float f) {
  if (!cpInitDone) return;
  sunSize = f;
}

public void sliderSunBrightness(float f) {
  if (!cpInitDone) return;
  sunBrightness = f;
}

// INPUTS
public void input1(String theText) {
  if (!cpInitDone) return;
  text1 = cp5.get(Textfield.class, "input1").getText();
  println(text1);
}

public void input2(String theText) {
  if (!cpInitDone) return;
  text2 = cp5.get(Textfield.class, "input2").getText();
}


// BUTTONS
public void btnPrevState(int i) {
  if (!cpInitDone) return;
  state--;
  if (state < 0) state = namedStates.length-1;
  //mode++;
  //mode %= namedStates.length;
  println("state= " + namedStates[state]);
  labelStatemachine.setText("StateMachine:" + namedStates[state]);
}


public void btnNextState(int i) {
  if (!cpInitDone) return;
  state++;
  state %= namedStates.length;
  //mode++;
  //mode %= namedStates.length;
  println("state= " + namedStates[state]);
  labelStatemachine.setText("StateMachine:" + namedStates[state]);
}

public void btnPrevDither(int i) {
  if (!cpInitDone) return;
  ditherMode--;
  if (ditherMode == 0) ditherMode = 3;
  d.setMode(ditherMode);
  labelDitherState.setText("Dither:" + namedDithers[ditherMode]);
}


public void btnNextDither(int i) {
  if (!cpInitDone) return;
  ditherMode++;
  ditherMode %= 4;
  d.setMode(ditherMode);
  labelDitherState.setText("Dither:" + namedDithers[ditherMode]);
}

public void btnPrevImg(int i) {
  if (!cpInitDone) return;
  staticIndex--;
  if (staticIndex < 0) staticIndex = staticImports.size()-1;
  loadImage(staticIndex);
  println("Image File › " + trimPath(staticImports.get(staticIndex)));
  labelImg.setText("Img: " + trimPath(staticImports.get(staticIndex)));
}

public void btnNextImg(int i) {
  if (!cpInitDone) return;
  staticIndex++;
  staticIndex %= staticImports.size();
  loadImage(staticIndex);
  println("Image File › " + trimPath(staticImports.get(staticIndex)));
  labelImg.setText("Img: " + trimPath(staticImports.get(staticIndex)));
}

public void btnPrevVideo(int i) {
  if (!cpInitDone) return;
  videoIndex--;
  if (videoIndex < 0) videoIndex = videoImports.size()-1;
  loadMovie(videoIndex);
  println("Video File › " + trimPath(videoImports.get(videoIndex)));
  labelVideo.setText("Video: " + trimPath(videoImports.get(videoIndex)));
}

public void btnNextVideo(int i) {
  if (!cpInitDone) return;
  videoIndex++;
  videoIndex %= videoImports.size();
  loadMovie(videoIndex);
  println("Video File › " + trimPath(videoImports.get(videoIndex)));
  labelVideo.setText("Video: " + trimPath(videoImports.get(videoIndex)));
}

public void btnReloadAllAssets(int i) {
  if (!cpInitDone) return;
  println("reloading files");
  importer = new Importer("assets");
  importer.loadFiles("Static");
  if (importer.getFiles().size() > 0) {
    staticImports = importer.getFiles();
  }

  importer.loadFiles("Video");
  if (importer.getFiles().size() > 0) {
    videoImports = importer.getFiles();
  }
  staticIndex = 0;
  videoIndex = 0;
  loadImage(staticIndex);
  loadMovie(videoIndex);
}

public void btnPixelate(int i) {
  if (!cpInitDone) return;
  pixelate = !pixelate;
}

void bar(int n) {
  waveMode = n;
  println("bar clicked, item-value:", n);
}
