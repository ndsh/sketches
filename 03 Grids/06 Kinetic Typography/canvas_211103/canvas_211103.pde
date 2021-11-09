/*
  cp5 input fields and sliders
 */


void setup() {
  size(1560, 608, P2D);
  frameRate(60);
  surface.setLocation(0, 0);

  font1 = createFont("assets/Standard0757.ttf", 192*2);
  font2 = createFont("assets/Standard0757.ttf", 192*1);
  uiFont = loadFont("assets/Theinhardt-Medium-16.vlw");

  p = loadImage("medusa.jpg");

  pg = createGraphics(wallW, wallH, P2D);
  pg.beginDraw();
  pg.textAlign(CENTER, BASELINE);
  pg.endDraw();

  pg2 = createGraphics(wallW, wallH, P2D);
  pg2.beginDraw();
  pg2.textAlign(CENTER, CENTER);
  pg2.noStroke();
  pg2.background(0, 255, 255);
  pg2.ellipse(pg.width/2, pg.height/2, 20, 20);
  pg2.endDraw();

  pg4 = createGraphics(wallW, wallH, P2D);
  pg4.beginDraw();
  pg4.endDraw();

  pgTemp = createGraphics(wallW, wallH, P2D);
  pgTemp.beginDraw();
  pgTemp.endDraw();

  d = new Dither();
  d.setCanvas(1560, 408);
  d.setMode(0);

  tileW = int(wallW/tilesX);
  tileH = int(wallH/tilesY);

  initCP5();

  for (int i = 0; i < drops.length; i++) { // we create the drops
    drops[i] = new Drop();
  }

  for (int i = 0; i < flakes.length; i++) { // we create the drops
    flakes[i] = new Flake();
  }

  // Importer Class
  importer = new Importer("assets");
  importer.loadFiles("Static");
  if (importer.getFiles().size() > 0) {
    staticImports = importer.getFiles();
  }

  importer.loadFiles("Video");
  if (importer.getFiles().size() > 0) {
    videoImports = importer.getFiles();
  }
  loadImage(staticIndex);
  loadMovie(videoIndex);

  dots = new ArrayList<Dot>();
  for (int y = 0; y<tilesY; y++) {
    for (int x = 0; x<tilesX; x++) {
      dots.add(new Dot(x*tileW, y*tileH, tileW));
    }
  }
  
  for (int i = 0; i<dots.size(); i++) {
    dots.get(i).setMode(1);
    dots.get(i).setBrightness(0);
  }
  
}

void draw() {
  background(0);

  /* interessanter effekt
   if(millis() - timestamp > interval) {
   timestamp = millis();
   tilesX++;
   if(tilesX >= 65) tilesX = 1;
   }
   */
  stateMachine(state);
  grid();

  if (!showCursor && mouseY > 408) cursor();
  else if (!showCursor && mouseY <= 408) noCursor();
}
