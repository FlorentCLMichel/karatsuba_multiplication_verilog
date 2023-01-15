// WORK IN PROGRESS

// multiplication of two positive integers using the Karatsuba algorithm
//
// Parameters: 
//  N_BITS: number of bits for each input
// 
// Arguments: 
//  * a (size N_BITS):   left input
//  * b (size N_BITS):   right input
//  * c (size 2*N_BITS): output
module karatsuba_mul (a, b, c);

parameter N_BITS = 15;

localparam N_BITS_1 = N_BITS / 2,     // bit depth of a_1 and b_1
           N_BITS_2 = (N_BITS+1) / 2; // bit depth of a_0 and b_0
localparam N_BITS_3 = N_BITS_2+1;     // bit depth of a_1+b_1

input wire [N_BITS-1:0] a, b;

// If the bit depth is 1, multiplication is equivalent to an AND gate.
// We pad the result with a 0 on the left.
if (N_BITS == 1) begin
    output wire [1:0] c;
    assign c[0] = 0;
    and (c[1], a, b);
end

// If the bit depth is 2, instanciate the `mul_2_bits` module.
if (N_BITS == 2) begin
    output wire [2*N_BITS-1:0] c;
    mul_2_bits (a, b, c);
end

// If the bit depth is larger than 2, use the Karatsuba algorithm.
if (N_BITS > 2) begin
    
    output wire [2*N_BITS-1:0] c;

    // Define the intermediate values a_0, a_1, b_0, and b_1
    wire [N_BITS_1] a1, b1;
    wire [N_BITS_2] a0, b0;
    assign a1 = a[N_BITS-1:N_BITS_2];
    assign b1 = a[N_BITS-1:N_BITS_2];
    assign a0 = a[N_BITS_2-1:0];
    assign b0 = b[N_BITS_2-1:0];
    
    // Define the sums a_0 + b_0 and a_1 + b_1 
    // The latter is padded with a 0 if N_BITS is odd
    wire [N_BITS_3] a0_p_b0, a1_p_b1;
    pos_add #(N_BITS_2) (a0, b0, a0_p_b0);
    generate
        if (N_BITS_1 == N_BITS_2) 
            pos_add #(N_BITS_1) (a1, b1, a1_p_b1);
        else begin
            wire [N_BITS_1+1] a1_m_b1_;
            pos_add #(N_BITS_1) (a1, b1, a1_p_b1_);
            assign a1_p_b1 = {1'b0, a1_m_b1_};
        end
    endgenerate
    
    // Compute a_0 b_0
    wire [2*N_BITS_2-1:0] a0_times_b0;
    karatsuba_mul #(N_BITS_2) MUL_1 (a0, b0, a0_times_b0);
    
    // Compute a_1 b_1
    wire [2*N_BITS_1-1:0] a1_times_b1;
    karatsuba_mul #(N_BITS_1) MUL_2 (a1, b1, a1_times_b1);
    
    // Compute (a_0 + b_0) (a_1 + b_1)
    wire [2*N_BITS_3-1:0] a0_p_b0_times_a1_p_b1;
    karatsuba_mul #(N_BITS_3) MUL_3 (a0_p_b0, a1_p_b1, a0_p_b0_times_a1_p_b1);
    
    // TO DO: two subtractions to compute the middle term
    
    // TO DO: logic to compute c (two shifted sums)

end

endmodule
