module TopDE (
   input  logic        CLOCK, Reset,
   output logic        ClockDIV,
   output logic [31:0] PC, Instr,
   output logic [ 3:0] Estado,
   
   // registrador monitorado
   input  logic [ 4:0] Regin,
   output logic [31:0] Regout
);


initial
   ClockDIV <= 1'b1;

always @(*)
   ClockDIV <= ~CLOCK;
   
/*
Uniciclo UNI1 (.clockCPU(ClockDIV), .clockMem(CLOCK), .reset(Reset),
               .PC(PC), .Instr(Instr), .RegIn(Regin), .RegOut(Regout));

Multiciclo MULT1 (.clockCPU(CLOCK), .clockMem(CLOCK), .reset(Reset), .PC(PC),
                  .Instr(Instr), .estado(Estado), .regin(Regin), .regout(Regout));
*/

Pipeline PIP1 (.clockCPU(ClockDIV), .clockMem(CLOCK), .reset(Reset),
               .PC(PC), .Instr(Instr), .regin(Regin), .regout(Regout));

endmodule
