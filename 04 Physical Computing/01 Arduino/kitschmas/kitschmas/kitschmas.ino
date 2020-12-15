#include <RunningMedian.h>
#include <Adafruit_NeoPixel.h>
#ifdef __AVR__
  #include <avr/power.h>
#endif

#define steps 128
#define PIXELSPIN   6
#define NUMPIXELS   20
#define CALIBRATIONTIME 20000

RunningMedian samples = RunningMedian(333);
Adafruit_NeoPixel pixels = Adafruit_NeoPixel(NUMPIXELS, PIXELSPIN, NEO_GRB + NEO_KHZ800);

float values[steps];
float alpha;
int maxPos, maxVal;
int findMax, findMin;
int delayval = 500; // delay for half a second
int ledValue[60];
int boredLedBrightness = 0;
bool boredDirection = true;

unsigned long pixelsInterval=50;  // the time we need to wait
unsigned long boredInterval=10000;
unsigned long boredPreviousMillis=0;
unsigned long colorWipePreviousMillis=0;
unsigned long theaterChasePreviousMillis=0;
unsigned long theaterChaseRainbowPreviousMillis=0;
unsigned long rainbowPreviousMillis=0;
unsigned long rainbowCyclesPreviousMillis=0;

int theaterChaseQ = 0;
int theaterChaseRainbowQ = 0;
int theaterChaseRainbowCycles = 0;
int rainbowCycles = 0;
int rainbowCycleCycles = 0;

uint32_t currentColor;// current Color in case we need it
uint16_t currentPixel = 0;// what pixel are we operating on

void setup() {
  currentColor = pixels.Color(255,0,0);
  currentPixel = 0;
  
  findMin = 2000;
  findMax = 0;
  pinMode (9, OUTPUT); 
  TCCR1A = 0;
  TCCR1B = 0;
  TCCR1A |= (1 << COM1A0);       
  TCCR1B |= (1 << WGM12);        
  Serial.begin(57600);

  // This is for Trinket 5V 16MHz, you can remove these three lines if you are not using a Trinket
  #if defined (__AVR_ATtiny85__)
    if (F_CPU == 16000000) clock_prescale_set(clock_div_1);
  #endif
  // End of trinket special code
  for(int i = 0; i<NUMPIXELS; i++) {
    ledValue[i] = 0;
  }
  pixels.begin(); // This initializes the NeoPixel library.
  
  // start-up sequence
    for(int i = 0; i<NUMPIXELS; i++) {
      pixels.setPixelColor(i, pixels.Color(123,123,123));
      pixels.show(); // This sends the updated pixel color to the hardware.
    }

    // alle pixel an, 1 by 1
    for(int i = 0; i<NUMPIXELS; i++) {
      pixels.setPixelColor(i, pixels.Color(0,0,0));
      pixels.show(); // This sends the updated pixel color to the hardware.
    }

}

void loop () {
  if (Serial.available()) {
    alpha = (float)Serial.read() / 255.0f;
  }
  maxPos = 0;
  maxVal = 0;
  for (int i = 0; i < steps; i++) {
    TCCR1B &= 0xFE;                       // turns off timer
    TCNT1 = 0;                            // resets timer counter register
    OCR1A = i;                            // sets new frequency step
    TCCR1B |= 0x01;                       // turns on timer
    float curVal = analogRead(0);
    values[i] = values[i] * alpha + curVal * (1 - alpha);  // exponential moving avg
    if (values[i] > maxVal) {                              // finds the signal peak
      maxVal = values[i];
      maxPos = i;
    }
  }
  samples.add(maxVal);
  int m = samples.getMedian();
  int h = samples.getHighest();
  int l = samples.getLowest();

  if(h > findMax) findMax = h;
 if(l <= findMin) findMin = l;
  
  
  float normalized = map(m, findMin, findMax, 0, 100);
  Serial.println(normalized);
  // Serial.print("current pos: ");
  // Serial.print(maxPos);
  // Serial.println("/128");
  if(normalized >= 35) {
    if ((unsigned long)(millis() - boredPreviousMillis) >= boredInterval) {
        for(int i = 0; i<NUMPIXELS; i++) {
          ledValue[i] = boredLedBrightness;
          pixels.setPixelColor(i, pixels.Color(ledValue[i],ledValue[i],ledValue[i]));
        }
      pixels.show(); // This sends the updated pixel color to the hardware.
      if(boredDirection) boredLedBrightness++;
      else boredLedBrightness--;
      if(boredLedBrightness > 255) {
        boredDirection = false;
      } else if(boredLedBrightness <= 0) boredDirection = true;
        
    } // methode zum runterfaden alle werte nach einer animation!
  } else {
    if(millis() >= CALIBRATIONTIME) {
      boredPreviousMillis = millis();
      if(normalized < 35 && normalized >= 32) {
        if ((unsigned long)(millis() - colorWipePreviousMillis) >= pixelsInterval) {
          colorWipePreviousMillis = millis();
          colorWipe(pixels.Color(0,255,125));
        }
      } else if(normalized < 32 && normalized >= 29) {
        if ((unsigned long)(millis() - theaterChasePreviousMillis) >= pixelsInterval) {
          theaterChasePreviousMillis = millis();
          theaterChase(pixels.Color(127, 127, 127)); // White
        }
      } else if(normalized < 29 && normalized >= 26) {
        if ((unsigned long)(millis() - theaterChaseRainbowPreviousMillis) >= pixelsInterval) {
          theaterChaseRainbowPreviousMillis = millis();
          theaterChaseRainbow();
        }
      } else if(normalized < 26 && normalized >= 23) {
        if ((unsigned long)(millis() - rainbowPreviousMillis) >= pixelsInterval) {
          rainbowPreviousMillis = millis();
          rainbow();
        }
      } else {
        if ((unsigned long)(millis() - rainbowCyclesPreviousMillis) >= pixelsInterval) {
            rainbowCyclesPreviousMillis = millis();
            rainbowCycle();
        }
      }
      
    }
  }
}

