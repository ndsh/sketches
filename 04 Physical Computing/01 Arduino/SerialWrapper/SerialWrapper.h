#ifndef SerialWrapper_H
#define SerialWrapper_H

#include <Arduino.h>

void SerialPrint(bool b);
void SerialPrint(char c);
void SerialPrint(unsigned char c);
void SerialPrint(int i);
void SerialPrint(unsigned i);
void SerialPrint(long l);
void SerialPrint(unsigned long l);
void SerialPrint(short s);
void SerialPrint(float f);
void SerialPrint(double d);
void SerialPrint(String s);

void SerialPrintln(bool b);
void SerialPrintln(char c);
void SerialPrintln(unsigned char c);
void SerialPrintln(int i);
void SerialPrintln(unsigned i);
void SerialPrintln(long l);
void SerialPrintln(unsigned long l);
void SerialPrintln(short s);
void SerialPrintln(float f);
void SerialPrintln(double d);
void SerialPrintln(String s);
	
#endif

