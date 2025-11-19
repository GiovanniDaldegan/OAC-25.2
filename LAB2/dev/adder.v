/* Somador de 32 bits */

module adder (
   input  logic [31:0] iA,
   input  logic [31:0] iB,
   output logic [31:0] out
);

initial
begin
   out <= 32'b0;
end

always @(*)
begin
   out <= iA + iB;
end

endmodule
