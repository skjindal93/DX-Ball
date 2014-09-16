////////////////////////////////////////////////////////////////////////////////
//   ____  ____   
//  /   /\/   /  
// /___/  \  /   
// \   \   \/  
//  \   \        Copyright (c) 2003-2004 Xilinx, Inc.
//  /   /        All Right Reserved. 
// /---/   /\     
// \   \  /  \  
//  \___\/\___\
////////////////////////////////////////////////////////////////////////////////

#ifndef H_Work_array_b_H
#define H_Work_array_b_H

#ifdef __MINGW32__
#include "xsimMinGW.h"
#else
#include "xsim.h"
#endif


#include "ieee/numeric_std/numeric_std.h"
#include "ieee/std_logic_1164/std_logic_1164.h"

class Work_array_b: public HSim__s6 {
public:
  HSimArrayType Arrbase;
  HSimArrayType Arr;
  Work_array_b(const HSimString &name);
  ~Work_array_b();
};

extern Work_array_b *WorkArray_b;

#endif
