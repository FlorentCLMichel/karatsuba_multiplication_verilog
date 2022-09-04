`include "./src/mul_2_bits.v"

module mul_2 (a, b, c);

input wire [1:0] a, b;
output wire [3:0] c;

mul_2_bits MUL (a, b, c);

endmodule
