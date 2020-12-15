class colorDude {
	int bg_h = 0;
	int fg1_h = 180;
	int fg2_h = 180;
	int s = 50;
	int b = 100;
  int mode = 1;
  
  public colorDude () {
    // expression
    backgroundColor = color(bg_h,s,b);
    foregroundColor = color(fg1_h,s,b);
    foregroundColor2 = color(fg2_h,s,b);
  }

  void spinWheel(int colorWheel) {
    bg_h = colorWheel;
  }  

  void makePretty(int h, int m, int s) {
  	bg_h = (bg_h);
  	s = int(map(s,0,59,0,100));
    if(h >= 6 && h <= 11) {
      mode = 1;
    } else if(h >= 12 && h <= 17) {
      mode = 2;
    } else if(h >= 18 && h <= 23) {
      mode = 3;
    }
  	// b = (b+1)%100;
  	// complement();
  	// splitComplement();
    if(mode == 1) triadic();
    else if(mode == 2) complement();
    else if(mode == 3) splitComplement();
    else analogous();
  	backgroundColor = color(bg_h,s,b);
  	foregroundColor = color(fg1_h,s,b);
  	foregroundColor2 = color(fg2_h,s,b);
  }

  void triadic() {
    fg1_h = (bg_h+120)%360;
    fg2_h = (bg_h+240)%360;
  }

  void complement() {
  	fg1_h = (bg_h+180)%360;
  	fg2_h = fg1_h;
  }

  void splitComplement() {
    fg1_h = (bg_h+150)%360;
    fg2_h = (bg_h+210)%360;
  }

  void analogous() {
    fg1_h = (bg_h+30)%360;
    fg2_h = (bg_h+330)%360;
  }
}