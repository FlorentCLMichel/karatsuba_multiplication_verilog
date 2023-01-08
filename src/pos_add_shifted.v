`ifndef POS_ADD_SHIFTED_
`define POS_ADD_SHIFTED_

`include "pos_add.v"

// Addition of two unsigned integers
// 
// Parameters: 
//  N_BITS_L: number of bits for the left input
//  N_BITS_R: number of bits for the right input
//  SHIFT: left shift of the right input
// 
// Arguments:
//  a: left input (size N_BITS_L)
//  b: right input (size N_BITS_R)
//  c: output (size N_BITS_L+1)
module pos_add_shifted (a, b, c);
    
    parameter N_BITS_L = 8, // number of bits for the left input
              N_BITS_R = 8, // number of bits for the right input
              SHIFT = 0;    // left shift of the right input

    input [N_BITS_L-1:0] a; // left input
    input [N_BITS_R-1:0] b; // right input
    
    localparam MAX_DEPTH = N_BITS_L >= N_BITS_R+SHIFT ? N_BITS_L : N_BITS_R+SHIFT;
    output [MAX_DEPTH:0] c;  // output
    
    // first SHIFT bits are equal to those of the left input
    assign c[SHIFT-1:0] = a[SHIFT-1:0];

    // the next bits are obtained via a sum
    generate
        if (N_BITS_L >= N_BITS_R + SHIFT) begin
            pos_add #(N_BITS_L-SHIFT, N_BITS_R) A
                 (a[N_BITS_L-1:SHIFT], b, c[N_BITS_L:SHIFT]);
        end else begin
            // pad a with zeros
            wire [N_BITS_R-1:0] a_shifted;
            assign a_shifted[N_BITS_L-SHIFT-1:0] = a[N_BITS_L-1:SHIFT];
            assign a_shifted[N_BITS_R-1 : N_BITS_L-SHIFT] = 0;
            pos_add #(N_BITS_R, N_BITS_R) A
                 (a_shifted, b, c[N_BITS_R+SHIFT:SHIFT]);
        end
    endgenerate

endmodule

`endif
