/* Somador de 32 bits */

module adder (
   input  wire [31:0] iA,
   input  wire [31:0] iB,
   output wire [31:0] out
);

always @(*)
begin
   out <= iA + iB;
end

endmodule
