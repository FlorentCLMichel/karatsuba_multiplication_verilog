`include "pos_add"
`include "pos_add_shifted"
`include "pos_mul"

// multiplication of two positive integers using the Karatsuba algorithm
//
// Parameters: 
//  N_BITS:                  number of bits for each input
//  MAX_N_BITS_STANDARD_MUL: maximum bit depth using the standard multiplication
//                           (must be larger than or equal to 3)
// 
// Arguments: 
//  * a (size N_BITS):   left input
//  * b (size N_BITS):   right input
//  * c (size 2*N_BITS): output
module karatsuba_mul (a, b, c);

parameter N_BITS = 15,
          MAX_N_BITS_STANDARD_MUL = 4;

localparam N_BITS_1 = N_BITS / 2,     // bit depth of a_1 and b_1
           N_BITS_2 = (N_BITS+1) / 2; // bit depth of a_0 and b_0
localparam N_BITS_3 = N_BITS_2+1;     // bit depth of a_1+b_1

input wire [N_BITS-1:0] a, b;
output wire [2*N_BITS-1:0] c;

// If the bit depth is 1, multiplication is equivalent to an AND gate.
// We pad the result with a 0 on the left.
if (N_BITS == 1) begin
    assign c[1] = 0;
    and (c[0], a, b);
end

// If the bit depth is 2, instanciate the `mul_2_bits` module.
if (N_BITS == 2)
    mul_2_bits MUL (a, b, c);

if ((N_BITS > 2) && (N_BITS <= MAX_N_BITS_STANDARD_MUL))
    pos_mul #(N_BITS, N_BITS) MUL (a, b, c);

// If the bit depth is larger than 2, use the Karatsuba algorithm.
if (N_BITS > MAX_N_BITS_STANDARD_MUL) begin

    //// for debugging
    //always begin
    //    $display("_____________________\na=%d\tb=%d\tc=%d", a, b, c);
    //    $display("a0 = %d\ta1 = %d\tb0 = %d\tb1 = %d", a0, a1, b0, b1);
    //    $display("a0 × b0 = %d", a0_times_b0);
    //    $display("a0 × b1 + a1 × b0 = %d", a0_b1_plus_a1_b0);
    //    $display("a1 × b1 = %d", a1_times_b1);
    //end

    // Define the intermediate values a_0, a_1, b_0, and b_1
    wire [N_BITS_1-1:0] a1, b1;
    wire [N_BITS_2-1:0] a0, b0;
    assign a1 = a[N_BITS-1:N_BITS_2];
    assign b1 = b[N_BITS-1:N_BITS_2];
    assign a0 = a[N_BITS_2-1:0];
    assign b0 = b[N_BITS_2-1:0];
    
    // Define the sums a_0 + b_0 and a_1 + b_1 
    // The latter is padded with a 0 if N_BITS is odd
    wire [N_BITS_3-1:0] a0_p_a1, b0_p_b1;
    pos_add #(N_BITS_2, N_BITS_1) PAA (a0, a1, a0_p_a1);
    pos_add #(N_BITS_2, N_BITS_1) PAB (b0, b1, b0_p_b1);
    
    // Compute a_0 b_0
    wire [2*N_BITS_2-1:0] a0_times_b0;
    karatsuba_mul #(N_BITS_2) MUL_1 (a0, b0, a0_times_b0);
    
    // Compute a_1 b_1
    wire [2*N_BITS_1-1:0] a1_times_b1;
    karatsuba_mul #(N_BITS_1) MUL_2 (a1, b1, a1_times_b1);
    
    // Compute (a_0 + a_1) (b_0 + b_1)
    wire [2*N_BITS_3-1:0] a0_p_a1_times_b0_p_b1;
    karatsuba_mul #(N_BITS_3) MUL_3 (a0_p_a1, b0_p_b1, a0_p_a1_times_b0_p_b1);
    
    // Two subtractions to compute the middle term
    wire [2*N_BITS_3:0] a0_p_a1_times_b0_p_b1_minus_a0_b0;
    wire [N_BITS_1+N_BITS_2:0] a0_b1_plus_a1_b0;
    pos_sub #(2*N_BITS_3, 2*N_BITS_2) PS1 (a0_p_a1_times_b0_p_b1, a0_times_b0, a0_p_a1_times_b0_p_b1_minus_a0_b0);
    pos_sub #(2*N_BITS_3+1, 2*N_BITS_1, N_BITS_1+N_BITS_2+1) 
        PS2 (a0_p_a1_times_b0_p_b1_minus_a0_b0, a1_times_b1, a0_b1_plus_a1_b0);
    
    // Logic to compute c (two shifted sums)
    wire [2*N_BITS_1+N_BITS_2:0] c1;
    pos_add_shifted #(N_BITS_1+N_BITS_2+1, 2*N_BITS_1, N_BITS_2) PAS1 (a0_b1_plus_a1_b0, a1_times_b1, c1);
    pos_add_shifted #(2*N_BITS_2, 2*N_BITS_1+N_BITS_2+1, N_BITS_2, 2*N_BITS) PAS2 (a0_times_b0, c1, c);

end

endmodule
