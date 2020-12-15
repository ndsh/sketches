/*
 
 
  +-----------------+-----------------+---------------------+
  +                 + Module          + Date: 21.11.17      +
  +-----------------+-----------------+---------------------+
  +                 + Base64Wrapper   + Julian Hespenheide  +
  +-----------------+-----------------+---------------------+
 
    
*/

Base64Wrapper b64;
 
void setup() {
  size(500, 500);
  background(0);
  
  b64 = new Base64Wrapper();
  
  // load an image
  PImage p = loadImage("lucy.jpg");
  
  // it is necessary to convert to a byte array first before we continue with
  // the String representation of the PImage
  byte[] b = b64.toByteArray(p);
  String s = b64.encode(b);
  
  // this String could theoretically be send over OSC, HTTP or saved to a database!
  println(s);
  
  
  // reverse direction, for times when you receive a base64_encoded image (eg. from an API or a database, OSC, HTTP, etc. pp)
  p = b64.toImage(b64.decode(s));
  image(p, 0, 0);
  
  // cool.
}

void draw() {
}
