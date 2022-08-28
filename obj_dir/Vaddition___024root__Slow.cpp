// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vaddition.h for the primary calling header

#include "verilated.h"

#include "Vaddition__Syms.h"
#include "Vaddition___024root.h"

void Vaddition___024root___ctor_var_reset(Vaddition___024root* vlSelf);

Vaddition___024root::Vaddition___024root(const char* _vcname__)
    : VerilatedModule(_vcname__)
 {
    // Reset structure values
    Vaddition___024root___ctor_var_reset(this);
}

void Vaddition___024root::__Vconfigure(Vaddition__Syms* _vlSymsp, bool first) {
    if (false && first) {}  // Prevent unused
    this->vlSymsp = _vlSymsp;
}

Vaddition___024root::~Vaddition___024root() {
}
