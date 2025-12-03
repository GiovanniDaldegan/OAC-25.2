/*
 * Banco de registradores RV32
 * - 32 registradores de 32b
 * - Leitura assíncrona de dois registradores
 * - Escrita síncrona (com enable) de um registrador na descida do clock
 * - RESET síncrono na descida do clock
 * - Não escreve no registrador [0]
 * - Monitora um registrador de livre escolha para verificação
 * 
 * O valor padrão de sp (registrador [2]) 0x1001_03FC
 */

`ifndef PARAM
   `include "Parametros.v"
`endif

module BancoReg (
   input  logic         iCLK, iRST, iRegWrite,
   input  logic [4:0]   iReadRegister1, iReadRegister2, iWriteRegister,
   input  logic [31:0]  iWriteData,
   output logic [31:0]  oReadData1, oReadData2,
   
   // registrador monitorado
   input  logic [4:0]   iRegDispSelect,
   output logic [31:0]  oRegDisp
);

reg [31:0] registers [31:0];
parameter SPR=5'd2;                          // SP

reg [5:0] i;

initial begin
   for (i = 0; i <= 31; i = i + 32'b1) begin
      registers[i] = 32'b0;
   end
   
   registers[SPR] <= STACK_ADDRESS;
end


assign oRegDisp   = registers[iRegDispSelect];
assign oReadData1 = registers[iReadRegister1];
assign oReadData2 = registers[iReadRegister2];


always @(negedge iCLK) begin
   if (iRST) begin
      for (i = 0; i <= 31; i = i + 32'b1)
         registers[i] = 32'b0;
      
      registers[SPR] = STACK_ADDRESS;
   end
   else begin
      if(iRegWrite && (iWriteRegister != 5'b0))
         registers[iWriteRegister] <= iWriteData;
      
      i<=6'b0;                               // para não dar warning
   end
end

endmodule
