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

#ifndef H_Work_divide_H
#define H_Work_divide_H

#ifdef __MINGW32__
#include "xsimMinGW.h"
#else
#include "xsim.h"
#endif


#include "ieee/std_logic_unsigned/std_logic_unsigned.h"
#include "ieee/std_logic_1164/std_logic_1164.h"

class Work_divide: public HSim__s6 {
public:
/* subprogram name divide */
char *Gh(HSimConstraints *reConstr, const char *Eb, const HSimConstraints *constrEb, const char *Ed, const HSimConstraints *constrEd);

public:

public:
  Work_divide(const HSimString &name);
  ~Work_divide();
};

extern Work_divide *WorkDivide;

#endif
