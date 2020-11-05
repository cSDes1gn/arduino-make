// -*- lsst-c++ -*-
/**
 * Sample src.ino
 * 
 * @file src.ino
 *
 * @brief Sample source file
 *
 * @author Christian Sargusingh
 * Contact: christian@leapsystems.online
 */
#include <SoftwareSerial.h>

void setup() {
    Serial.begin(9600);
}

void loop() {
    Serial.println("Hello World!")
    delay(1000);
}
