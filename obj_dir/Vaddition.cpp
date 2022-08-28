// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Model implementation (design independent parts)

#include "Vaddition.h"
#include "Vaddition__Syms.h"

//============================================================
// Constructors

Vaddition::Vaddition(VerilatedContext* _vcontextp__, const char* _vcname__)
    : vlSymsp{new Vaddition__Syms(_vcontextp__, _vcname__, this)}
    , a{vlSymsp->TOP.a}
    , b{vlSymsp->TOP.b}
    , c{vlSymsp->TOP.c}
    , rootp{&(vlSymsp->TOP)}
{
}

Vaddition::Vaddition(const char* _vcname__)
    : Vaddition(nullptr, _vcname__)
{
}

//============================================================
// Destructor

Vaddition::~Vaddition() {
    delete vlSymsp;
}

//============================================================
// Evaluation loop

void Vaddition___024root___eval_initial(Vaddition___024root* vlSelf);
void Vaddition___024root___eval_settle(Vaddition___024root* vlSelf);
void Vaddition___024root___eval(Vaddition___024root* vlSelf);
#ifdef VL_DEBUG
void Vaddition___024root___eval_debug_assertions(Vaddition___024root* vlSelf);
#endif  // VL_DEBUG
void Vaddition___024root___final(Vaddition___024root* vlSelf);

static void _eval_initial_loop(Vaddition__Syms* __restrict vlSymsp) {
    vlSymsp->__Vm_didInit = true;
    Vaddition___024root___eval_initial(&(vlSymsp->TOP));
    // Evaluate till stable
    do {
        VL_DEBUG_IF(VL_DBG_MSGF("+ Initial loop\n"););
        Vaddition___024root___eval_settle(&(vlSymsp->TOP));
        Vaddition___024root___eval(&(vlSymsp->TOP));
    } while (0);
}

void Vaddition::eval_step() {
    VL_DEBUG_IF(VL_DBG_MSGF("+++++TOP Evaluate Vaddition::eval_step\n"); );
#ifdef VL_DEBUG
    // Debug assertions
    Vaddition___024root___eval_debug_assertions(&(vlSymsp->TOP));
#endif  // VL_DEBUG
    // Initialize
    if (VL_UNLIKELY(!vlSymsp->__Vm_didInit)) _eval_initial_loop(vlSymsp);
    // Evaluate till stable
    do {
        VL_DEBUG_IF(VL_DBG_MSGF("+ Clock loop\n"););
        Vaddition___024root___eval(&(vlSymsp->TOP));
    } while (0);
    // Evaluate cleanup
}

//============================================================
// Utilities

VerilatedContext* Vaddition::contextp() const {
    return vlSymsp->_vm_contextp__;
}

const char* Vaddition::name() const {
    return vlSymsp->name();
}

//============================================================
// Invoke final blocks

VL_ATTR_COLD void Vaddition::final() {
    Vaddition___024root___final(&(vlSymsp->TOP));
}
