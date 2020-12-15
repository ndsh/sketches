Exporter exporter;
String appName = "exporter-app";
int FPS = 30;

void setup() {
  size(200, 200);
  frameRate(FPS);
  exporter = new Exporter(FPS);
  exporter.setPath(appName);
  exporter.setLimit(10);
  //exporter.setMinutes(1);
  
}

void draw() {
  background(0);
  exporter.export();
  
}
