/*
 * Bloco de controle (combinacional) da ULA
 * 
 * Controle das operações:
 * Genéricas: soma, subtração
 * Tipo-R:    add, sub, slt, or, and
 *
 * operações:
 * 00 - soma
 * 01 - subtração
 * 10 - funct
*/

module ControleULA (
   input  logic [1:0] opULA,
   input  logic [2:0] funct3,
   input  logic [6:0] funct7,
   output logic [4:0] codULA
);

always @(*)
begin
   case (opULA)
      2'b00:
         codULA <= OPADD;              // addi lui lw sw beq jal jalr
      2'b01:
         codULA <= OPSUB;              // beq
      2'b10:
         case (funct3)                 // tipo-R: add sub slt or and
            3'b000:
            begin
               if (funct7 == 7'b0)
                  codULA <= OPADD;
               else
                  codULA <= OPSUB;
            end
            3'b010:
                  codULA    <= OPSLT;
            3'b110:
                  codULA    <= OPOR;
            3'b111:
                  codULA    <= OPAND;
         endcase
   endcase
end

endmodule
