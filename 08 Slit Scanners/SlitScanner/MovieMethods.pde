void movieEvent(Movie m) {
  m.read();
}
int getFrame() {    
  return ceil(movie.time() * 25) - 1;
}

void setFrame(int n) {
  movie.play();
    
  // The duration of a single frame:
  float frameDuration = 1.0 / movie.frameRate;
    
  // We move to the middle of the frame by adding 0.5:
  float where = (n + 0.5) * frameDuration; 
    
  // Taking into account border effects:
  float diff = movie.duration() - where;
  if (diff < 0) {
    where += diff - 0.25 * frameDuration;
  }
    
  movie.jump(where);
  movie.pause();  
}  

int getLength() {
  return int(movie.duration() * movie.frameRate);
}