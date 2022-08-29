`ifndef R_POS_SUB_
`define R_POS_SUB_

// subtraction of two positive integers using 2's complement
module pos_sub #(parameter N_BITS = 4) (a, b, c);

    input wire [N_BITS-1:0] a, b;
    output wire [N_BITS:0] c;
   
    //define the intermediate wires
    wire [N_BITS-1:0] carry /*verilator split_var*/;
    wire [N_BITS-1:1] dif, b_and_not_a, 
                      dif_and_carry /*verilator split_var*/;
   
    // subtract the lowest bits and set the lowest carry
    xor (c[0], a[0], b[0]);
    and (carry[0], ~a[0], b[0]);
    
    genvar i;
    generate
        for (i=1; i<N_BITS; i=i+1) begin
            
            // compute the next bit in the result
            xor(dif[i], a[i], b[i]);
            xor(c[i], dif[i], carry[i-1]);
            
            // compute the next carry
            and(b_and_not_a[i], ~a[i], b[i]);
            and(dif_and_carry[i], ~dif[i], carry[i-1]);
            or(carry[i], b_and_not_a[i], dif_and_carry[i]);
        end
    endgenerate
   
    // set the highest bit as the last carry bit
    buf (c[N_BITS], carry[N_BITS-1]);
     
endmodule


`endif
