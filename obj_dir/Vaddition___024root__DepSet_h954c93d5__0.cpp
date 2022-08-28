// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vaddition.h for the primary calling header

#include "verilated.h"

#include "Vaddition___024root.h"

VL_INLINE_OPT void Vaddition___024root___combo__TOP__0(Vaddition___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vaddition__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vaddition___024root___combo__TOP__0\n"); );
    // Init
    CData/*0:0*/ addition__DOT__ACONV__DOT__carry__BRA__6__KET__;
    CData/*0:0*/ addition__DOT__ACONV__DOT__carry__BRA__5__KET__;
    CData/*0:0*/ addition__DOT__ACONV__DOT__carry__BRA__4__KET__;
    CData/*0:0*/ addition__DOT__ACONV__DOT__carry__BRA__3__KET__;
    CData/*0:0*/ addition__DOT__ACONV__DOT__carry__BRA__2__KET__;
    CData/*0:0*/ addition__DOT__ACONV__DOT__carry__BRA__1__KET__;
    CData/*0:0*/ addition__DOT__ACONV__DOT__carry__BRA__0__KET__;
    CData/*6:0*/ addition__DOT__ACONV__DOT__a_and_b;
    CData/*6:0*/ addition__DOT__ACONV__DOT__sum;
    // Body
    vlSelf->c = ((0x1feU & (IData)(vlSelf->c)) | (1U 
                                                  & ((IData)(vlSelf->a) 
                                                     ^ (IData)(vlSelf->b))));
    addition__DOT__ACONV__DOT__carry__BRA__0__KET__ 
        = (1U & ((IData)(vlSelf->a) & (IData)(vlSelf->b)));
    addition__DOT__ACONV__DOT__a_and_b = (0x7fU & (
                                                   ((IData)(vlSelf->a) 
                                                    & (IData)(vlSelf->b)) 
                                                   >> 1U));
    addition__DOT__ACONV__DOT__sum = (0x7fU & (((IData)(vlSelf->a) 
                                                ^ (IData)(vlSelf->b)) 
                                               >> 1U));
    vlSelf->c = ((0x1fdU & (IData)(vlSelf->c)) | (2U 
                                                  & (((IData)(addition__DOT__ACONV__DOT__sum) 
                                                      ^ (IData)(addition__DOT__ACONV__DOT__carry__BRA__0__KET__)) 
                                                     << 1U)));
    addition__DOT__ACONV__DOT__carry__BRA__1__KET__ 
        = (1U & ((IData)(addition__DOT__ACONV__DOT__a_and_b) 
                 | ((IData)(addition__DOT__ACONV__DOT__sum) 
                    & (IData)(addition__DOT__ACONV__DOT__carry__BRA__0__KET__))));
    vlSelf->c = ((0x1fbU & (IData)(vlSelf->c)) | (4U 
                                                  & ((0xfffffffcU 
                                                      & ((IData)(addition__DOT__ACONV__DOT__sum) 
                                                         << 1U)) 
                                                     ^ 
                                                     ((IData)(addition__DOT__ACONV__DOT__carry__BRA__1__KET__) 
                                                      << 2U))));
    addition__DOT__ACONV__DOT__carry__BRA__2__KET__ 
        = (1U & (((IData)(addition__DOT__ACONV__DOT__a_and_b) 
                  >> 1U) | (((IData)(addition__DOT__ACONV__DOT__sum) 
                             >> 1U) & (IData)(addition__DOT__ACONV__DOT__carry__BRA__1__KET__))));
    vlSelf->c = ((0x1f7U & (IData)(vlSelf->c)) | (8U 
                                                  & ((0xfffffff8U 
                                                      & ((IData)(addition__DOT__ACONV__DOT__sum) 
                                                         << 1U)) 
                                                     ^ 
                                                     ((IData)(addition__DOT__ACONV__DOT__carry__BRA__2__KET__) 
                                                      << 3U))));
    addition__DOT__ACONV__DOT__carry__BRA__3__KET__ 
        = (1U & (((IData)(addition__DOT__ACONV__DOT__a_and_b) 
                  >> 2U) | (((IData)(addition__DOT__ACONV__DOT__sum) 
                             >> 2U) & (IData)(addition__DOT__ACONV__DOT__carry__BRA__2__KET__))));
    vlSelf->c = ((0x1efU & (IData)(vlSelf->c)) | (0x10U 
                                                  & ((0xfffffff0U 
                                                      & ((IData)(addition__DOT__ACONV__DOT__sum) 
                                                         << 1U)) 
                                                     ^ 
                                                     ((IData)(addition__DOT__ACONV__DOT__carry__BRA__3__KET__) 
                                                      << 4U))));
    addition__DOT__ACONV__DOT__carry__BRA__4__KET__ 
        = (1U & (((IData)(addition__DOT__ACONV__DOT__a_and_b) 
                  >> 3U) | (((IData)(addition__DOT__ACONV__DOT__sum) 
                             >> 3U) & (IData)(addition__DOT__ACONV__DOT__carry__BRA__3__KET__))));
    vlSelf->c = ((0x1dfU & (IData)(vlSelf->c)) | (0x20U 
                                                  & ((0xffffffe0U 
                                                      & ((IData)(addition__DOT__ACONV__DOT__sum) 
                                                         << 1U)) 
                                                     ^ 
                                                     ((IData)(addition__DOT__ACONV__DOT__carry__BRA__4__KET__) 
                                                      << 5U))));
    addition__DOT__ACONV__DOT__carry__BRA__5__KET__ 
        = (1U & (((IData)(addition__DOT__ACONV__DOT__a_and_b) 
                  >> 4U) | (((IData)(addition__DOT__ACONV__DOT__sum) 
                             >> 4U) & (IData)(addition__DOT__ACONV__DOT__carry__BRA__4__KET__))));
    vlSelf->c = ((0x1bfU & (IData)(vlSelf->c)) | (0x40U 
                                                  & ((0xffffffc0U 
                                                      & ((IData)(addition__DOT__ACONV__DOT__sum) 
                                                         << 1U)) 
                                                     ^ 
                                                     ((IData)(addition__DOT__ACONV__DOT__carry__BRA__5__KET__) 
                                                      << 6U))));
    addition__DOT__ACONV__DOT__carry__BRA__6__KET__ 
        = (1U & (((IData)(addition__DOT__ACONV__DOT__a_and_b) 
                  >> 5U) | (((IData)(addition__DOT__ACONV__DOT__sum) 
                             >> 5U) & (IData)(addition__DOT__ACONV__DOT__carry__BRA__5__KET__))));
    vlSelf->c = ((0x17fU & (IData)(vlSelf->c)) | ((IData)(
                                                          (((IData)(addition__DOT__ACONV__DOT__sum) 
                                                            >> 6U) 
                                                           ^ (IData)(addition__DOT__ACONV__DOT__carry__BRA__6__KET__))) 
                                                  << 7U));
    vlSelf->c = ((0xffU & (IData)(vlSelf->c)) | (0x100U 
                                                 & (((IData)(addition__DOT__ACONV__DOT__a_and_b) 
                                                     << 2U) 
                                                    | (((IData)(addition__DOT__ACONV__DOT__sum) 
                                                        << 2U) 
                                                       & ((IData)(addition__DOT__ACONV__DOT__carry__BRA__6__KET__) 
                                                          << 8U)))));
}

void Vaddition___024root___eval(Vaddition___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vaddition__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vaddition___024root___eval\n"); );
    // Body
    Vaddition___024root___combo__TOP__0(vlSelf);
}

#ifdef VL_DEBUG
void Vaddition___024root___eval_debug_assertions(Vaddition___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vaddition__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vaddition___024root___eval_debug_assertions\n"); );
}
#endif  // VL_DEBUG
