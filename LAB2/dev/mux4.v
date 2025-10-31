/* Multiplexador 4x1 com entradas de 32b */

module mux4 (
   input  wire [31:0] entr0, entr1, entr2, entr3,
   input  wire [1:0]  select,
   output wire [31:0] out
);

initial
begin
   select <= 2'd0;
   out    <= 32'd0;
end

always @(*)
begin
   case (select)
      2b'00:
         out <= entr0;
      2b'01:
         out <= entr1;
      2b'10:
         out <= entr2;
      2b'11:
         out <= entr3;
   endcase
end

endmodule
