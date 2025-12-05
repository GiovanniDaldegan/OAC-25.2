

`include "Parametros.v"


module Pipeline (
   input  logic        clockCPU, clockMem, reset,
   output logic [31:0] PC, Instr,
   output logic [3:0]  estado,
   
   // reg monitorado
   input  logic [4:0]  regin,
   output logic [31:0] regout
);

// fios e registradores

// TODO: substituir os pseudo-fios aí no formato fio:reg por seções dos registradores de transição

// fios da instrução
wire [6:0] opcode = IF_ID_Instr[ 6: 0];
wire [2:0] funct3 = IF_ID_Instr[14:12];
wire [6:0] funct7 = IF_ID_Instr[31:25];
wire [4:0] rs1    = IF_ID_Instr[19:15];
wire [4:0] rs2    = IF_ID_Instr[24:20];
wire [4:0] rd     = IF_ID_Instr[11: 7];

// fios de controle
wire LeMem, EscreveMem, EscreveReg, jalr;
wire [1:0] OrigRd, OrigAULA, OrigBULA, opULA; // OrigPC depende de beq, jal (ID) e jalr (EX)
wire [4:0] codULA;

// fios dos somadores
wire [31:0] PC4, PCImm;

// fios dos multiplexadores
wire [31:0] DadoEscrReg, PCEscrita, AULA, BULA;

// fio do gerador de imediatos
wire [31:0] Imm;

// fios da ULA
wire [31:0] ResULA;

// fios de leitura do banco de registradores
wire [31:0] Dado1, Dado2;

// fios da memória
wire [31:0] EnderecoMem, MemLeitura;


// registradores de transição
reg [ 95:0] IF_ID;   // 0:31 PC,  32:63 PC4, 64:95 Instr
reg [144:0] ID_EX;   // 0:31 PC4, 32:36 rd,  37:68 Dado1,  69:100 Dado2,      101:132 Imm, 133:135 WB, 136:137 MEM, 138:144 EX
reg [105:0] EX_MEM;  // 0:31 PC4, 32:36 rd,  37:68 ResULA, 69:100 Dado2,      101:103 WB,  104:105 MEM
reg [103:0] MEM_WB;  // 0:31 PC4, 32:36 rd,  37:68 ResULA, 69:100 MemLeitura, 101:103 WB

// sinais EX  0:1 OrigAULA    2:3 OrigBULA    4:5 opULA  6 jalr
// sinais MEM 0   LeMem       1   EscreveMem
// sinais WB  0   EscreveReg  1:2 OrigReg

// seções dos regs de transição
wire [31:0]
   IF_ID_PC      = IF_ID[`rIF_ID_PC],
   IF_ID_PC4     = IF_ID[`rIF_ID_PC4],   // NOTE checar se pode fazer isso
   IF_ID_Instr   = IF_ID[`rIF_ID_Instr];

wire [31:0]
            ID_EX_PC4     = ID_EX[`rID_EX_PC4],
            ID_EX_Dado1   = ID_EX[`rID_EX_Dado1],
            ID_EX_Dado2   = ID_EX[`rID_EX_Dado2],
            ID_EX_Imm     = ID_EX[`rID_EX_Imm];
wire [4:0]  ID_EX_rd      = ID_EX[`rID_EX_rd];
wire [2:0]  ID_EX_WB      = ID_EX[`rID_EX_WB];
wire [1:0]  ID_EX_MEM     = ID_EX[`rID_EX_MEM];
wire [6:0]  ID_EX_EX      = ID_EX[`rID_EX_EX];

wire [31:0] EX_MEM_PC4    = EX_MEM[`rEX_MEM_PC4],
            EX_MEM_ResULA = EX_MEM[`rEX_MEM_ResULA],
            EX_MEM_Dado2  = EX_MEM[`rEX_MEM_Dado2];
wire [4:0]  EX_MEM_rd     = EX_MEM[`rEX_MEM_rd];
wire [2:0]  EX_MEM_WB     = EX_MEM[`rEX_MEM_WB];
wire [1:0]  EX_MEM_MEM    = EX_MEM[`rEX_MEM_MEM];

