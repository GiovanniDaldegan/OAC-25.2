`ifndef PARAM
	`include "Parametros.v"
`endif

module Uniciclo (
	input logic clockCPU, clockMem,
	input logic reset,
	output logic [31:0] PC,
	output logic [31:0] Instr,
	input  logic [4:0] regin,
	output logic [31:0] regout
	);
	
	
	initial
		begin
			PC<=32'h0040_0000;
			Instr<=32'b0;
			regout<=32'b0;
		end
		
		wire [31:0] SaidaULA, Leitura2, MemData;
		wire EscreveMem;
		
//******************************************
// Aqui vai o seu código do seu processador



always @(posedge clockCPU  or posedge reset)
	if(reset)
		PC <= 32'h0040_0000;
	else
		PC <= PC + 32'd4;

		
		
assign EscreveMem = 1'b0;
assign SaidaULA = 32'b0;


// Instanciação das memórias
ramI MemC (.address(PC[11:2]), .clock(clockMem), .data(), .wren(1'b0), .q(Instr));
ramD MemD (.address(SaidaULA[11:2]), .clock(clockMem), .data(Leitura2), .wren(EscreveMem), .q(MemData));
		

	
		
//*****************************************	
			
endmodule
