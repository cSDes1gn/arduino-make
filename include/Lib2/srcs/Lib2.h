// -*- lsst-c++ -*-
/**
 * Lib2
 * 
 * See COPYRIGHT file at the top of the source tree.
 * Copyright © [year] <Copyright Owner>.
 * 
 * @file Lib2.h
 *
 * @brief This is a sample library
 *
 * @ingroup Lib2
 *
 * @author <Name>
 * Contact: <Email>
 */

#ifndef INCLUDE_LIB1_SRC_LIB1_H_
#define INCLUDE_LIB1_SRC_LIB1_H_
#include <Arduino.h>
class Lib2 {
 public:
  explicit Lib2(String msg);
  String echo();

 private:
  String msg;
};
#endif  // INCLUDE_LIB1_SRC_LIB1_H_
