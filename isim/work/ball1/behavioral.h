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

#ifndef H_Work_ball1_behavioral_H
#define H_Work_ball1_behavioral_H
#ifdef __MINGW32__
#include "xsimMinGW.h"
#else
#include "xsim.h"
#endif


class Work_ball1_behavioral: public HSim__s6 {
public:

HSimConstraints *c3;
  char *t4;
HSimConstraints *c5;
  char *t6;
    HSim__s1 SE[11];

  HSimArrayType Int_arraybase;
  HSimArrayType Int_array;
HSim__s4 V1q;
HSim__s4 V1s;
HSim__s4 V1u;
HSim__s4 V1w;
HSim__s4 V1z;
HSim__s4 V1C;
HSim__s4 V1F;
HSim__s4 V1H;
HSim__s4 V1J;
HSim__s4 V1L;
HSim__s4 V1N;
HSim__s4 V1Q;
HSim__s4 V1S;
HSim__s4 V1U;
HSim__s4 V1W;
HSim__s4 V1Y;
HSim__s4 V20;
HSim__s4 V22;
    HSim__s1 SA[13];
    Work_ball1_behavioral(const char * name);
    ~Work_ball1_behavioral();
    void constructObject();
    void constructPorts();
    void reset();
    void architectureInstantiate(HSimConfigDecl* cfg);
    virtual void vhdlArchImplement();
};



HSim__s6 *createWork_ball1_behavioral(const char *name);

#endif
