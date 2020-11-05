// -*- lsst-c++ -*-
/**
 * Lib2
 * 
 * See COPYRIGHT file at the top of the source tree.
 * Copyright © [year] <Copyright Owner>.
*/

#include <Arduino.h>
#include "Lib2.h"

Lib2::Lib2(boolean value) {
    this->value = value;
}

void Lib2::echo() {
    return this->value
}