// Fill the dots one after the other with a color
void colorWipe(uint32_t c){
  pixels.setPixelColor(currentPixel,c);
  pixels.show();
  currentPixel++;
  if(currentPixel == NUMPIXELS) currentPixel = 0;
}

void rainbow() {
  for(uint16_t i=0; i<pixels.numPixels(); i++) {
    pixels.setPixelColor(i, Wheel((i+rainbowCycles) & 255));
  }
  pixels.show();
  rainbowCycles++;
  if(rainbowCycles >= 256) rainbowCycles = 0;
}

// Slightly different, this makes the rainbow equally distributed throughout
void rainbowCycle() {
  for(uint16_t i=0; i< pixels.numPixels(); i++) pixels.setPixelColor(i, Wheel(((i * 256 / pixels.numPixels()) + rainbowCycleCycles) & 255));
  pixels.show();
  rainbowCycleCycles++;
  if(rainbowCycleCycles >= 256*5) rainbowCycleCycles = 0;
}

//Theatre-style crawling lights.
void theaterChase(uint32_t c) {
  for (int i=0; i < pixels.numPixels(); i=i+3) pixels.setPixelColor(i+theaterChaseQ, c);    //turn every third pixel on
  pixels.show();
  for (int i=0; i < pixels.numPixels(); i=i+3) pixels.setPixelColor(i+theaterChaseQ, 0);        //turn every third pixel off
  theaterChaseQ++;
  if(theaterChaseQ >= 3) theaterChaseQ = 0;
}


//Theatre-style crawling lights with rainbow effect
void theaterChaseRainbow() {
  for (int i=0; i < pixels.numPixels(); i=i+3) pixels.setPixelColor(i+theaterChaseRainbowQ, Wheel( (i+theaterChaseRainbowCycles) % 255));    //turn every third pixel on   
  pixels.show();
  for (int i=0; i < pixels.numPixels(); i=i+3) pixels.setPixelColor(i+theaterChaseRainbowQ, 0);        //turn every third pixel off        
  theaterChaseRainbowQ++;
  theaterChaseRainbowCycles++;
  if(theaterChaseRainbowQ >= 3) theaterChaseRainbowQ = 0;
  if(theaterChaseRainbowCycles >= 256) theaterChaseRainbowCycles = 0;
}

// Input a value 0 to 255 to get a color value.
// The colours are a transition r - g - b - back to r.
uint32_t Wheel(byte WheelPos) {
  WheelPos = 255 - WheelPos;
  if(WheelPos < 85) {
    return pixels.Color(255 - WheelPos * 3, 0, WheelPos * 3);
  }
  if(WheelPos < 170) {
    WheelPos -= 85;
    return pixels.Color(0, WheelPos * 3, 255 - WheelPos * 3);
  }
  WheelPos -= 170;
  return pixels.Color(WheelPos * 3, 255 - WheelPos * 3, 0);
}
