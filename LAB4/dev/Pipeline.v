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

// registradores de transição
// IF_ID, ID_EX, EX_MEM, MEM_WB;

wire [31:0] SaidaULA, Leitura2,B;
wire EscreveMem;

wire [31:0] wIouD, MemData;

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