wire [31:0]
            MEM_WB_PC4          = MEM_WB[`rMEM_WB_PC4],
            MEM_WB_ResULA       = MEM_WB[`rMEM_WB_ResULA],
            MEM_WB_MemLeitura   = MEM_WB[`rMEM_WB_MemLeitura];
wire [4:0]  MEM_WB_rd           = MEM_WB[`rMEM_WB_rd];
wire [2:0]  MEM_WB_WB           = MEM_WB[`rMEM_WB_WB];

/*
wire [31:0] IF_ID_PC, IF_ID_PC4, IF_ID_Instr, ID_EX_PC4, ID_EX_Dado1, ID_EX_Dado2, ID_EX_Imm,
            EX_MEM_PC4, EX_MEM_ResULA, EX_MEM_Dado2, MEM_WB_PC4, MEM_WB_ResULA, MEM_WB_MemLeitura;
wire [4:0] ID_EX_rd, EX_MEM_rd, MEM_WB_rd;
wire [2:0] ID_EX_WB, EX_MEM_WB, MEM_WB_WB;
wire [1:0] ID_EX_MEM, EX_MEM_MEM;
wire [6:0] ID_EX_EX;
*/


// módulos

adder SomaPC4   (.iA(PC), .iB(32'd4), .out(PC4));
adder SomaPCIMM (.iA(PC), .iB(Imm),   .out(PCImm));

mux4 muxOrigPC (.entr0(PC4),           .entr1(PCImm),             .entr2(ResULA),     .sel(),               .saida(PCEscrita));
mux4 muxOrigRd (.entr0(MEM_WB_ResULA), .entr1(MEM_WB_MemLeitura), .entr2(MEM_WB_PC4), .sel(MEM_WB_OrigRd),  .saida(DadoEscrReg));
mux4 muxOrigA  (.entr0(ID_EX_Dado1),   .entr1(0),                                     .sel(ID_EX_OrigAULA), .saida(AULA));
mux4 muxOrigB  (.entr0(ID_EX_Dado2),   .entr2(Imm),                                   .sel(ID_EX_OrigBULA), .saida(BULA));


ControlePipe Controle (
   .opcode(opcode),
   .EscrevePC(EscrevePC), .EscrevePCCond(EscrevePCCond), .jalr(jalr),
   .LeMem(LeMem), .EscreveMem(EscreveMem), .EscreveReg(EscreveReg),
   .OrigReg(OrigReg), .OrigAULA(OrigAULA), .OrigBULA(OrigBULA), .opULA(opULA), //.OrigPC(OrigPC)
);

ControleULA ControleULA (.opULA(ID_EX_opULA), .funct3(ID_EX_funct3), .funct7(ID_EX_funct7), .codULA(codULA));

ImmGen ImmGen (.iInstrucao(IF_ID_Instr), .oImm(Imm));

BancoReg BancoReg (
   .iCLK(clockCPU), .iRST(reset), .iRegWrite(EscreveReg),
   .iReadRegister1(rs1), .iReadRegister2(rs2), .iWriteRegister(rd),
   .iWriteData(DadoEscrReg), .oReadData1(Dado1), .oReadData2(Dado2),
   .iRegDispSelect(regin), .oRegDisp(regout)
);

ULA ULA (.iControl(codULA), .iA(AULA), .iB(BULA), .oResult(ResULA));

// memórias
ramI MemI (.address(PC[11:2]), .clock(clockMem), .data(), .wren(1'b0), .q(Instr));
ramD MemD (.address(ResULA[11:2]), .clock(clockMem), .data(DadoEscrMem), .wren(EscreveMem), .q(MemLeitura));


initial begin
   PC     <= 32'h0040_0000;
   Instr  <= 32'b0;
   regout <= 32'b0;
end

always @(posedge clockCPU  or posedge reset) begin
   if(reset) begin
      PC <= 32'h0040_0000;
   end
   else
      MEM_WB [`rMEM_WB_PC4]         = EX_MEM_PC4;
      MEM_WB [`rMEM_WB_rd]          = EX_MEM_rd;
      MEM_WB [`rMEM_WB_ResULA]      = EX_MEM_ResULA;
      MEM_WB [`rMEM_WB_MemLeitura]  = MemLeitura;
      MEM_WB [`rMEM_WB_WB]          = EX_MEM_WB;
      
      EX_MEM [`rEX_MEM_PC4]         = ID_EX_PC4;
      EX_MEM [`rEX_MEM_rd]          = ID_EX_rd;
      EX_MEM [`rEX_MEM_ResULA]      = ResULA;
      EX_MEM [`rEX_MEM_Dado2]       = ID_EX_Dado2;
      EX_MEM [`rEX_MEM_WB]          = ID_EX_WB;
      EX_MEM [`rEX_MEM_MEM]         = ID_EX_MEM;
      
      ID_EX  [`rID_EX_PC4]          = IF_ID_PC4;
      ID_EX  [`rID_EX_rd]           = rd;
      ID_EX  [`rID_EX_Dado1]        = Dado1;
      ID_EX  [`rID_EX_Dado2]        = Dado2;
      ID_EX  [`rID_EX_Imm]          = Imm;
      ID_EX  [`rID_EX_WB]           = {EscreveReg, OrigReg};   //WB
      ID_EX  [`rID_EX_MEM]          = {LeMem, EscreveMem};     //MEM
      ID_EX  [`rID_EX_EX]           = {OrigAULA, OrigBULA, opULA, jalr}; //EX
      
      IF_ID  [`rIF_ID_PC]           = PC;
      IF_ID  [`rIF_ID_PC4]          = PC4;
      IF_ID  [`rIF_ID_Instr]        = Instr;
end

endmodule
