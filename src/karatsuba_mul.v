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

// TO DO: compute the three products

// TO DO: two subtractions to compute the middle term

// TO DO: logic to compute c (two shifted sums)

endmodule
