`ifndef R_POS_SUB_
`define R_POS_SUB_

// subtraction of two positive integers using 2's complement
//
// Parameters: 
//  N_BITS: number of bits for each input
// 
// Arguments: 
//  * a (size N_BITS): left input
//  * b (size N_BITS): right input
//  * c (size N_BITS+1): output
module pos_sub #(parameter N_BITS = 4) (a, b, c);

    input wire [N_BITS-1:0] a, b;
    output wire [N_BITS:0] c;
   
    //define wires for the carry bits
    generate 
        for (i=0; i<N_BITS; i=i+1) begin : loop_1
            wire carry;
        end
    endgenerate
   
    // subtract the lowest bits and set the lowest carry
    xor (c[0], a[0], b[0]);
    and (loop_1[0].carry, ~a[0], b[0]);
    
    genvar i;
    generate
        for (i=1; i<N_BITS; i=i+1) begin

            wire dif, b_and_not_a, dif_and_carry;
            
            // compute the next bit in the result
            xor(dif, a[i], b[i]);
            xor(c[i], dif, loop_1[i-1].carry);
            
            // compute the next carry
            and(b_and_not_a, ~a[i], b[i]);
            and(dif_and_carry, ~dif, loop_1[i-1].carry);
            or(loop_1[i].carry, b_and_not_a, dif_and_carry);
        end
    endgenerate

    // set the last bit
    assign c[N_BITS] = loop_1[N_BITS-1].carry;
     
endmodule


`endif
