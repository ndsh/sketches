/*
 +
 + S L I T S C A N N E R
 + > julian-h.de
 +
 */
import processing.video.*;

Scanner mScanner;
Movie movie;
PGraphics pg;
int newFrame = 0;

void setup() {
  size(1280,720);
  pg = createGraphics(width, height);
  mScanner = new Scanner(0);
  movie = new Movie(this, "slowmo.mov");
  movie.play();
  movie.jump(0);
  movie.pause();
  movie.volume(0);
}

void draw() {
  if (newFrame < getLength() - 1) newFrame++;
  else newFrame = 0;
  setFrame(newFrame);
  pg.beginDraw();
  pg.image(movie, 0, 0, width, height);
  pg.endDraw();
  
  mScanner.scan();
  mScanner.draw();
}



void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      mScanner.changeDirection(2);
    } else if (keyCode == DOWN) {
      mScanner.changeDirection(3);
    } else if (keyCode == LEFT) {
      mScanner.changeDirection(1);
    } else if (keyCode == RIGHT) {
      mScanner.changeDirection(0);
    }
  }
}