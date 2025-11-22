/* 
 * Máquina de estados de controle do processador multiciclo da ISA RV32I
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

module ControleMulti (
   input  wire [6:0] opcode,
   input  wire       CLK, RST, Zero,
   output wire       EscrevePC, EscrevePCCond, EscrevePCB, IouD, EscreveIR,
                     LeMem, EscreveMem, EscreveReg,
   output wire [1:0] OrigPC, OrigRd, OrigAULA, OrigBULA, opULA,
   output reg  [4:0] estado
);

// ---------------------------
// Definição dos estados
// ---------------------------
localparam  IF1         = 6'd0,
            IF2         = 6'd1,
            ID          = 6'd2,

            R_EX        = 6'd3,
            I_EX        = 6'd4,
               ULA_WB   = 6'd9,
            
            MEM_EX      = 6'd5,
               SW_MEM1  = 6'd10,
               SW_MEM2  = 6'd11,
               
               LW_MEM1  = 6'd12,
               LW_MEM2  = 6'd13,
               LW_WB    = 6'd14,
            
            BEQ_EX      = 6'd6,
            JAL_EX      = 6'd7,
            
            JALR_WB     = 6'd8,
               JALR_EX  = 6'd15;


reg [4:0] prox_estado = 5'b0;

always @(posedge CLK or posedge RST) begin
   if (RST)
      estado   <= 5'b0;
   else
      estado   <= prox_estado;
   
   case(estado)
      IF1: begin
         EscrevePC      <= 1'b1;    // atualiza PC
         EscrevePCCond  <= 1'b0;    // não é branch
         EscrevePCB     <= 1'b1;    // atualiza PC
         IouD           <= 1'b0;    // leitura de instrução
         EscreveIR      <= 1'b1;    // atualiza a instrução atual
         LeMem          <= 1'b1;    // lê da memória
         EscreveMem     <= 1'b0;    // não escreve na memória
         EscreveReg     <= 1'b0;    // não escreve no rd
         
         OrigPC         <= 2'b00;   // PC vem da ULA
         // OrigRd         <= 2'b00;// não importa rd
         OrigAULA       <= 2'b10;   // A ULA: PC
         OrigBULA       <= 2'b01;   // B ULA: 4
         opULA          <= 2'b00;   // PC+4
         
         prox_estado    <= IF2;
      end
      IF2: begin
         /*
         EscrevePC      <= 1'b;
         EscrevePCCond  <= 1'b;
         EscrevePCB     <= 1'b;
         IouD           <= 1'b;
         EscreveIR      <= 1'b;
         LeMem          <= 1'b;
         EscreveMem     <= 1'b;
         EscreveReg     <= 1'b;
         
         OrigPC         <= 2'b;
         OrigRd         <= 2'b;
         OrigAULA       <= 2'b;
         OrigBULA       <= 2'b;
         opULA          <= 2'b;
         */
         prox_estado = ID;
      end
      
      ID: begin
         EscrevePC      <= 1'b0;
         EscrevePCCond  <= 1'b0;
         EscrevePCB     <= 1'b0;
         //IouD           <= 1'b;
         EscreveIR      <= 1'b0;
         LeMem          <= 1'b0;
         EscreveMem     <= 1'b0;
         EscreveReg     <= 1'b0;
         
         /*
         OrigPC         <= 2'b;
         OrigRd         <= 2'b;
         */
         OrigAULA       <= 2'b10;   // PCBack
         OrigBULA       <= 2'b10;   // imm
         opULA          <= 2'b00;   // PCBack+imm
         
         case(opcode)
            OPC_RTYPE:  prox_estado <= R_EX;
            OPC_OPIMM,
            OPC_LUI:    prox_estado <= I_EX;
            OPC_LOAD,
            OPC_STORE:  prox_estado <= MEM_EX;
            OPC_BRANCH: prox_estado <= BEQ_EX;
            OPC_JAL:    prox_estado <= JAL_EX;
            OPC_JALR:   prox_estado <= JALR_WB;
            default:    prox_estado <= IF1;       // mandar pra PC + 4?
         endcase
      end
      
      R_EX: begin
         EscrevePC      <= 1'b0;
         EscrevePCCond  <= 1'b0;
         EscrevePCB     <= 1'b0;
         //IouD           <= 1'b;
         EscreveIR      <= 1'b0;
         LeMem          <= 1'b0;
         EscreveMem     <= 1'b0;
         EscreveReg     <= 1'b0;
         
         /*
         OrigPC         <= 2'b;
         OrigRd         <= 2'b;
         */
         OrigAULA       <= 2'b01;   // A
         OrigBULA       <= 2'b00;   // B
         opULA          <= 2'b10;   // A op B
         
         prox_estado    <= ULA_WB;
      end
      
      I_EX: begin
         EscrevePC      <= 1'b0;
         EscrevePCCond  <= 1'b0;
         EscrevePCB     <= 1'b0;
         //IouD           <= 1'b;
         EscreveIR      <= 1'b0;
         LeMem          <= 1'b0;
         EscreveMem     <= 1'b0;
         EscreveReg     <= 1'b0;
         
         /*
         OrigPC         <= 2'b;
         OrigRd         <= 2'b;
         */
         OrigAULA       <= 2'b01;   // A
         OrigBULA       <= 2'b10;   // imm
         opULA          <= 2'b00;   // A + imm
         
         prox_estado    <= ULA_WB;
      end
      
      ULA_WB: begin
         EscrevePC      <= 1'b0;
         EscrevePCCond  <= 1'b0;
         EscrevePCB     <= 1'b0;
         //IouD           <= 1'b;
         EscreveIR      <= 1'b0;
         LeMem          <= 1'b0;
         EscreveMem     <= 1'b0;
         EscreveReg     <= 1'b1;    // escreve rd
         
         //OrigPC         <= 2'b;
         OrigRd         <= 2'b00;   // [rd] <= SaidaULA
         /*
         OrigAULA       <= 2'b;
         OrigBULA       <= 2'b;
         opULA          <= 2'b;
         */
         
         prox_estado    <= IF1;
      end
      
      MEM_EX: begin
         EscrevePC      <= 1'b0;
         EscrevePCCond  <= 1'b0;
         EscrevePCB     <= 1'b0;
         //IouD           <= 1'b;
         EscreveIR      <= 1'b0;
         LeMem          <= 1'b0;
         EscreveMem     <= 1'b0;
         EscreveReg     <= 1'b0;
         
         /*
         OrigPC         <= 2'b;
         OrigRd         <= 2'b;
         */
         OrigAULA       <= 2'b01;   // rs1
         OrigBULA       <= 2'b10;   // imm
         opULA          <= 2'b00;   // SaidaULA <= [rs1] + imm
         
         case (opcode)
            OPC_STORE: prox_estado <= SW_MEM1;
            OPC_LOAD:  prox_estado <= LW_MEM1;
         endcase
      end
      
      SW_MEM1: begin
         EscrevePC      <= 1'b0;
         EscrevePCCond  <= 1'b0;
         EscrevePCB     <= 1'b0;
         IouD           <= 1'b1;
         EscreveIR      <= 1'b0;
         LeMem          <= 1'b0;
         EscreveMem     <= 1'b1;    // será q posso retirar em um dos estados?
         EscreveReg     <= 1'b0;
         
         /*
         OrigPC         <= 2'b;
         OrigRd         <= 2'b;
         OrigAULA       <= 2'b;
         OrigBULA       <= 2'b;
         opULA          <= 2'b;
         */
         
         prox_estado    <= SW_MEM2;
      end
      
      SW_MEM2: begin
         EscrevePC      <= 1'b0;
         EscrevePCCond  <= 1'b0;
         EscrevePCB     <= 1'b0;
         IouD           <= 1'b1;
         EscreveIR      <= 1'b0;
         LeMem          <= 1'b0;
         EscreveMem     <= 1'b1;    // escreve na memória
         EscreveReg     <= 1'b0;
         /*
         OrigPC         <= 2'b;
         OrigRd         <= 2'b;
         OrigAULA       <= 2'b;
         OrigBULA       <= 2'b;
         opULA          <= 2'b;
         */
         
         prox_estado    <= IF1;
      end
      
      LW_MEM1: begin
         EscrevePC      <= 1'b0;
         EscrevePCCond  <= 1'b0;
         EscrevePCB     <= 1'b0;
         IouD           <= 1'b1;
         EscreveIR      <= 1'b0;
         LeMem          <= 1'b1;
         EscreveMem     <= 1'b0;
         EscreveReg     <= 1'b0;
         
         /*
         OrigPC         <= 2'b;
         OrigRd         <= 2'b;
         OrigAULA       <= 2'b;
         OrigBULA       <= 2'b;
         opULA          <= 2'b;
         */
         
         prox_estado    <= LW_MEM2;
      end
      
      LW_MEM2: begin
         EscrevePC      <= 1'b0;
         EscrevePCCond  <= 1'b0;
         EscrevePCB     <= 1'b0;
         IouD           <= 1'b1;
         EscreveIR      <= 1'b0;
         LeMem          <= 1'b1;
         EscreveMem     <= 1'b0;
         EscreveReg     <= 1'b0;
         
         /*
         OrigPC         <= 2'b;
         OrigRd         <= 2'b;
         OrigAULA       <= 2'b;
         OrigBULA       <= 2'b;
         opULA          <= 2'b;
         */
         
         prox_estado    <= LW_WB;
      end
      
      LW_WB: begin
         EscrevePC      <= 1'b0;
         EscrevePCCond  <= 1'b0;
         EscrevePCB     <= 1'b0;
         IouD           <= 1'b0;
         EscreveIR      <= 1'b0;
         LeMem          <= 1'b0;
         EscreveMem     <= 1'b0;
         EscreveReg     <= 1'b1;
         
         //OrigPC         <= 2'b;
         OrigRd         <= 2'b10;   // [rd] <= Dado
         /*
         OrigAULA       <= 2'b;
         OrigBULA       <= 2'b;
         opULA          <= 2'b;
         */
         
         prox_estado    <= IF1;
      end
      
      BEQ_EX: begin
         EscrevePC      <= 1'b0;
         EscrevePCCond  <= 1'b1;
         EscrevePCB     <= 1'b0;
         //IouD           <= 1'b;
         EscreveIR      <= 1'b0;
         LeMem          <= 1'b0;
         EscreveMem     <= 1'b0;
         EscreveReg     <= 1'b0;
         
         OrigPC         <= 2'b01;
         /*
         OrigRd         <= 2'b;
         OrigAULA       <= 2'b;
         OrigBULA       <= 2'b;
         opULA          <= 2'b;
         */
         
         prox_estado    <= IF1;
      end
      
      JAL_EX: begin
         EscrevePC      <= 1'b1;
         EscrevePCCond  <= 1'b0;
         EscrevePCB     <= 1'b0;
         //IouD           <= 1'b;
         EscreveIR      <= 1'b0;
         LeMem          <= 1'b0;
         EscreveMem     <= 1'b0;
         EscreveReg     <= 1'b1;
         
         OrigPC         <= 2'b00;
         OrigRd         <= 2'b00;
         /*
         OrigAULA       <= 2'b;
         OrigBULA       <= 2'b;
         opULA          <= 2'b;
         */
         
         prox_estado   <= IF1;
      end
      
      JALR_WB: begin
         EscrevePC      <= 1'b0;
         EscrevePCCond  <= 1'b0;
         EscrevePCB     <= 1'b0;
         //IouD           <= 1'b;
         EscreveIR      <= 1'b0;
         LeMem          <= 1'b0;
         EscreveMem     <= 1'b0;
         EscreveReg     <= 1'b1;
         
         //OrigPC         <= 2'b;
         OrigRd         <= 2'b00;   // [rd]     <= PC+4
         OrigAULA       <= 2'b01;   // SaidaULA <= rs1+imm
         OrigBULA       <= 2'b10;
         opULA          <= 2'b00;
         
         prox_estado    <= JALR_EX;
      end
      
      JALR_EX: begin
         EscrevePC      <= 1'b1;
         EscrevePCCond  <= 1'b0;
         EscrevePCB     <= 1'b0;
         //IouD           <= 1'b;
         EscreveIR      <= 1'b0;
         LeMem          <= 1'b0;
         EscreveMem     <= 1'b0;
         EscreveReg     <= 1'b0;
         
         OrigPC         <= 2'b00;   // PC <= SaidaULA (rs1+imm)
         /*
         OrigRd         <= 2'b;
         OrigAULA       <= 2'b;
         OrigBULA       <= 2'b;
         opULA          <= 2'b;
         */
         prox_estado    <= IF1;
      end
      
   endcase
