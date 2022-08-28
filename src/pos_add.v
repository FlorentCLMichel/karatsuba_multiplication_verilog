`ifndef R_POS_ADD_
`define R_POS_ADD_

/* addition of two positive integers 
 *
 * Arguments: 
 *  * a: left input
 *  * b: right input
 *  * c: output
 *
 * The parameter N_BITS is the number of bits of the two inputs a and b. The
 * output c has N_BITS+1 bits. 
 */
module pos_add #(parameter N_BITS = 4) (a, b, c);

    // define the inputs and output as wires
    input wire [N_BITS-1:0] a, b;
    output wire [N_BITS:0] c;
   
    // define intermediate wires
    wire [N_BITS-1:0] carry /*verilator split_var*/;
    wire [N_BITS-1:1] sum_and_carry /*verilator split_var*/,
                      a_and_b, sum;
   
    // sum the lowest bits
    xor (c[0], a[0], b[0]);
    and (carry[0], a[0], b[0]);
   
    // loop over the other bits
    genvar i;
    generate
        for (i=1; i<N_BITS; i=i+1) begin

            // sum of the two bits of index i modulo 1
            xor(sum[i], a[i], b[i]);
            
            // set the bit of index i in c
            xor(c[i], sum[i], carry[i-1]);

            // compute the next carry bit
            and(a_and_b[i], a[i], b[i]);
            and(sum_and_carry[i], sum[i], carry[i-1]);
            or(carry[i], a_and_b[i], sum_and_carry[i]);
        end
    endgenerate
    
    // set the highest bit of c as the last carry
    buf (c[N_BITS], carry[N_BITS-1]);

endmodule

`endif
