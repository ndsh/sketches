/*
oscp5 examples

oscp5Message
oscp5broadcaster
oscp5broadcastClient
*/

import javax.imageio.*;
import java.awt.image.*; 
import java.io.*;

// FSM
static final int IDLE = 0;
static final int SEND = 1;
static final int WAIT = 2;

void setup() {
  
}

// op.setDatagramSize(9220);

void draw() {
  
  switch(state) {
    case IDLE:
    break;

    case SEND:
    break;

    case WAIT:
    break;
  }

}

byte[] encodeIMG(PImage img){
  BufferedImage bimg = new BufferedImage( img_edit.width,img_edit.height, BufferedImage.TYPE_INT_RGB );

  // Transfer pixels from localFrame to the BufferedImage
  img.loadPixels();
  bimg.setRGB( 0, 0, img.width, img.height, img.pixels, 0, img.width);

  // Need these output streams to get image as bytes for UDP communication
  ByteArrayOutputStream baStream  = new ByteArrayOutputStream();
  BufferedOutputStream bos    = new BufferedOutputStream(baStream);

  // Turn the BufferedImage into a JPG and put it in the BufferedOutputStream
  // Requires try/catch
  try {
    ImageIO.write(bimg, "jpg", bos);
  } 
  catch (IOException e) {
    e.printStackTrace();
  }
  byte[] b = baStream.toByteArray();
  return b;
}