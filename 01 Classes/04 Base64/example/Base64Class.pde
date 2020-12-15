/*
 
 
  +-----------------+-----------------+---------------------+
  +                 + Class           + Date: 21.11.17      +
  +-----------------+-----------------+---------------------+
  +                 + Base64Wrapper   + Julian Hespenheide  +
  +-----------------+-----------------+---------------------+
 
    
*/

import java.nio.*;
import javax.xml.bind.DatatypeConverter;

class Base64Wrapper {
  
  /*
  * - convert a Pimage to a byte array
  * - byte array to base64 string
  * - base64 to byte array
  * - byte array to PImage
  */
  
  public Base64Wrapper() {
  }
  
  byte[] toByteArray(PImage img) {
    img.loadPixels();   
    byte[] bufferedData = from_pixels_to_byte_array(img.pixels);
    bufferedData = concat(bufferedData, to_aRGB_array(img.width));
    bufferedData = concat(bufferedData, to_aRGB_array(img.height));
    println(img.pixels.length + ", "+bufferedData.length);

    return bufferedData;
  }
  
  PImage toImage(byte[] b) {
    if (b.length < 8) return createImage(20,20,RGB);
    int l = b.length;
    int w = to_color(b[l-8], b[l-7], b[l-6], b[l-5]);
    int h = to_color(b[l-4], b[l-3], b[l-2], b[l-1]);
    //println("width: "+w+", height: "+h);
    b = subset(b, 0, l-8);
    
    PImage img = createImage(w, h, ARGB);
    color[] p = from_byte_array_to_pixels(b);
    img.loadPixels();
    img.pixels = p;
    img.updatePixels();
    return img;
  }
  
  String encode(byte[] b) {
    String b64 = DatatypeConverter.printBase64Binary(b);
    String[] o = {b64};
    return b64;
  }
  
  byte[] decode(String b64) {
    byte[] origB = DatatypeConverter.parseBase64Binary(b64);
 
    return origB;
  }
  
  byte[] from_pixels_to_byte_array(final color[] p, byte... t) {
    final byte[] argb = new byte[Integer.BYTES];
    final int len = p.length, size = len<<2;
   
    if (t == null || t.length < size)  t = new byte[size];
   
    for (int i = 0; i < size; i += Integer.BYTES) {
      t[i] = to_aRGB_array(p[i>>2], argb)[0];
      t[i+1] = argb[1];
      t[i+2] = argb[2];
      t[i+3] = argb[3];
    }
   
    return t;
  }  
  
  color[] from_byte_array_to_pixels(final byte[] b, color... t) {
    final int len = b.length, size = len>>2;
    //println(len+", "+size);
   
    if (t == null || t.length < size)  t = new color[size];
   
    for (int i = 0; i < len; i += Integer.BYTES) {
      t[i/4] = to_color(b[i], b[i+1], b[i+2], b[i+3]);
    }
   
    return t;
  }  
   
  byte[] to_aRGB_array(final color c, final byte... t) {
    
    final byte a = (byte) (c >>> 030);
    final byte r = (byte) (c >>  020 & 0xff);
    final byte g = (byte) (c >>  010 & 0xff);
    final byte b = (byte) (c         & 0xff);
      
    if (t == null || t.length < Integer.BYTES)  return new byte[] {a, r, g, b};
   
    t[0] = a;
    t[1] = r;
    t[2] = g;
    t[3] = b;
   
    return t;
  }
  
  color to_color( byte a, byte r, byte g, byte b) {
    
    int _a = int(a) << 24;  // Binary: 11111111000000000000000000000000
    int _r = int(r) << 16;  // Binary: 00000000110011000000000000000000
    int _g = int(g) << 8;   // Binary: 00000000000000001100110000000000
    int _b = int(b);
    return _a | _r | _g | _b;
  }
  
  
}
