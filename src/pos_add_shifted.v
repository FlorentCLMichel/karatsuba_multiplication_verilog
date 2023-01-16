`ifndef POS_ADD_SHIFTED_
`define POS_ADD_SHIFTED_

`include "pos_add.v"

// Addition of two unsigned integers
// 
// Parameters: 
//  N_BITS_L: number of bits for the left input
//  N_BITS_R: number of bits for the right input
//  SHIFT:    left shift of the right input
//  N_BITS:   number of bits for the output (overriden if 0)
//
// Arguments:
//  a: left input (size N_BITS_L)
//  b: right input (size N_BITS_R)
//  c: output (size N_BITS_L+1 or N_BITS_R+SHIFT+1)
module pos_add_shifted (a, b, c);
    
    parameter N_BITS_L = 8, // number of bits for the left input
              N_BITS_R = 8, // number of bits for the right input
              SHIFT = 0,    // left shift of the right input
              N_BITS = 0;   // target bit depth for the output

    // Some bits of a and b may not be used if N_BITS is set
    /* verilator lint_off unused */
    input [N_BITS_L-1:0] a; // left input
    input [N_BITS_R-1:0] b; // right input
    /* verilator lint_on unused */
    
    localparam MAX_DEPTH = (N_BITS > 0) ? N_BITS-1 : (N_BITS_L >= N_BITS_R+SHIFT ? N_BITS_L : N_BITS_R+SHIFT);
    output [MAX_DEPTH:0] c;  // output
    
    // first SHIFT bits are equal to those of the left input
    generate
    if (MAX_DEPTH <= SHIFT-1)
        assign c[MAX_DEPTH:0] = a[MAX_DEPTH:0];
    else begin
        assign c[SHIFT-1:0] = a[SHIFT-1:0];

        // the next bits are obtained via a sum
        if (N_BITS_L >= N_BITS_R + SHIFT) begin
            if (MAX_DEPTH <= N_BITS_L)
                pos_add #(MAX_DEPTH-SHIFT, N_BITS_R) A
                     (a[MAX_DEPTH-1:SHIFT], b, c[MAX_DEPTH:SHIFT]);
            else begin
                pos_add #(N_BITS_L-SHIFT, N_BITS_R) A
                     (a[N_BITS_L-1:SHIFT], b, c[N_BITS_L:SHIFT]);
                assign c[MAX_DEPTH:N_BITS_L+1] = 0;
            end
        end else begin
            if (MAX_DEPTH <= N_BITS_R+SHIFT) begin
                wire [MAX_DEPTH-SHIFT-1:0] a_shifted;
                assign a_shifted[N_BITS_L-SHIFT-1:0] = a[N_BITS_L-1:SHIFT];
                assign a_shifted[MAX_DEPTH-SHIFT-1 : N_BITS_L-SHIFT] = 0;
                /* verilator lint_off width */
                pos_add #(N_BITS_R, MAX_DEPTH-SHIFT) A
                     (b, a_shifted, c[MAX_DEPTH:SHIFT]);
                /* verilator lint_on width */
            end else begin
                wire [N_BITS_R-1:0] a_shifted;
                assign a_shifted[N_BITS_L-SHIFT-1:0] = a[N_BITS_L-1:SHIFT];
                assign a_shifted[N_BITS_R-1 : N_BITS_L-SHIFT] = 0;
                pos_add #(N_BITS_R, N_BITS_R) A
                     (a_shifted, b, c[N_BITS_R+SHIFT:SHIFT]);
                assign c[MAX_DEPTH:N_BITS_R+SHIFT+1] = 0;
            end
        end
    end
    endgenerate

endmodule

`endif
