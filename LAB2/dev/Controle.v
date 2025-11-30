/* 
 * Bloco de controle (combinacional) do processador uniciclo da ISA RV32I
 * reduzida
 *
 * instruções (tipo, opcode e nomes):
 * R 33: add, sub, and, or, slt
 * I 13: addi
 * U 37: lui
 * I 03: lw
 * S 23: sw
 * B 63: beq
 * I 67: jalr
 * J 6F: jal
 * 
 * Entradas
 * muxOrig Reg       muxOrig PC
 * 00 SaidaULA       00 PC4
 * 01 MemData        01 PCImm
 * 10 PC4            10 SaidaULA
 * 11 Imm            11 
 */

`ifndef PARAM
    `include "Parametros.v"
`endif

module Controle (
   input  wire [6:0] opcode,
   input  wire       Zero,
   output wire       EscreveReg, LeMem, EscreveMem, OrigULA,
   output wire [1:0] opULA, OrigReg, OrigPC
);


always @(*)
begin
   case (opcode)
      OPC_RTYPE:  begin       // 33 - add sub slt and or
         EscreveReg  <= 1'b1;
         OrigReg     <= 2'b00;         // rd <- SaidaULA (rs1 op rs2)
         LeMem       <= 1'b0;
         EscreveMem  <= 1'b0;
         OrigPC      <= 2'b00;         // PC = PC+4
         OrigULA     <= 1'b0;
         opULA       <= 2'b10;
      end
      OPC_OPIMM:  begin       // 13 - addi
         EscreveReg  <= 1'b1;
         OrigReg     <= 2'b00;
         LeMem       <= 1'b0;
         EscreveMem  <= 1'b0;
         OrigPC      <= 2'b00;
         OrigULA     <= 1'b1;
         opULA       <= 2'b00;
      end
      OPC_LUI:    begin       // 37 - lui
         EscreveReg  <= 1'b1;
         OrigReg     <= 2'b11;         // rd <- Imm
         LeMem       <= 1'b0;
         EscreveMem  <= 1'b0;
         OrigPC      <= 2'b00;
         /*
         OrigULA     <= 1'b1;
         opULA       <= 2'b00;
         */
      end
      OPC_LOAD:   begin       // 03 - lw
         EscreveReg  <= 1'b1;
         OrigReg     <= 2'b01;         // rd <- MEM
         LeMem       <= 1'b1;
         EscreveMem  <= 1'b0;
         OrigPC      <= 2'b00;
         OrigULA     <= 1'b1;
         opULA       <= 2'b00;
      end
      OPC_STORE:  begin       // 23 - sw
         EscreveReg  <= 1'b0;
         //OrigReg     <= 2'b00;
         LeMem       <= 1'b0;
         EscreveMem  <= 1'b1;
         OrigPC      <= 2'b00;
         OrigULA     <= 1'b1;
         opULA       <= 2'b00;
      end
      OPC_BRANCH: begin       // 63 - beq
         EscreveReg  <= 1'b0;
         //OrigReg     <= 2'b00;
         LeMem       <= 1'b0;
         EscreveMem  <= 1'b0;
         OrigPC      <= {1'b0, Zero};  // PC = PC+imm ou PC+4
         OrigULA     <= 1'b0;
         opULA       <= 2'b01;
      end
      OPC_JALR:   begin       // 67 - jalr
         EscreveReg  <= 1'b1;
         OrigReg     <= 2'b10;         // rd <- PC+4
         LeMem       <= 1'b0;
         EscreveMem  <= 1'b0;
         OrigPC      <= 2'b10;         // PC = SaidaULA (rs1 + imm)
         OrigULA     <= 1'b1;
         opULA       <= 2'b00;
      end
      OPC_JAL:    begin       // 6F - jal
         EscreveReg  <= 1'b1;
         OrigReg     <= 2'b10;         // rd <- PC+4
         LeMem       <= 1'b0;
         EscreveMem  <= 1'b0;
         OrigPC      <= 2'b01;         // PC = PC+imm
//       OrigULA     <= 1'b;
//       opULA       <= 2'b;
      end
   endcase
end


endmodule
