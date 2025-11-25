`ifndef PARAM
   `include "Parametros.v"
`endif

module Multiciclo (
   input  logic        clockCPU, clockMem, reset,
   output logic [31:0] PC, Instr,
   output logic [ 3:0] estado,
   
   // registrador monitorado
   input  logic [ 4:0] regin,
   output logic [31:0] regout
);


// registradores
reg [31:0] PCBack, A, B, SaidaULA, RegDado;


// fios

// fios da instrução
wire [6:0] opcode = Instr[ 6: 0];
wire [2:0] funct3 = Instr[14:12];
wire [6:0] funct7 = Instr[31:25];
wire [4:0] rs1    = Instr[19:15];
wire [4:0] rs2    = Instr[24:20];
wire [4:0] rd     = Instr[11: 7];

// fios de controle
wire EscrevePC, EscrevePCCond, EscrevePCB, IouD, LeMem, EscreveMem, EscreveIR, EscreveReg;
wire [1:0] OrigPC, OrigRd, OrigAULA, OrigBULA, opULA;
wire [4:0] codULA;

// fios dos multiplexadores
wire [31:0] DadoEscrita, PCEscrita, OperadorULA;

// fio do gerador de imediatos
wire [31:0] Imm;

// fios da ULA
wire Zero;
wire [31:0] ResULA, AULA, BULA;

// fios de leitura do banco de registradores
wire [31:0] Dado1, Dado2;

// fios da memória
wire [31:0] Endereco, MemInstr, MemData;
reg  [31:0] MemLeitura;

// módulos

mux4sync muxOrigPC (
   .enable((EscrevePCCond && Zero) || EscrevePC), .entr0(ResULA), .entr1(SaidaULA),
   .sel(OrigPC),   .saida(PCEscrita)
);
mux4sync muxOrigRd (
   .enable(1'b1), .entr0(SaidaULA), .entr1(PC), .entr2(RegDado),
   .sel(OrigRd), .saida(DadoEscrita)
);
mux4 muxOrigEnder (.enable(1'b1), .entr0(PC),       .entr1(SaidaULA),                          .sel(IouD),     .saida(Endereco));
mux4 muxOrigA     (.enable(1'b1), .entr0(PCBack),   .entr1(A),        .entr2(PC),  .entr3(0),  .sel(OrigAULA), .saida(AULA));
mux4 muxOrigB     (.enable(1'b1), .entr0(B),        .entr1(32'd4),    .entr2(Imm),             .sel(OrigBULA), .saida(BULA));


ControleMulti Controle (
   .opcode(opcode),
   .CLK(clockCPU), .RST(reset), .Zero(Zero),
   .EscrevePC(EscrevePC), .EscrevePCCond(EscrevePCCond), .EscrevePCB(EscrevePCB), .IouD(IouD), .EscreveIR(EscreveIR),
   .LeMem(LeMem), .EscreveMem(EscreveMem), .EscreveReg(EscreveReg),
   .OrigPC(OrigPC), .OrigRd(OrigRd), .OrigAULA(OrigAULA), .OrigBULA(OrigBULA), .opULA(opULA),
   .estado(estado)
);

ControleULA ControleULA (
   .opULA(opULA), .funct3(funct3), .funct7(funct7), .codULA(codULA)
);

ImmGen ImmGen (.iInstrucao(Instr), .oImm(Imm));

BancoReg BancoReg (
   .iCLK(clockCPU), .iRST(reset), .iRegWrite(EscreveReg),
   .iReadRegister1(rs1), .iReadRegister2(rs2), .iWriteRegister(rd),
   .iWriteData(DadoEscrita), .oReadData1(Dado1), .oReadData2(Dado2),
   .iRegDispSelect(regin), .oRegDisp(regout)
);

ULA ULA (.iControl(codULA), .iA(AULA), .iB(BULA), .oResult(ResULA), .Zero(Zero));

//memory_unit ram (.address(Endereco[11:2]), .clock(clockMem), .data(B), .wren(EscreveMem), .q(MemLeitura));

ramI MemC (.address(Endereco[11:2]), .clock(clockMem), .data(B), .wren(EscreveMem && ~Endereco[28]), .q(MemInstr));
ramD MemD (.address(Endereco[11:2]), .clock(clockMem), .data(B), .wren(EscreveMem && Endereco[28]), .q(MemData));


initial begin
   PC     <= TEXT_ADDRESS;
   PCBack <= TEXT_ADDRESS;
   Instr  <= 32'b0;
   estado <= 4'b0;
   regout <= 32'b0;
end


always @(posedge clockCPU) begin //or posedge reset
   if (reset)
      PC     <= TEXT_ADDRESS;
   else begin
      MemLeitura  <= Endereco[28] ? MemData : MemInstr;
      RegDado     <= MemData;
      
      PC       <= PCEscrita;
      A        <= Dado1;
      B        <= Dado2;
      SaidaULA <= ResULA;
   end
end

always @(*) begin
   if (reset) begin
      PCBack <= TEXT_ADDRESS;
      Instr  <= 32'b0;
   end
   else begin
      if (EscrevePCB)
         PCBack   <= PC;
      if (EscreveIR)
         Instr <= MemInstr;
   end
end

endmodule
