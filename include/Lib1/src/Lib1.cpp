// -*- lsst-c++ -*-
/**
 * Lib1
 * 
 * See COPYRIGHT file at the top of the source tree.
 * Copyright © [year] <Copyright Owner>.
*/

#include <Arduino.h>
#include "Lib1.h"

Lib1::Lib1(int num) {
    this->num = num;
}

void Lib1::echo() {
    return this->num
}
