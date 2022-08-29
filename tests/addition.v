`include "./src/pos_add.v"

module addition (a, b, c);

// bit depth
localparam BIT_DEPTH = 14;

input wire [BIT_DEPTH-1:0] a, b;
output wire [BIT_DEPTH:0] c;

pos_add #(BIT_DEPTH) ADD (a, b, c);

endmodule
