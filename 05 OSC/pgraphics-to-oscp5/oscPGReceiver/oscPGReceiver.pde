import javax.imageio.*;
import java.awt.image.*; 
import java.io.*;

// FSM
static final int IDLE = 0;
static final int RECEIVE = 1;
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

PImage decodeIMG(byte[] b){
  //Read incoming data into a ByteArrayInputStream
    ByteArrayInputStream bais = new ByteArrayInputStream( b );
    // We need to unpack JPG and put it in the PImage video
    PImage img = createImage(240, 240, RGB);
    img.loadPixels();
    try {
      // Make a BufferedImage out of the incoming bytes
      BufferedImage bimg = ImageIO.read(bais);
      // Put the pixels into the video PImage
      bimg.getRGB(0, 0, img.width, img.height, img.pixels, 0, img.width);
    } catch (Exception e) {
      e.printStackTrace();
    }
    img.updatePixels(); // Update the PImage pixels
    return img;
}