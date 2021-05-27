void keyPressed() {
  canvas.flip();
}
/*
void movieEvent(Movie m) {
  m.read();
  change = true;
}*/

String leadingZero(int i) {
  String s = ""+i;
  if(i < 10) return s = "0"+s;
  else return s;
}
