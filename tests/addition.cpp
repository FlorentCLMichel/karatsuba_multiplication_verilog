#include <iostream>
#include "Vaddition.h"
#include "verilated.h"

#define MODULE Vaddition
const static unsigned int N_BITS = 14;

// addition function via the Verilog module
unsigned int add(unsigned int x, unsigned int y, MODULE* top)
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

    std::cout << "Add test...";
    std::cout.flush();
    
    // define the module
    MODULE* top = new MODULE;

    // perform the sums and check the results
    for (unsigned int i = 0; i < (1 << N_BITS); i++) {
        for (unsigned int j = 0; j < (1 << N_BITS); j++) {
            unsigned int k = add(i, j, top);
            if (k != i + j) {
                std::cout << "FAILED" << std::endl;
                std::cout << i << " + " << j << " != " << k << std::endl;
                return 1;
            };
        }
    }

    std::cout << "\tPASSED" << std::endl;

    delete top;
    return 0;
}
