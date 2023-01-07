`ifndef R_MUL_2_BITS_
`define R_MUL_2_BITS_

`include "./src/pos_add.v"

// multiplication of two-bit positive integers
// 
// Arguments: 
//  * a (size 2): left input
//  * b (size 2): right input
//  * c (size 4): output
module mul_2_bits (a, b, c);

    // define the inputs and output as wires
    input wire [1:0] a, b;
    output wire [3:0] c;
   
    // padding of b with a 0 on the left and on the right
    wire [2:0] b_zero;
    wire [2:0] zero_b;
    assign b_zero = {b, 1'b0};
    assign zero_b = {1'b0, b};

    // padded values multiplied by the bits of a
    wire [2:0] b_zero_a_1;
    wire [2:0] zero_b_a_0;
    assign b_zero_a_1 = a[1] ? b_zero : 3'b0;
    assign zero_b_a_0 = a[0] ? zero_b : 3'b0;

    // add the results
    pos_add #(3) ADD (b_zero_a_1, zero_b_a_0, c);

endmodule

`endif
