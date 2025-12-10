

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
wire LeMem, EscreveMem, EscreveReg, beq, jal, jalr, Igual;
wire [1:0] OrigReg, OrigAULA, OrigBULA, opULA, OrigPC;
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


// registradores de transição (descontinuado)

// opção 1 - regs gigantes com seções
/*
reg [ 95:0] IF_ID;   // 0:31 PC,  32:63 PC4, 64:95 Instr
reg [154:0] ID_EX;   // 0:31 PC4, 32:36 rd,  37:68 Dado1,  69:100 Dado2,      101:132 Imm, 133:135 WB, 136:137 MEM, 138:154 EX
reg [137:0] EX_MEM;  // 0:31 PC4, 32:36 rd,  37:68 ResULA, 69:100 Dado2,      101:132 Imm, 133:135 WB, 136:137 MEM
reg [135:0] MEM_WB;  // 0:31 PC4, 32:36 rd,  37:68 ResULA, 69:100 MemLeitura, 101:132 Imm, 133:135 WB
*/

// sinais EX  0:1 OrigAULA    2:3 OrigBULA    4:5 opULA  6 jalr   7:9 funct3  10:16 funct7
// sinais MEM 0   LeMem       1   EscreveMem
// sinais WB  0   EscreveReg  1:2 OrigReg


// opção 2 - regs avulsos
/*
reg [31:0] IF_ID_PC,//            = IF_ID[`rIF_ID_PC],
            IF_ID_PC4,//           = IF_ID[`rIF_ID_PC4],
            IF_ID_Instr;//         = IF_ID[`rIF_ID_Instr];

reg [31:0] ID_EX_PC4,//           = ID_EX[31:0],
            ID_EX_Dado1,//         = ID_EX[`rID_EX_Dado1],
            ID_EX_Dado2,//         = ID_EX[`rID_EX_Dado2],
            ID_EX_Imm;//           = ID_EX[`rID_EX_Imm];
reg [4:0]  ID_EX_rd;//            = ID_EX[`rID_EX_rd];
reg [2:0]  ID_EX_WB;//            = ID_EX[`rID_EX_WB];
reg [1:0]  ID_EX_MEM;//           = ID_EX[`rID_EX_MEM];
reg [16:0] ID_EX_EX;//            = ID_EX[`rID_EX_EX];

reg [31:0] EX_MEM_PC4,//          = EX_MEM[`rEX_MEM_PC4],
            EX_MEM_ResULA,//       = EX_MEM[`rEX_MEM_ResULA],
            EX_MEM_Dado2,//        = EX_MEM[`rEX_MEM_Dado2],
            EX_MEM_Imm;//          = EX_MEM[`rID_EX_Imm];
reg [4:0]  EX_MEM_rd;//           = EX_MEM[`rEX_MEM_rd];
reg [2:0]  EX_MEM_WB;//           = EX_MEM[`rEX_MEM_WB];
reg [1:0]  EX_MEM_MEM;//          = EX_MEM[`rEX_MEM_MEM];

reg [31:0] MEM_WB_PC4,//          = MEM_WB[`rMEM_WB_PC4],
            MEM_WB_ResULA,//       = MEM_WB[`rMEM_WB_ResULA],
            MEM_WB_MemLeitura,//   = MEM_WB[`rMEM_WB_MemLeitura],
            MEM_WB_Imm;//          = MEM_WB[`rMEM_WB_Imm];
reg [4:0]  MEM_WB_rd;//           = MEM_WB[`rMEM_WB_rd];
reg [2:0]  MEM_WB_WB;//           = MEM_WB[`rMEM_WB_WB];
*/

// opção 2 - regs dentro de módulos
// fios dos registradores de transição
wire [31:0] IF_ID_PC, IF_ID_PC4, IF_ID_Instr, ID_EX_PC4, ID_EX_Dado1, ID_EX_Dado2, ID_EX_Imm, EX_MEM_PC4,
            EX_MEM_ResULA, EX_MEM_Dado2, EX_MEM_Imm, MEM_WB_PC4, MEM_WB_ResULA, MEM_WB_MemLeitura, MEM_WB_Imm;
