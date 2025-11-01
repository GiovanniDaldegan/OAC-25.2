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
 */

`ifndef PARAM
    `include "Parametros.v"
`endif

module Controle (
   input  wire [6:0] opcode,
   output wire       Mem2Reg, LeMem, EscreveMem, Branch, OrigULA, EscreveReg,
   output wire [1:0] opULA
);


always @(*)
begin
   case (opcode)
      OPC_RTYPE:  begin       // 33 - add sub slt and or
         EscreveReg  <= 1'b1;
         Mem2Reg     <= 1'b0;
         LeMem       <= 1'b0;
         EscreveMem  <= 1'b0;
         Branch      <= 1'b0;
         OrigULA     <= 1'b0;
         opULA       <= 2'b10;
      end
      OPC_OPIMM:  begin       // 13 - addi
         EscreveReg  <= 1'b1;
         Mem2Reg     <= 1'b0;
         LeMem       <= 1'b0;
         EscreveMem  <= 1'b0;
         Branch      <= 1'b0;
         OrigULA     <= 1'b1;
         opULA       <= 2'b00;
      end
      OPC_LUI:    begin       // 37 - lui
         EscreveReg  <= 1'b1;
         Mem2Reg     <= 1'b0;
         LeMem       <= 1'b0;
         EscreveMem  <= 1'b0;
         Branch      <= 1'b0;
         OrigULA     <= 1'b1;
         opULA       <= 2'b00;
      end
      OPC_LOAD:   begin       // 03 - lw
         EscreveReg  <= 1'b1;
         Mem2Reg     <= 1'b1;
         LeMem       <= 1'b1;
         EscreveMem  <= 1'b0;
         Branch      <= 1'b0;
         OrigULA     <= 1'b1;
         opULA       <= 2'b00;
      end
      OPC_STORE:  begin       // 23 - sw
         EscreveReg  <= 1'b0;
         Mem2Reg     <= 1'b0;
         LeMem       <= 1'b0;
         EscreveMem  <= 1'b1;
         Branch      <= 1'b0;
         OrigULA     <= 1'b1;
         opULA       <= 2'b00;
      end
      OPC_BRANCH: begin       // 63 - beq
         EscreveReg  <= 1'b0;
         Mem2Reg     <= 1'b0;
         LeMem       <= 1'b0;
         EscreveMem  <= 1'b0;
         Branch      <= 1'b1;
         OrigULA     <= 1'b0;
         opULA       <= 2'b01;
      end
      OPC_JALR:   begin       // 67 - jalr
         EscreveReg  <= 1'b1;
         Mem2Reg     <= 1'b0;
         LeMem       <= 1'b0;
         EscreveMem  <= 1'b0;
         Branch      <= 1'b0;
         OrigULA     <= 1'b1;
         opULA       <= 2'b00;
      end
      OPC_JAL:    begin       // 6F - jal
         EscreveReg  <= 1'b1;
         Mem2Reg     <= 1'b0;
         LeMem       <= 1'b0;
         EscreveMem  <= 1'b0;
         Branch      <= 1'b1;    // PC + {imm, 0}
//       OrigULA     <= 1'b;
//       opULA       <= 2'b;
      end
   endcase
end


endmodule
