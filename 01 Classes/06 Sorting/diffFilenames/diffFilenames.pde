Importer importer;


void setup() {
  size(90, 90);
  surface.setLocation(0,0);
  
  
  importer = new Importer("/Volumes/Work/180 MHK/18003 MHK Ausstellungsgrafik/HLM");
  String[] folderLeft = importer.listFileNames("/Volumes/Work/180 MHK/18003 MHK Ausstellungsgrafik/HLM/AlleBildDatenKopie/_JPGTIFF");
  String[] folderRight = importer.listFileNames("/Volumes/Work/180 MHK/18003 MHK Ausstellungsgrafik/HLM/AlleBildDatenKopie/_JPGTIFF/_EXPORT_PDF_600px");
  
  StringList left = new StringList();
  StringList right = new StringList();


  
  println(folderLeft.length);
  println(folderRight.length);
  
  String[] split = null;
  File file = null;
  for(int i = 0; i<folderLeft.length; i++) {
    file = new File(folderLeft[i]);
    split = split(file.getName(), ".");
    if(split.length > 1) {
      left.append(split[0]);
    }
  }
  
  for(int i = 0; i<folderRight.length; i++) {
    file = new File(folderRight[i]);
    split = split(file.getName(), ".");
    if(split.length > 1) {
      right.append(split[0]);
    }
  }
  int c = 0;
  for(int i = 0; i<left.size(); i++) {
    for(int j = 0; j<right.size(); j++) {
      c++;
      if(left.get(i).equals(right.get(j))) {
        left.set(i, "");
        right.set(j, "");
      }
    }
  }
  for (int i = left.size() - 1; i >= 0; i--) {
    if(left.get(i).equals("")) left.remove(i);
  }
  
  for (int i = right.size() - 1; i >= 0; i--) {
    if(right.get(i).equals("")) right.remove(i);
  }
 
  //println(c);
  println("left:");
  for(int i = 0; i<left.size(); i++) {
    println("\t" + left.get(i));
  }
  println("right:");
  for(int i = 0; i<right.size(); i++) {
    println("\t" + right.get(i));
  }
  
}

// Nothing is drawn in this program and the draw() doesn't loop because
// of the noLoop() in setup()
void draw() {
}
