// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vaddition.h for the primary calling header

#include "verilated.h"

#include "Vaddition___024root.h"

VL_ATTR_COLD void Vaddition___024root___eval_initial(Vaddition___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vaddition__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vaddition___024root___eval_initial\n"); );
}

void Vaddition___024root___combo__TOP__0(Vaddition___024root* vlSelf);

VL_ATTR_COLD void Vaddition___024root___eval_settle(Vaddition___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vaddition__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vaddition___024root___eval_settle\n"); );
    // Body
    Vaddition___024root___combo__TOP__0(vlSelf);
}

VL_ATTR_COLD void Vaddition___024root___final(Vaddition___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vaddition__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vaddition___024root___final\n"); );
}

VL_ATTR_COLD void Vaddition___024root___ctor_var_reset(Vaddition___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vaddition__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vaddition___024root___ctor_var_reset\n"); );
    // Body
    vlSelf->a = VL_RAND_RESET_I(8);
    vlSelf->b = VL_RAND_RESET_I(8);
    vlSelf->c = VL_RAND_RESET_I(9);
}
