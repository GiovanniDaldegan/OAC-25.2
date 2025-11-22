/* Multiplexador síncrono 4x1 com entradas de 32b */

module mux4sync (
   input  wire        clock, enable,
   input  wire [31:0] entr0, entr1, entr2, entr3,
   input  wire [1:0]  sel,
   output wire [31:0] saida
);

initial
begin
   saida <= 32'd0;
end

always @(posedge clock)
begin
   if (enable)
      case (sel)
         2'b00:
            saida <= entr0;
         2'b01:
            saida <= entr1;
         2'b10:
            saida <= entr2;
         2'b11:
            saida <= entr3;
      endcase
end

endmodule
