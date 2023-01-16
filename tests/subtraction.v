`include "./src/pos_sub.v"

module subtraction (a, b, c);

// bit depth
localparam BIT_DEPTH = 14;

input wire [BIT_DEPTH-1:0] a, b;
output wire [BIT_DEPTH:0] c;

pos_sub #(BIT_DEPTH, BIT_DEPTH) SUB (a, b, c);

endmodule