wire [ 4:0] ID_EX_rd, EX_MEM_rd, MEM_WB_rd;
wire [ 2:0] ID_EX_WB, EX_MEM_WB, MEM_WB_WB;
wire [ 1:0] ID_EX_MEM, EX_MEM_MEM;
wire [16:0] ID_EX_EX;

// módulos

// registradores de transição

IF_ID  IF_ID (
   .clock(clockCPU), .reset(reset),
   .iPC(PC), .iPC4(PC4), .iInstr(Instr),
   .oPC(IF_ID_PC), .oPC4(IF_ID_PC4), .oInstr(IF_ID_Instr)
);
ID_EX  ID_EX (
   .clock(clockCPU), .reset(reset),
   .iPC4(IF_ID_PC4), .iDado1(Dado1), .iDado2(Dado2), .iImm(Imm), .ird(rd),
   .iWB({EscreveReg, OrigReg}), .iMEM({LeMem, EscreveMem}), .iEX({OrigAULA, OrigBULA, opULA, jalr}),
   
   .oPC4(ID_EX_PC4), .oDado1(ID_EX_Dado1), .oDado2(ID_EX_Dado2), .oImm(ID_EX_Imm), .ord(ID_EX_rd),
   .oWB(ID_EX_WB), .oMEM(ID_EX_MEM), .oEX(ID_EX_EX)
);
EX_MEM EX_MEM (
   .clock(clockCPU), .reset(reset),
   .iPC4(ID_EX_PC4), .iResULA(ResULA), .iDado2(ID_EX_Dado2), .iImm(ID_EX_Imm), .ird(ID_EX_rd),
   .iWB(ID_EX_WB), .iMEM(ID_EX_MEM),
   
   .oPC4(EX_MEM_PC4), .oResULA(EX_MEM_ResULA), .oDado2(EX_MEM_Dado2), .oImm(EX_MEM_Imm), .ord(EX_MEM_rd),
   .oWB(EX_MEM_WB), .oMEM(EX_MEM_MEM)
);
MEM_WB MEM_WB (
   .clock(clockCPU), .reset(reset),
   .iPC4(EX_MEM_PC4), .iResULA(EX_MEM_ResULA), .iMemLeitura(MemLeitura), .iImm(EX_MEM_Imm), .ird(EX_MEM_rd),
   .iWB(EX_MEM_WB),
   
   .oPC4(MEM_WB_PC4), .oResULA(MEM_WB_ResULA), .oMemLeitura(MEM_WB_MemLeitura), .oImm(MEM_WB_Imm), .ord(MEM_WB_rd),
   .oWB(MEM_WB_WB)
);


