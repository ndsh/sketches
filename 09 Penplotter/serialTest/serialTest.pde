import processing.serial.*;

Serial myPort;
String val;

void setup() {
  size(200, 200);
  surface.setLocation(0, 0);
  String portName = Serial.list()[3];
  println(Serial.list());
  myPort = new Serial(this, portName, 115200);
}

void draw() {
  background(0);
    if ( myPort.available() > 0) {  // If data is available,
      val = myPort.readStringUntil('\n');         // read it and store it in val
      println(val); //print it out in the console
    } 


  if(mousePressed == true) {
    background(255);
    myPort.write("G90\nG20\nG00 X0.000 Y0.000 Z0.000\n");
    //myPort.write("$H\n");
  }
}
