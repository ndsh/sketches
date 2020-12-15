PFont font;
JSONArray table;
JSONObject valueObject;
JSONArray values;
int iterator = 0;
int row = 1;
int page = 0;

import processing.pdf.*;

boolean eop = false; // end of page

void setup() {
  //size(3508 , 2480);
  //size(20, 20);
  //size(1123, 794);
  size(1754, 1240, PDF, "filename.pdf");
  frameRate(24);
  //font = loadFont("Theinhardt-Regular-20.vlw");
  font = createFont("Theinhardt", 14);
  textFont(font);
  
  table = loadJSONArray("boerse.json");
  valueObject = table.getJSONObject(2);
  values = valueObject.getJSONArray("data");
 
  fill(0);
   
  background(255); 

}

void draw() {
  PGraphicsPDF pdf = (PGraphicsPDF) g;
  background(255);
  if(iterator < values.size()) {
    for(int i = 1; i<=60; i++) {
      if(iterator < values.size()) {
        JSONObject row = values.getJSONObject(iterator);
        String set1 = row.getString("set1");
        String set2 = row.getString("set2");
        String ts = row.getString("TIMESTAMP");
        String in1 = row.getString("input1");
        String in2 = row.getString("input2");
        text(ts, 0, i*20);
        text(set1, 150, i*20);
        text(in1, 350, i*20);
        text(set2, 750, i*20);
        text(in2, 1100, i*20);
      }
      iterator++;
      
    }
    pdf.nextPage();
    page++;
    println("rendered page #" + page);
    
  } else {
    //endRecord();
    exit();
  }
  //endRecord();
  //exit();
  /*
  
  */
  
}
