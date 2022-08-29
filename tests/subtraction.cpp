#include <iostream>
#include "Vsubtraction.h"
#include "verilated.h"

#define MODULE Vsubtraction

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

    // inputs for the test
    std::vector<unsigned int> x { 1, 2, 4, 8, 16 };
    std::vector<unsigned int> y { 1, 2, 3, 4, 5 };

    // perform the sums and check the results
    for (unsigned int i = 0; i < x.size(); i++) {
        unsigned int z = sub(x[i], y[i], contextp, top);
        if (z != x[i] - y[i]) {
            std::cout << "FAILED" << std::endl;
            std::cout << x[i] << " - " << y[i] << " != " << z << std::endl;
            return 1;
        };
    }

    std::cout << "TEST PASSED" << std::endl;

    delete top;
    delete contextp;
    return 0;
}
