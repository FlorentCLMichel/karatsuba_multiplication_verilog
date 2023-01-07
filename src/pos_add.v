`ifndef R_POS_ADD_
`define R_POS_ADD_

// addition of two positive integers 
//
// Parameters: 
//  N_BITS: number of bits for each input
// 
// Arguments: 
//  * a (size N_BITS):   left input
//  * b (size N_BITS):   right input
//  * c (size N_BITS+1): output
module pos_add #(parameter N_BITS = 4) (a, b, c);

    // define the inputs and output as wires
    input wire [N_BITS-1:0] a, b;
    output wire [N_BITS:0] c;
   
    // define wires for the carry bits
    genvar i;
    generate 
        for (i=0; i<N_BITS; i=i+1) begin : loop_1
            wire carry;
        end
    endgenerate
   
    // sum the lowest bits
    xor (c[0], a[0], b[0]);
    and (loop_1[0].carry, a[0], b[0]);
   
    // loop over the other bits
    generate
        for (i=1; i<N_BITS; i=i+1) begin

            wire sum_and_carry, a_and_b, sum;

            // sum of the two bits of index i modulo 1
            xor(sum, a[i], b[i]);
            
            // set the bit of index i in c
            xor(c[i], sum, loop_1[i-1].carry);

            // compute the next carry bit
            and(a_and_b, a[i], b[i]);
            and(sum_and_carry, sum, loop_1[i-1].carry);
            or(loop_1[i].carry, a_and_b, sum_and_carry);
        end
    endgenerate
    
    // set the highest bit of c as the last carry
    buf (c[N_BITS], loop_1[N_BITS-1].carry);

endmodule

`endif
