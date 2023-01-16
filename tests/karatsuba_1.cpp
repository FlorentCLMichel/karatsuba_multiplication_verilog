#include <iostream>
#include "Vkaratsuba_1.h"
#include "verilated.h"

#define MODULE Vkaratsuba_1
const static unsigned int N_BITS = 8;

// multiplication via the Verilog module
unsigned int mul(unsigned int x, unsigned int y, MODULE* top)
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

    std::cout << "KARATSUBA_1...";
    std::cout.flush();
    
    // define the module
    MODULE* top = new MODULE;

    // perform the sums and check the results
    for (unsigned int i = 0; i < (1 << N_BITS); i++) {
        for (unsigned int j = 0; j < (1 << N_BITS); j++) {
            unsigned int k = mul(i, j, top);
            if (k != i * j) {
                std::cout << "FAILED" << std::endl;
                std::cout << i << " × " << j << " != " << k << std::endl;
                return 1;
            };
        }
    }

    std::cout << "\tPASSED" << std::endl;

    delete top;
    return 0;
}
