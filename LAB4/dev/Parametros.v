`ifndef PARAM
 `define PARAM

parameter
   /* Operacoes da ULA */
    ZERO        = 32'd0,
    OPAND       = 5'd0,
    OPOR        = 5'd1,
    OPXOR       = 5'd2,
    OPADD       = 5'd3,
    OPSUB       = 5'd4,
    OPSLT       = 5'd5,
    OPSLTU      = 5'd6,
    OPSLL       = 5'd7,
    OPSRL       = 5'd8,
    OPSRA       = 5'd9,
    OPLUI       = 5'd10,
    OPMUL       = 5'd11,
    OPMULH      = 5'd12,
    OPMULHU     = 5'd13,
    OPMULHSU    = 5'd14,
    OPDIV       = 5'd15,
    OPDIVU      = 5'd16,
    OPREM       = 5'd17,
    OPREMU      = 5'd18,
    OPNULL      = 5'd31, // saída ZERO

    /*OpCodes */
    OPC_LOAD        = 7'b0000011,
    OPC_OPIMM       = 7'b0010011,
    OPC_STORE       = 7'b0100011,
    OPC_RTYPE       = 7'b0110011,
    OPC_BRANCH      = 7'b1100011,
    OPC_JALR        = 7'b1100111,
    OPC_JAL         = 7'b1101111,
    OPC_LUI         = 7'b0110111,

    /* Funct 7 */
    FUNCT7_ADD      = 7'b0000000,
    FUNCT7_SUB      = 7'b0100000,
    FUNCT7_SLT      = 7'b0000000,
    FUNCT7_OR       = 7'b0000000,
    FUNCT7_AND      = 7'b0000000,

    /* Funct 3 */
    FUNCT3_LW       = 3'b010,
    FUNCT3_SW       = 3'b010,
    FUNCT3_ADD      = 3'b000,
    FUNCT3_SUB      = 3'b000,
    FUNCT3_SLT      = 3'b010,
    FUNCT3_OR       = 3'b110,
    FUNCT3_AND      = 3'b111,
    FUNCT3_BEQ      = 3'b000,
    FUNCT3_JALR     = 3'b000,


    /* Endereços */
    TEXT_ADDRESS    = 32'h0040_0000,
    DATA_ADDRESS    = 32'h1001_0000,
    STACK_ADDRESS   = 32'h1001_03FC,
    GP              = DATA_ADDRESS;

/* Seções dos registradores de transição */
// IF_ID:  0:31 PC,  32:63 PC4, 64:95 Instr
// ID_EX:  0:31 PC4, 32:36 rd,  37:68 Dado1,  69:100 Dado2,      101:132 Imm, 133:135 WB, 136:137 MEM, 138:144 EX
// EX_MEM: 0:31 PC4, 32:36 rd,  37:68 ResULA, 69:100 Dado2,      101:103 WB,  104:105 MEM
// MEM_WB: 0:31 PC4, 32:36 rd,  37:68 ResULA, 69:100 MemLeitura, 101:103 WB

`define rIF_ID_PC            0: 31
`define rIF_ID_PC4          32: 63
`define rIF_ID_Instr        64: 95

`define rID_EX_PC4           0: 31
`define rID_EX_rd           32: 36
`define rID_EX_Dado1        37: 68
`define rID_EX_Dado2        69:100
`define rID_EX_Imm         101:132
`define rID_EX_WB          133:135
`define rID_EX_MEM         136:137
`define rID_EX_EX          138:144

`define rEX_MEM_PC4          0: 31
`define rEX_MEM_rd          32: 36
`define rEX_MEM_ResULA      37: 68
`define rEX_MEM_Dado2       69:100
`define rEX_MEM_WB         101:103
`define rEX_MEM_MEM        104:105

`define rMEM_WB_PC4          0: 31
`define rMEM_WB_rd          32: 36
`define rMEM_WB_ResULA      37: 68
`define rMEM_WB_MemLeitura  69:100
`define rMEM_WB_WB         101:103

`endif
