`ifndef R_POS_SUB_
`define R_POS_SUB_

// subtraction of two positive integers with 2s complement
//
// Parameters: 
//  N_BITS_L: number of bits for the left input
//  N_BITS_R: number of bits for the right input
//  N_BITS:   number of bits for the output (replaced by N_BITS_L+1 if 0)
// 
// Constraint:
//  Need N_BITS_R <= N_BITS_L
// 
// Arguments:
//  a: left input (size N_BITS_L)
//  b: right input (size N_BITS_R)
//  c: output (size N_BITS_L+1)
module pos_sub (a, b, c);
    
    parameter N_BITS_L = 8, // number of bits for the left input
              N_BITS_R = 8, // number of bits for the right input
              N_BITS = 0;   // Number of bits for the output; set to N_BITS_L+1 if 0

    localparam N_BITS_RESULT = (N_BITS == 0) ? N_BITS_L+1 : N_BITS;

    // Some bits of a and b may not be used if N_BITS is set
    /* verilator lint_off unused */
    input [N_BITS_L-1:0] a; // left input
    input [N_BITS_R-1:0] b; // right input
    /* verilator lint_off unused */
    output [N_BITS_RESULT-1:0] c;  // output
    
    genvar i;
    generate 

        // arrays for intermediate calculations
        wire b_and_not_a [N_BITS_R:1],
             dif [N_BITS_R:1];
       
        // define the carry wires
        for (i = 0; i < N_BITS_RESULT; i = i+1) begin : loop_1
            wire carry;
        end

        for (i = 0; i < N_BITS_RESULT; i = i+1) begin
            
            // compute the lowest bit and carry
            if (i == 0) begin
                xor (c[i], a[i], b[i]);
                and (loop_1[i].carry, ~a[i], b[i]);
            end
            
            // compute the N_BITS_R-1 next bits and carries
            else if ((i < N_BITS_R) && (i+1 < N_BITS_RESULT)) begin 
                wire dif_and_carry;
                xor (dif[i], a[i], b[i]);                      
                and (b_and_not_a[i], ~a[i], b[i]);               
                and (dif_and_carry, ~dif[i], loop_1[i-1].carry);
                xor (c[i], dif[i], loop_1[i-1].carry);  
                or (loop_1[i].carry, b_and_not_a[i], dif_and_carry);
            end
            
            // compute the N_BITS_RESULT-N_BITS_R next bits
            else if ((i < N_BITS_RESULT) && (i < N_BITS_L)) begin
                xor (c[i], a[i], loop_1[i-1].carry);
                and (loop_1[i].carry, ~a[i], loop_1[i-1].carry);
            end
            
            // set the highest bit of the result to the highest carry
            else 
                assign c[i] = loop_1[i-1].carry;
        end
    endgenerate

endmodule

`endif
