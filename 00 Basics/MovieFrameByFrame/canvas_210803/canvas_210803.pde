/**
 * Frames 
 * by Andres Colubri. 
 * 
 * Moves through the video one frame at the time by using the
 * arrow keys. It estimates the frame counts using the framerate
 * of the movie file, so it might not be exact in some cases.
 */
 
import processing.video.*;
 
Movie mov;
int newFrame = 0;
 
void setup() {
  size(600, 600, P2D);
  frameRate(60);
  surface.setLocation(0, 0);
  background(0);
  mov = new Movie(this, "bubbl3.mp4");  
 
  // Pausing the video at the first frame. 
  mov.play();
  mov.jump(0);
  mov.pause();
}
 
void movieEvent(Movie m) {
  m.read();
}
 
void draw() {
  background(0);
  image(mov, 0, 0, width, height);
  //fill(255);
  //text(getFrame() + " / " + (getLength() - 1), 10, 30);
  //int f = ceil (map(mouseX,0,width,1,getLength()));
  setFrame(newFrame);
  newFrame++;
  newFrame %= getLength();
  println(newFrame);
}
 
//void keyPressed() {
//  if (key == CODED) {
//    if (keyCode == LEFT) {
//      if (0 < newFrame) newFrame--; 
//    } else if (keyCode == RIGHT) {
//      if (newFrame < getLength() - 1) newFrame++;
//    }
//  } 
//  setFrame(newFrame);  
//}
 
int getFrame() {    
  return ceil(mov.time() * 30) - 1;
}
 
void setFrame(int n) {
  mov.play();
 
  // The duration of a single frame:
  float frameDuration = 1.0 / mov.frameRate;
 
  // We move to the middle of the frame by adding 0.5:
  float where = (n + 0.5) * frameDuration; 
 
  // Taking into account border effects:
  float diff = mov.duration() - where;
  if (diff < 0) {
    where += diff - 0.25 * frameDuration;
  }
 
  mov.jump(where);
  mov.pause();  
}  
 
int getLength() {
  return int(mov.duration() * mov.frameRate);
}
