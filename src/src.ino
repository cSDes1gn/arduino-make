// -*- lsst-c++ -*-
/**
 * Sample src.ino file (entry point)
 * 
 * @file src.ino
 *
 * @brief Sample source file entry point demonstrating local include calls.
 *
 * @author <Name>
 * Contact: <Email>
 * 
 * Copyright © [year] <Copyright Owner>.
 */
// #include <SoftwareSerial.h>
#include <Lib1.h>
#include <Lib2.h>
#include <Arduino.h>

Lib1 lb1("Hello from Lib1!");
Lib2 lb2("Hello from Lib2!");

void setup() {
  // put your setup code here, to run once:
  pinMode(PC13, OUTPUT);
}

void loop() {
  // put your main code here, to run repeatedly:
  digitalWrite(PC13, HIGH);
  delay(1000);
  digitalWrite(PC13, LOW);
  delay(1000);
}