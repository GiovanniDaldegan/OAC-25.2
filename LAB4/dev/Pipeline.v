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

// fios da instrução
wire [6:0] opcode = Instr[ 6: 0];
wire [2:0] funct3 = Instr[14:12];
wire [6:0] funct7 = Instr[31:25];
wire [4:0] rs1    = Instr[19:15];
wire [4:0] rs2    = Instr[24:20];
wire [4:0] rd     = Instr[11: 7];

// fios de controle
wire LeMem, EscreveMem, EscreveReg, Jalr;
wire [1:0] OrigRd, OrigAULA, OrigBULA, opULA; // OrigPC depende de beq, jal (ID) e jalr (EX)
wire [4:0] codULA;

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
// IF_ID, ID_EX, EX_MEM, MEM_WB;

wire [31:0] SaidaULA, Leitura2,B;
wire EscreveMem;

wire [31:0] MemData;

assign EscreveMem = 1'b0;

// Módulos

ramI MemC (.address(PC[11:2]), .clock(clockMem), .data(), .wren(1'b0), .q(Instr));
ramD MemD (.address(SaidaULA[11:2]), .clock(clockMem), .data(B), .wren(EscreveMem), .q(MemData));


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
      PC <= PC+4;
end

endmodule
