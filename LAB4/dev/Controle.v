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
 * Colinha das entradas dos muxs
 * muxOrig Reg    muxOrig PC     muxOrig A      muxOrig A
 * 00 SaidaULA    00 PC4         00 Dado1       00 Dado2
 * 01 MemData     01 PCImm       01 0           01 Imm
 * 10 PC4         10 ResULA      10             10 
 * 11 Imm         11             11             11 
 */

`include "Parametros.v"

module ControlePipe (
   input  wire [6:0] opcode,
   output wire       EscreveReg, LeMem, EscreveMem, beq, jal, jalr,
   output wire [1:0] OrigReg, OrigAULA, OrigBULA, opULA
);

initial begin
   EscreveReg <= 1'b0;
   LeMem      <= 1'b0;
   EscreveMem <= 1'b0;
end

always @(*) begin
   case (opcode)
      OPC_RTYPE:  begin       // 33 - add sub slt and or
         EscreveReg  <= 1'b1;
         LeMem       <= 1'b0;
         EscreveMem  <= 1'b0;
         beq         <= 1'b0;
         jal         <= 1'b0;
         jalr        <= 1'b0;
         
         OrigReg     <= 2'b00;
         OrigAULA    <= 2'b00;
         OrigBULA    <= 2'b00;
         opULA       <= 2'b10;
      end
      OPC_OPIMM:  begin       // 13 - addi
         EscreveReg  <= 1'b1;
         LeMem       <= 1'b0;
         EscreveMem  <= 1'b0;
         beq         <= 1'b0;
         jal         <= 1'b0;
         jalr        <= 1'b0;
         
         OrigReg     <= 2'b00;
         OrigAULA    <= 2'b00;
         OrigBULA    <= 2'b01;
         opULA       <= 2'b00;
      end
      OPC_LUI:    begin       // 37 - lui
         EscreveReg  <= 1'b1;
         LeMem       <= 1'b0;
         EscreveMem  <= 1'b0;
         beq         <= 1'b0;
         jal         <= 1'b0;
         jalr        <= 1'b0;
         
         OrigReg     <= 2'b00;
         OrigAULA    <= 2'b01;
         OrigBULA    <= 2'b01;
         opULA       <= 2'b00;   // melhor escrever o imediato direto no rd...
      end
      OPC_LOAD:   begin       // 03 - lw
         EscreveReg  <= 1'b1;
         LeMem       <= 1'b1;
         EscreveMem  <= 1'b0;
         beq         <= 1'b0;
         jal         <= 1'b0;
         jalr        <= 1'b0;
         
         OrigReg     <= 2'b01;
         /*
         OrigAULA    <= 2'b;
         OrigBULA    <= 2'b;
         opULA       <= 2'b;
         */
      end
      OPC_STORE:  begin       // 23 - sw
         EscreveReg  <= 1'b0;
         LeMem       <= 1'b0;
         EscreveMem  <= 1'b1;
         beq         <= 1'b0;
         jal         <= 1'b0;
         jalr        <= 1'b0;
         
         /*
         OrigReg     <= 2'b;
         OrigAULA    <= 2'b;
         OrigBULA    <= 2'b;
         opULA       <= 2'b;
         */
      end
      OPC_BRANCH: begin       // 63 - beq
         EscreveReg  <= 1'b0;
         LeMem       <= 1'b0;
         EscreveMem  <= 1'b0;
         beq         <= 1'b1;
         jal         <= 1'b0;
         jalr        <= 1'b0;
         
         /*
         OrigReg     <= 2'b;
         OrigAULA    <= 2'b;
         OrigBULA    <= 2'b;
         opULA       <= 2'b;
         */
      end
      OPC_JAL:    begin       // 6F - jal
         EscreveReg  <= 1'b1;
         LeMem       <= 1'b0;
         EscreveMem  <= 1'b0;
         beq         <= 1'b0;
         jal         <= 1'b1;
         jalr        <= 1'b0;
         
         OrigReg     <= 2'b10;
         /*
         OrigAULA    <= 2'b;
         OrigBULA    <= 2'b;
         opULA       <= 2'b;
         */
      end
      OPC_JALR:   begin       // 67 - jalr
         EscreveReg  <= 1'b1;
         LeMem       <= 1'b0;
         EscreveMem  <= 1'b0;
         beq         <= 1'b0;
         jal         <= 1'b0;
         jalr        <= 1'b1;
         
         OrigReg     <= 2'b10;
         OrigAULA    <= 2'b00;
         OrigBULA    <= 2'b01;
         opULA       <= 2'b00;
      end
   endcase
end

endmodule
