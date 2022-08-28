// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design internal header
// See Vaddition.h for the primary calling header

#ifndef VERILATED_VADDITION___024ROOT_H_
#define VERILATED_VADDITION___024ROOT_H_  // guard

#include "verilated.h"

class Vaddition__Syms;
VL_MODULE(Vaddition___024root) {
  public:

    // DESIGN SPECIFIC STATE
    VL_IN8(a,7,0);
    VL_IN8(b,7,0);
    VL_OUT16(c,8,0);

    // INTERNAL VARIABLES
    Vaddition__Syms* vlSymsp;  // Symbol table

    // CONSTRUCTORS
    Vaddition___024root(const char* name);
    ~Vaddition___024root();
    VL_UNCOPYABLE(Vaddition___024root);

    // INTERNAL METHODS
    void __Vconfigure(Vaddition__Syms* symsp, bool first);
} VL_ATTR_ALIGNED(VL_CACHE_LINE_BYTES);


#endif  // guard