adder SomaPC4   (.iA(PC),        .iB(32'd4), .out(PC4));
adder SomaPCImm (.iA(IF_ID_PC),  .iB(Imm),   .out(PCImm));

mux4 muxOrigPC (.entr0(PC4),           .entr1(PCImm),   .entr2(ResULA),   .sel(OrigPC),           .saida(PCEscrita));
mux4 muxOrigA  (.entr0(ID_EX_Dado1),   .entr1(32'b0),                     .sel(ID_EX_EX[1:0]),   .saida(AULA));
mux4 muxOrigB  (.entr0(ID_EX_Dado2),   .entr1(Imm),                       .sel(ID_EX_EX[3:2]),   .saida(BULA));
mux4 muxOrigReg(
   .entr0(MEM_WB_ResULA), .entr1(MEM_WB_MemLeitura), .entr2(MEM_WB_PC4), .entr3(MEM_WB_Imm),
   .sel(MEM_WB_WB[2:1]), .saida(DadoEscrReg)
);

ControlePipe Controle (
   .opcode(opcode), .reset(reset),
   .EscreveReg(EscreveReg), .LeMem(LeMem), .EscreveMem(EscreveMem),
   .jal(jal), .beq(beq), .jalr(jalr),
   .OrigReg(OrigReg), .OrigAULA(OrigAULA), .OrigBULA(OrigBULA), .opULA(opULA)
);

ControleULA ControleULA (.opULA(ID_EX_EX[5:4]), .funct3(ID_EX_EX[9:7]), .funct7(ID_EX_EX[16:0]), .codULA(codULA));

ImmGen ImmGen (.iInstrucao(IF_ID_Instr), .oImm(Imm));

BancoReg BancoReg (
   .iCLK(clockCPU), .iRST(reset), .iRegWrite(MEM_WB_WB[0]),
   .iReadRegister1(rs1), .iReadRegister2(rs2), .iWriteRegister(MEM_WB_rd), .iWriteData(DadoEscrReg),
   .oReadData1(Dado1), .oReadData2(Dado2),
   
   .iRegDispSelect(regin), .oRegDisp(regout)    // reg monitorado
);

ULA ULA (.iControl(codULA), .iA(AULA), .iB(BULA), .oResult(ResULA));

// memórias
ramI MemI (.address(PC[11:2]),            .clock(clockMem), .data(),            .wren(1'b0),          .q(Instr));
ramD MemD (.address(EX_MEM_ResULA[11:2]), .clock(clockMem), .data(EX_MEM_Dado2), .wren(EX_MEM_MEM[1]), .q(MemLeitura));


initial begin
   PC     <= 32'h0040_0000;
   Instr  <= 32'b0;
   regout <= 32'b0;
   
   // opção 1
   /*
   IF_ID  <= 95'b0;
   ID_EX  <= 154'b0;
   EX_MEM <= 137'b0;
   MEM_WB <= 135'b0;
   */
end

/* opção 1
assign IF_ID_PC = IF_ID[`rIF_ID_PC];
assign IF_ID_PC4 = IF_ID[`rIF_ID_PC4];   // NOTE checar se isso funciona mesmo
assign IF_ID_Instr = IF_ID[`rIF_ID_Instr];

assign ID_EX_PC4 = ID_EX[31:0];
assign ID_EX_Dado1 = ID_EX[`rID_EX_Dado1],
       ID_EX_Dado2 = ID_EX[`rID_EX_Dado2],
       ID_EX_Imm = ID_EX[`rID_EX_Imm],
       ID_EX_rd = ID_EX[`rID_EX_rd],
       ID_EX_WB = ID_EX[`rID_EX_WB],
       ID_EX_MEM = ID_EX[`rID_EX_MEM],
       ID_EX_EX = ID_EX[`rID_EX_EX],

       EX_MEM_PC4 = EX_MEM[`rEX_MEM_PC4],
       EX_MEM_ResULA = EX_MEM[`rEX_MEM_ResULA],
       EX_MEM_Dado2 = EX_MEM[`rEX_MEM_Dado2],
       EX_MEM_Imm = EX_MEM[`rID_EX_Imm],
       EX_MEM_rd = EX_MEM[`rEX_MEM_rd],
       EX_MEM_WB = EX_MEM[`rEX_MEM_WB],
       EX_MEM_MEM = EX_MEM[`rEX_MEM_MEM],

       MEM_WB_PC4 = MEM_WB[`rMEM_WB_PC4],
       MEM_WB_ResULA = MEM_WB[`rMEM_WB_ResULA],
       MEM_WB_MemLeitura = MEM_WB[`rMEM_WB_MemLeitura],
       MEM_WB_Imm = MEM_WB[`rMEM_WB_Imm],
       MEM_WB_rd = MEM_WB[`rMEM_WB_rd],
       MEM_WB_WB = MEM_WB[`rMEM_WB_WB];
*/

always @(posedge clockCPU  or posedge reset) begin
   if (reset) begin
      PC     <= 32'h0040_0000;
      Instr  <= 32'b0;
      regout <= 32'b0;
      
      // opção 1
      /*
      IF_ID  <= 0;
      ID_EX  <= 0;
      EX_MEM <= 0;
      MEM_WB <= 0;
      */
   end
   else begin
      // opção 1
      /*
      IF_ID  [`rIF_ID_PC]           <= PC;
      IF_ID  [`rIF_ID_PC4]          <= PC4;
      IF_ID  [`rIF_ID_Instr]        <= Instr;
      
      ID_EX  [`rID_EX_rd]           <= rd;
      ID_EX  [`rID_EX_PC4]          <= IF_ID_PC4;
      ID_EX  [`rID_EX_Dado1]        <= Dado1;
      ID_EX  [`rID_EX_Dado2]        <= Dado2;
      ID_EX  [`rID_EX_Imm]          <= Imm;
      ID_EX  [`rID_EX_WB]           <= {EscreveReg, OrigReg};   //WB
      ID_EX  [`rID_EX_MEM]          <= {LeMem, EscreveMem};     //MEM
      ID_EX  [`rID_EX_EX]           <= {OrigAULA, OrigBULA, opULA, jalr}; //EX

      EX_MEM [`rEX_MEM_PC4]         <= ID_EX_PC4;
      EX_MEM [`rEX_MEM_rd]          <= ID_EX_rd;
      EX_MEM [`rEX_MEM_ResULA]      <= ResULA;
      EX_MEM [`rEX_MEM_Dado2]       <= ID_EX_Dado2;
      EX_MEM [`rEX_MEM_Imm]         <= ID_EX_Imm;
      EX_MEM [`rEX_MEM_WB]          <= ID_EX_WB;
      EX_MEM [`rEX_MEM_MEM]         <= ID_EX_MEM;
      
      MEM_WB [`rMEM_WB_PC4]         <= EX_MEM_PC4;
      MEM_WB [`rMEM_WB_rd]          <= EX_MEM_rd;
      MEM_WB [`rMEM_WB_ResULA]      <= EX_MEM_ResULA;
      MEM_WB [`rMEM_WB_MemLeitura]  <= MemLeitura;
      MEM_WB [`rMEM_WB_Imm]         <= EX_MEM_Imm;
      MEM_WB [`rMEM_WB_WB]          <= EX_MEM_WB;
      */
      
      // opção 2
      /*
      IF_ID_PC           <= PC;
      IF_ID_PC4          <= PC4;
      IF_ID_Instr        <= Instr;
            
      ID_EX_PC4          <= IF_ID_PC4;
      ID_EX_rd           <= rd;
      ID_EX_Dado1        <= Dado1;
      ID_EX_Dado2        <= Dado2;
      ID_EX_Imm          <= Imm;
      ID_EX_WB           <= {EscreveReg, OrigReg};
      ID_EX_MEM          <= {LeMem, EscreveMem};
      ID_EX_EX           <= {OrigAULA, OrigBULA, opULA, jalr};

      EX_MEM_PC4         <= ID_EX_PC4;
      EX_MEM_rd          <= ID_EX_rd;
      EX_MEM_ResULA      <= ResULA;
      EX_MEM_Dado2       <= ID_EX_Dado2;
      EX_MEM_Imm         <= ID_EX_Imm;
      EX_MEM_WB          <= ID_EX_WB;
      EX_MEM_MEM         <= ID_EX_MEM;
      
      MEM_WB_PC4         <= EX_MEM_PC4;
      MEM_WB_rd          <= EX_MEM_rd;
      MEM_WB_ResULA      <= EX_MEM_ResULA;
      MEM_WB_MemLeitura  <= MemLeitura;
      MEM_WB_Imm         <= EX_MEM_Imm;
      MEM_WB_WB          <= EX_MEM_WB;
      */
      
      OrigPC <= {ID_EX_EX[6], (((Igual && beq) || jal) && ~ID_EX_EX[6])}; // 00 PC+4, 01 PC+Imm (beq, jal), 10 Dado1+Imm (jalr)
      PC     <= PCEscrita;
   end
end

endmodule