end

/*
always @(*)
begin
   case (opcode)
      OPC_RTYPE:  begin       // 33 - add sub slt and or
         EscreveReg  <= 1'b1;
         OrigReg     <= 2'b00;
         LeMem       <= 1'b0;
         EscreveMem  <= 1'b0;
         OrigPC      <= 2'b00;
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
         OrigReg     <= 2'b00;         // rd = SaidaULA
         LeMem       <= 1'b0;
         EscreveMem  <= 1'b0;
         OrigPC      <= 2'b00;
         OrigULA     <= 1'b1;
         opULA       <= 2'b00;
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
         OrigPC      <= 2'b00;         // PC = PC + 4
         OrigULA     <= 1'b1;
         opULA       <= 2'b00;
      end
      OPC_BRANCH: begin       // 63 - beq
         EscreveReg  <= 1'b0;
         //OrigReg     <= 2'b00;
         LeMem       <= 1'b0;
         EscreveMem  <= 1'b0;
         OrigPC      <= 2'b01 && {1'b0, Zero};  // PC = PC + imm
         OrigULA     <= 1'b0;
         opULA       <= 2'b01;
      end
      OPC_JALR:   begin       // 67 - jalr
         EscreveReg  <= 1'b1;
         OrigReg     <= 2'b10;         // rd = PC + 4
         LeMem       <= 1'b0;
         EscreveMem  <= 1'b0;
         OrigPC      <= 2'b10;         // PC = SaidaULA (rs1 + imm)
         OrigULA     <= 1'b1;
         opULA       <= 2'b00;
      end
      OPC_JAL:    begin       // 6F - jal
         EscreveReg  <= 1'b1;
         OrigReg     <= 2'b10;         // rd = PC + 4
         LeMem       <= 1'b0;
         EscreveMem  <= 1'b0;
         OrigPC      <= 2'b01;         // PC = PC + imm
//       OrigULA     <= 1'b;
//       opULA       <= 2'b;
      end
   endcase
end
*/

endmodule
