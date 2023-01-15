`include "./src/karatsuba_mul.v"

module karatsuba_1 (a, b, c);

// bit depth
localparam BIT_DEPTH = 16;

input wire [BIT_DEPTH-1:0] a, b;
output wire [2*BIT_DEPTH-1:0] c;

karatsuba_mul #(BIT_DEPTH) KM (a, b, c);

endmodule
