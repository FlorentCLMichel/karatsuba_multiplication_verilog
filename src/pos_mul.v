`ifndef POS_MUL_
`define POS_MUL_

`include "pos_add.v"

// Multiplication of two unsigned integers
// 
// Parameters: 
//  N_BITS_L: number of bits for the left input
//  N_BITS_R: number of bits for the right input
// 
// Arguments:
//  a: left input (size N_BITS_L)
//  b: right input (size N_BITS_R)
//  c: output (size N_BITS_L+N_BITS_R)
module pos_mul (a, b, c);

    parameter N_BITS_L = 8, // number of bits for the left input
              N_BITS_R = 8; // number of bits for the right input

    input [N_BITS_L-1:0] a;            // left input
    input [N_BITS_R-1:0] b;            // right input
    output [N_BITS_L+N_BITS_R-1:0] c;  // output

    // intermediate results
    wire [N_BITS_L-1:0] e [0:N_BITS_R-1];

    genvar i;
    generate
        for (i=0; i<N_BITS_R; i=i+1) begin: block
           
            // arrays to store intermediate results
            wire [N_BITS_L+i:0] d;
            
            if (i==0) begin
                // set the first value of d as a if the lowest bit of b is 1 or
                // 0 otherwise
                assign d = b[0] ? {1'b0, a} : 0;
                
            end else begin
                // value equal to a if the current bit of b is 1 or 0 otherwise
                assign e[i-1] = b[i] ? a : 0;

                // add the result to the previous value of d: 1. middle bits
                pos_add #(N_BITS_L, N_BITS_L) A (block[i-1].d[N_BITS_L+i-1:i], e[i-1], d[N_BITS_L+i:i]);

                // 2. lower bits (no addition needed)
                assign d[i-1:0] = block[i-1].d[i-1:0];
            end
        end
    endgenerate

    // set the output
    assign c = block[N_BITS_R-1].d;

endmodule

`endif
