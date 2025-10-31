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
 * J 6F: jal
 * I 67: jalr
 */

`ifndef PARAM
    `include "Parametros.v"
`endif

module (
   input  wire [6:0] opcode,
   output wire       Mem2Reg, LeMem, Branch, OrigULA, EscreveReg,
   output wire [1:0] opULA
);


always @(*)
begin
   case (opcode)
      OPC_RTYPE:  // 33
         Mem2Reg     <= 1b';
         LeMem       <= 1b';
         Branch      <= 1b';
         OrigULA     <= 1b';
         EscreveReg  <= 1b';
         opULA       <= 2b';

      OPC_OPIMM:  // 13
         Mem2Reg     <= 1b';
         LeMem       <= 1b';
         Branch      <= 1b';
         OrigULA     <= 1b';
         EscreveReg  <= 1b';
         opULA       <= 2b';

      OPC_LUI:    // 37
         Mem2Reg     <= 1b';
         LeMem       <= 1b';
         Branch      <= 1b';
         OrigULA     <= 1b';
         EscreveReg  <= 1b';
         opULA       <= 2b';

      OPC_LOAD:   // 03
         Mem2Reg     <= 1b';
         LeMem       <= 1b';
         Branch      <= 1b';
         OrigULA     <= 1b';
         EscreveReg  <= 1b';
         opULA       <= 2b';

      OPC_STORE:  // 23
         Mem2Reg     <= 1b';
         LeMem       <= 1b';
         Branch      <= 1b';
         OrigULA     <= 1b';
         EscreveReg  <= 1b';
         opULA       <= 2b';

      OPC_BRANCH: // 63
         Mem2Reg     <= 1b';
         LeMem       <= 1b';
         Branch      <= 1b';
         OrigULA     <= 1b';
         EscreveReg  <= 1b';
         opULA       <= 2b';

      OPC_JALR:   // 67
         Mem2Reg     <= 1b';
         LeMem       <= 1b';
         Branch      <= 1b';
         OrigULA     <= 1b';
         EscreveReg  <= 1b';
         opULA       <= 2b';

      OPC_JAL:    // 6F
         Mem2Reg     <= 1b';
         LeMem       <= 1b';
         Branch      <= 1b';
         OrigULA     <= 1b';
         EscreveReg  <= 1b';
         opULA       <= 2b';
   endcase
end


endmodule
