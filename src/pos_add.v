`ifndef R_POS_ADD_
`define R_POS_ADD_

// addition of two positive integers 
//
// Parameters: 
//  N_BITS_L: number of bits for the left input
//  N_BITS_R: number of bits for the right input
// 
// Constraint:
//  Need N_BITS_R <= N_BITS_L
// 
// Arguments:
//  a: left input (size N_BITS_L)
//  b: right input (size N_BITS_R)
//  c: output (size N_BITS_L+1)
module pos_add (a, b, c);
    
    parameter N_BITS_L = 8, // number of bits for the left input
              N_BITS_R = 8; // number of bits for the right input

    input [N_BITS_L-1:0] a; // left input
    input [N_BITS_R-1:0] b; // right input
    output [N_BITS_L:0] c;  // output
    
    genvar i;
    generate 

        // arrays for intermediate calculations
        wire a_and_b [N_BITS_R:1],       // product of the current bits
             sum [N_BITS_R:1];           // sum of the current bits
       
        // define the carry wires
        for (i = 0; i < N_BITS_L; i = i+1) begin : loop_1
            wire carry;
        end

        for (i = 0; i <= N_BITS_L; i = i+1) begin
            
            // compute the lowest bit and carry
            if (i == 0) begin
                xor (c[i], a[i], b[i]);
                and (loop_1[i].carry, a[i], b[i]);
            end
            
            // compute the N_BITS_R-1 next bits and carries
            else if (i < N_BITS_R) begin 
                wire sum_and_carry;
                xor (sum[i], a[i], b[i]);                        // sum of the ith bits of a and b
                and (a_and_b[i], a[i], b[i]);                    // product of the ith bits of a and b 
                and (sum_and_carry, sum[i], loop_1[i-1].carry);  // product of the sum and previous carry
                xor (c[i], sum[i], loop_1[i-1].carry);           // set the ith bit of the result
                or (loop_1[i].carry, a_and_b[i], sum_and_carry); // set the next carry
            end
            
            // compute the N_BITS_L-N_BITS_R next bits
            else if (i < N_BITS_L) begin
                xor (c[i], a[i], loop_1[i-1].carry);  // set the ith bit of the result
                and (loop_1[i].carry, a[i], loop_1[i-1].carry); // set the next carry
            end
            
            // set the highest bit of the result to the highest carry
            else 
                assign c[i] = loop_1[i-1].carry;
        end
    endgenerate

endmodule

`endif
