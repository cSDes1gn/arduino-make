// -*- lsst-c++ -*-
/**
 * Sample src.ino file (entry point)
 * 
 * @file src.ino
 *
 * @brief Sample source file
 *
 * @author <Name>
 * Contact: <Email>
 * 
 * Copyright © [year] <Copyright Owner>.
 */
#include <SoftwareSerial.h>
#include <Lib1.h>
#include <Lib2.h>

void setup() {
    Serial.begin(9600);
}

void loop() {
    Serial.println("Hello World!")
    delay(1000);
}
