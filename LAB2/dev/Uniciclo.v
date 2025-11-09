`ifndef PARAM
    `include "Parametros.v"
`endif

module Uniciclo (
    input  logic        clockCPU, clockMem,
    input  logic        reset,
    input  logic [4:0]  RegIn,
    output logic [31:0] PC, Instr, RegOut
    );
    
    
initial
begin
   PC      <= 32'h0040_0000;
   Instr   <= 32'b0;
   RegOut  <= 32'b0;
end

// fios da instrução
wire [6:0] opcode = Instr[6:0];
wire [2:0] funct3 = Instr[14:12];
wire [6:0] funct7 = Instr[31:25];
wire [4:0] rs1    = Instr[19:15];
wire [4:0] rs2    = Instr[24:20];
wire [4:0] rd     = Instr[11:7];

// fios de controle
wire Mem2Reg, LeMem, EscreveMem, Branch, OrigULA, EscreveReg;
wire [1:0] ALUop;
wire [3:0] codULA;

// fio do gerador de imediatos
wire [31:0] Imm;

// fios dos multiplexadores
wire [31:0] DadoEscrita, PCEscrita, OperadorULA;

// fios dos somadores
wire [31:0] PC4, PCImm;

// fios da ULA
wire Zero;
wire [31:0] SaidaULA;

// fios de leitura do banco de registradores
wire [31:0] Dado1, Dado2;

// fio de leitura da memória de dados
wire [31:0] MemData;

// registrador monitorado para verificar corretude
wire [31:0] RegMonitorado;


// módulos

Registers bancoReg (
   .iCLK(clockCPU), .iRST(reset), .iRegWrite(EscreveReg), .iReadRegister1(rs1),
   .iReadRegister2(rs2), .iWriteData(DadoEscrita), .iWriteRegister(rd),
   .oReadData1(Dado1), .oReadData2(Dado2),
   .iRegDispSelect(RegIn), .oRegDisp(RegMonitorado)      // reg monitorado
);


// blocos de controle
Controle controle (
   .opcode(opcode), .Mem2Reg(Mem2Reg), .LeMem(LeMem), .EscreveMem(EscreveMem),
   .Branch(Branch), .OrigULA(OrigULA), .EscreveReg(EscreveReg), .opULA(ALUop)
);

ControleULA controleULA (
   .opULA(ALUop), .funct3(funct3), .funct7(funct7), .codULA(codULA)
);


ImmGen GeraImm(.iInstrucao(Instr), .oImm(Imm));


// multiplexadores
mux4 muxOrigULA (.entr0(Dado2), .entr1(Imm), .sel(OrigULA), .saida(OperadorULA));
mux4 muxEscrReg (.entr0(MemData), .entr1(SaidaULA), .sel(Mem2Reg), .saida(DadoEscrita));
mux4 muxOrigPC  (.entr0(PC4), .entr1(PCImm), .sel(Branch & Zero), .saida(PCEscrita));


// somadores
adder SomaPC4   (.iA(PC), .iB(32'd4), .out(PC4));
adder SomaPCImm (.iA(PC), .iB(Imm), .out(PCImm));


ALU ULA (
   .iControl(codULA), .iA(Dado1), .iB(OperadorULA), .oResult(SaidaULA), .Zero(Zero)
);


// Instanciação das memórias
ramI MemC (.address(PC[11:2]), .clock(clockMem), .data(), .wren(1'b0), .q(Instr));
ramD MemD (.address(SaidaULA[11:2]), .clock(clockMem), .data(Dados2), .wren(EscreveMem), .q(MemData));


always @(posedge clockCPU  or posedge reset)
begin
if(reset)
   PC <= 32'h0040_0000;
else
   PC <= PCEscrita;
end

endmodule
