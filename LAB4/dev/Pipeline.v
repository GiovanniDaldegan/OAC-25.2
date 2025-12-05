`ifndef PARAM
	`include "Parametros.v"
`endif

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
wire [6:0] opcode = Instr:IF_ID[ 6: 0];
wire [2:0] funct3 = Instr:IF_ID[14:12];
wire [6:0] funct7 = Instr:IF_ID[31:25];
wire [4:0] rs1    = Instr:IF_ID[19:15];
wire [4:0] rs2    = Instr:IF_ID[24:20];
wire [4:0] rd     = Instr:IF_ID[11: 7];

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


// módulos
adder SomaPC4   (.iA(PC), .iB(32'b4), .out(PC4));
adder SomaPCIMM (.iA(PC), .iB(Imm),   .out(PCImm));

mux4 muxOrigPC    (.entr0(PC4),  .entr1(PCImm), .entr2(ResULA) .sel(),   .saida(PCEscrita));
mux4 muxOrigRd    (.entr0(ResULA:MEM_WB), .entr1(MemLeitura:MEM_WB), .entr2(PC4:IF_ID), .sel(OrigRd:MEM_WB), .saida(DadoEscrReg));
mux4 muxOrigA     (.entr0(Dado1:ID_EX),   .entr1(0), .sel(OrigAULA:ID_EX), .saida(AULA));
mux4 muxOrigB     (.entr0(Dado2:ID_EX),   .entr2(Imm),   .sel(OrigBULA:ID_EX), .saida(BULA));


ControlePipe Controle (
   .opcode(opcode),
   .EscrevePC(EscrevePC), .EscrevePCCond(EscrevePCCond), .jalr(jalr)
   .LeMem(LeMem), .EscreveMem(EscreveMem), .EscreveReg(EscreveReg),
   .OrigRd(OrigRd), .OrigAULA(OrigAULA), .OrigBULA(OrigBULA), .opULA(opULA), //.OrigPC(OrigPC)
);

ControleULA ControleULA (.opULA(opULA:ID_MEM), .funct3(funct3:ID_MEM), .funct7(funct7:ID_MEM), .codULA(codULA));

ImmGen ImmGen (.iInstrucao(Instr), .oImm(Imm));

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
      // TODO: criar fios para cada dado ou puxar do reg de transição anterior
      MEM_WB [  0: 31] = PC4;          // [começo] puxar de EX_MEM
      MEM_WB [ 32: 36] = rd;
      MEM_WB [ 37: 68] = ResULA;
      MEM_WB [ 69:100] = MemLeitura;   // [fim]
      MEM_WB [101:103] = WB;           // abrir WB, MEM, EX
      
      EX_MEM [  0: 31] = PC4;          // puxar de ID_EX
      EX_MEM [ 32: 36] = rd;           // puxar de ID_EX
      EX_MEM [ 37: 68] = ResULA;
      EX_MEM [ 69:100] = Dado2;        // [começo] puxar de ID_EX
      EX_MEM [101:103] = WB;
      EX_MEM [104:105] = MEM;          // [fim]
      
      ID_EX [  0: 31] = PC4;           // puxar de IF_ID
      ID_EX [ 32: 36] = rd;
      ID_EX [ 37: 68] = Dado1;
      ID_EX [ 69:100] = Dado2;
      ID_EX [101:132] = Imm;
      ID_EX [133:135] = WB;
      ID_EX [136:137] = MEM;
      ID_EX [138:144] = EX;
      
      IF_ID [ 0:31] = PC;
      IF_ID [32:63] = PC4;
      IF_ID [64:95] = Instr;
end

endmodule
