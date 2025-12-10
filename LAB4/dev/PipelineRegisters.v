/*
 * Registradores de pipeline - RV32I reduzida
 * IF_ID:   0:31 PC,  32:63 PC4, 64:95 Instr
 * ID_EX:   0:31 PC4, 32:36 rd,  37:68 Dado1,  69:100 Dado2,      101:132 Imm, 133:135 WB, 136:137 MEM, 138:154 EX
 * EX_MEM:  0:31 PC4, 32:36 rd,  37:68 ResULA, 69:100 Dado2,      101:132 Imm, 133:135 WB, 136:137 MEM
 * MEM_WB:  0:31 PC4, 32:36 rd,  37:68 ResULA, 69:100 MemLeitura, 101:132 Imm, 133:135 WB
 *
 *
 *
 */
module IF_ID (
   input wire clock, reset,
   input wire [31:0] iPC, iPC4, iInstr,
   
   output reg [31:0] oPC, oPC4, oInstr
);

always @(posedge clock) begin
   if (reset) begin
      oPC      <= 0; 
      oPC4     <= 0;
      oInstr   <= 0;
   end
   else begin
      oPC      <= iPC; 
      oPC4     <= iPC4;
      oInstr   <= iInstr;
   end
end

endmodule

module ID_EX (
   input wire clock, reset,
   input wire [31:0] iPC4, iDado1, iDado2, iImm,
   input wire [ 4:0] ird,
   input wire [ 2:0] iWB,
   input wire [ 1:0] iMEM,
   input wire [16:0] iEX,
   
   output reg [31:0] oPC4, oDado1, oDado2, oImm,
   output reg [ 4:0] ord,
   output reg [ 2:0] oWB,
   output reg [ 1:0] oMEM,
   output reg [16:0] oEX
);

always @(posedge clock) begin
   if (reset) begin
      oPC4     <= 0;
      oDado1   <= 0;
      oDado2   <= 0;
      oImm     <= 0;
      ord      <= 0;
      oWB      <= 0;
      oMEM     <= 0;
      oEX      <= 0;
   end
   else begin
      oPC4     <= iPC4;
      oDado1   <= iDado1;
      oDado2   <= iDado2;
      oImm     <= iImm;
      ord      <= ird;
      oWB      <= iWB;
      oMEM     <= iMEM;
      oEX      <= iEX;
   end
end


endmodule


module EX_MEM (
   input wire clock, reset,
   input wire [31:0] iPC4, iResULA, iDado2, iImm,
   input wire [ 4:0] ird,
   input wire [ 2:0] iWB,
   input wire [ 1:0] iMEM,
   
   output reg [31:0] oPC4, oResULA, oDado2, oImm,
   output reg [ 4:0] ord,
   output reg [ 2:0] oWB,
   output reg [ 1:0] oMEM
);

always @(posedge clock) begin
   if (reset) begin
      oPC4     <= 0;
      oResULA  <= 0;
      oDado2   <= 0;
      oImm     <= 0;
      ord      <= 0;
      oWB      <= 0;
      oMEM     <= 0;
   end
   else begin
      oPC4     <= iPC4;
      oResULA  <= iResULA;
      oDado2   <= iDado2;
      oImm     <= iImm;
      ord      <= ird;
      oWB      <= iWB;
      oMEM     <= iMEM;
   end
end

endmodule

module MEM_WB (
   input wire clock, reset,
   input wire [31:0] iPC4, iResULA, iMemLeitura, iImm,
   input wire [ 4:0] ird,
   input wire [ 2:0] iWB,
   
   output reg [31:0] oPC4, oResULA, oMemLeitura, oImm,
   output reg [ 4:0] ord,
   output reg [ 2:0] oWB
);

always @(posedge clock) begin
   if (reset) begin
      oPC4        <= 0;
      oResULA     <= 0;
      oMemLeitura <= 0;
      oImm        <= 0;
      ord         <= 0;
      oWB         <= 0;
   end
   else begin
      oPC4        <= iPC4;
      oResULA     <= iResULA;
      oMemLeitura <= iMemLeitura;
      oImm        <= iImm;
      ord         <= ird;
      oWB         <= iWB;
   end
end

endmodule
