#include <iostream>
#include "Vsubtraction.h"
#include "verilated.h"

#define MODULE Vsubtraction
const static unsigned int N_BITS = 14;

// subtraction function via the Verilog module
unsigned int sub(unsigned int x, unsigned int y, 
                 VerilatedContext* contextp, MODULE* top)
{
    // set the two inputs
    top->a = x;
    top->b = y;

    // evaluate the module
    top->eval();
   
    // get the result
    return top->c; 
}

int main(int argc, char** argv, char** env) {

    std::cout << "Subtraction test...    ";
    std::cout.flush();
    
    // define the Verilator contect
    VerilatedContext* contextp;

    // define the module
    MODULE* top = new MODULE {contextp};

    // perform the sums and check the results
    for (unsigned int i = 0; i < (1 << N_BITS); i++) {
        for (unsigned int j = 0; j <= i; j++) {
            unsigned int k = sub(i, j, contextp, top);
            if (k != i - j) {
                std::cout << "FAILED" << std::endl;
                std::cout << i << " - " << j << " != " << k << std::endl;
                return 1;
            };
        }
    }

    std::cout << "TEST PASSED" << std::endl;

    delete top;
    delete contextp;
    return 0;
}
