#include <Arduino.h>
#include "SerialWrapper.h"

/* single line, no feed */
void SerialPrint(bool b){
  #if defined (__AVR_ATtiny85__)
  #else
    Serial.print(b);
  #endif
}
void SerialPrint(char c){
  #if defined (__AVR_ATtiny85__)
  #else
    Serial.print(c);
  #endif
}
void SerialPrint(unsigned char c){
  #if defined (__AVR_ATtiny85__)
  #else
    Serial.print(c);
  #endif
}
void SerialPrint(int i){
  #if defined (__AVR_ATtiny85__)
  #else
    Serial.print(i);
  #endif
}
void SerialPrint(unsigned i){
  #if defined (__AVR_ATtiny85__)
  #else
    Serial.print(i);
  #endif
}
void SerialPrint(long l){
  #if defined (__AVR_ATtiny85__)
  #else
    Serial.print(l);
  #endif
}
void SerialPrint(unsigned long l){
  #if defined (__AVR_ATtiny85__)
  #else
    Serial.print(l);
  #endif
}
void SerialPrint(short s){
  #if defined (__AVR_ATtiny85__)
  #else
    Serial.print(s);
  #endif
}
void SerialPrint(float f){
  #if defined (__AVR_ATtiny85__)
  #else
    Serial.print(f);
  #endif
}
void SerialPrint(double d){
  #if defined (__AVR_ATtiny85__)
  #else
    Serial.print(d);
  #endif
}
void SerialPrint(String s){
  #if defined (__AVR_ATtiny85__)
  #else
    Serial.print(s);
  #endif
}

/* single line, new feed */
void SerialPrintln(bool b){
  #if defined (__AVR_ATtiny85__)
  #else
    Serial.println(b);
  #endif
}
void SerialPrintln(char c){
  #if defined (__AVR_ATtiny85__)
  #else
    Serial.println(c);
  #endif
}
void SerialPrintln(unsigned char c){
  #if defined (__AVR_ATtiny85__)
  #else
    Serial.println(c);
  #endif
}
void SerialPrintln(int i){
  #if defined (__AVR_ATtiny85__)
  #else
    Serial.println(i);
  #endif
}
void SerialPrintln(unsigned i){
  #if defined (__AVR_ATtiny85__)
  #else
    Serial.println(i);
  #endif
}
void SerialPrintln(long l){
  #if defined (__AVR_ATtiny85__)
  #else
    Serial.println(l);
  #endif
}
void SerialPrintln(unsigned long l){
  #if defined (__AVR_ATtiny85__)
  #else
    Serial.println(l);
  #endif
}
void SerialPrintln(short s){
  #if defined (__AVR_ATtiny85__)
  #else
    Serial.println(s);
  #endif
}
void SerialPrintln(float f){
  #if defined (__AVR_ATtiny85__)
  #else
    Serial.println(f);
  #endif
}
void SerialPrintln(double d){
  #if defined (__AVR_ATtiny85__)
  #else
    Serial.println(d);
  #endif
}
void SerialPrintln(String s){
  #if defined (__AVR_ATtiny85__)
  #else
    Serial.println(s);
  #endif
}