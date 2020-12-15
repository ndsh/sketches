Importer importer;

void setup() {
  importer = new Importer("../../Assets");
  println(importer.getFiles());
  if(importer.getFiles().size() > 0) {
    PImage p = loadImage(importer.getFiles().get(0));
    image(p, 0, 0);
  }
  
}

// Nothing is drawn in this program and the draw() doesn't loop because
// of the noLoop() in setup()
void draw() {
}
