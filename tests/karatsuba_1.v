`include "./src/karatsuba_mul.v"

module karatsuba_1 (a, b, c);

localparam N_BITS = 16,
           MAX_N_BITS_STANDARD_MUL = 4;

input wire [N_BITS-1:0] a, b;
output wire [2*N_BITS-1:0] c;

karatsuba_mul 
    #(.N_BITS(N_BITS), .MAX_N_BITS_STANDARD_MUL(MAX_N_BITS_STANDARD_MUL)) 
    KM (.a(a), .b(b), .c(c));

endmodule
